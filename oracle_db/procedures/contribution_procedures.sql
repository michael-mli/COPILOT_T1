-- CAAT Pension Database - Contribution Related Stored Procedures
-- Procedures for managing member and employer contributions

-- Procedure to process monthly contributions
CREATE OR REPLACE PROCEDURE sp_process_monthly_contributions (
    p_employer_id IN NUMBER,
    p_period_start IN DATE,
    p_period_end IN DATE,
    p_processed_count OUT NUMBER,
    p_total_amount OUT NUMBER,
    p_result OUT VARCHAR2
) IS
    v_member_count NUMBER := 0;
    v_total_contributions NUMBER := 0;
    
    CURSOR c_active_members IS
        SELECT member_id, salary_annual, contribution_rate
        FROM members
        WHERE employer_id = p_employer_id 
        AND status = 'ACTIVE'
        AND hire_date <= p_period_end;
        
BEGIN
    p_processed_count := 0;
    p_total_amount := 0;
    
    -- Process contributions for each active member
    FOR member_rec IN c_active_members LOOP
        DECLARE
            v_monthly_salary NUMBER;
            v_member_contribution NUMBER;
            v_employer_contribution NUMBER;
            v_contribution_rate NUMBER;
        BEGIN
            -- Calculate monthly salary
            v_monthly_salary := member_rec.salary_annual / 12;
            v_contribution_rate := NVL(member_rec.contribution_rate, 0.092); -- Default 9.2%
            
            -- Calculate contributions
            v_member_contribution := ROUND(v_monthly_salary * v_contribution_rate, 2);
            v_employer_contribution := ROUND(v_monthly_salary * v_contribution_rate, 2); -- Employer matches
            
            -- Insert member contribution
            INSERT INTO contributions (
                member_id, employer_id, contribution_period_start, contribution_period_end,
                contribution_type, pensionable_earnings, contribution_amount, contribution_rate,
                payment_status
            ) VALUES (
                member_rec.member_id, p_employer_id, p_period_start, p_period_end,
                'MEMBER', v_monthly_salary, v_member_contribution, v_contribution_rate,
                'PROCESSED'
            );
            
            -- Insert employer contribution
            INSERT INTO contributions (
                member_id, employer_id, contribution_period_start, contribution_period_end,
                contribution_type, pensionable_earnings, contribution_amount, contribution_rate,
                payment_status
            ) VALUES (
                member_rec.member_id, p_employer_id, p_period_start, p_period_end,
                'EMPLOYER', v_monthly_salary, v_employer_contribution, v_contribution_rate,
                'PROCESSED'
            );
            
            p_processed_count := p_processed_count + 1;
            v_total_contributions := v_total_contributions + v_member_contribution + v_employer_contribution;
            
        EXCEPTION
            WHEN OTHERS THEN
                -- Log error but continue processing other members
                DBMS_OUTPUT.PUT_LINE('Error processing member ' || member_rec.member_id || ': ' || SQLERRM);
        END;
    END LOOP;
    
    p_total_amount := v_total_contributions;
    p_result := 'SUCCESS: Processed ' || p_processed_count || ' members, Total: $' || 
                TO_CHAR(p_total_amount, '999,999,999.99');
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_result := 'ERROR: ' || SQLERRM;
END sp_process_monthly_contributions;
/

-- Procedure to calculate and update investment earnings
CREATE OR REPLACE PROCEDURE sp_update_investment_earnings (
    p_fiscal_year IN NUMBER,
    p_investment_return_rate IN NUMBER, -- Annual return rate as decimal (e.g., 0.08 for 8%)
    p_updated_count OUT NUMBER,
    p_total_earnings OUT NUMBER,
    p_result OUT VARCHAR2
) IS
    v_total_earnings NUMBER := 0;
    v_updated_count NUMBER := 0;
    
    CURSOR c_contributions IS
        SELECT contribution_id, contribution_amount, contribution_date
        FROM contributions
        WHERE fiscal_year = p_fiscal_year
        AND payment_status = 'PROCESSED'
        AND interest_earned IS NULL;
        
BEGIN
    -- Calculate investment earnings for each contribution
    FOR contrib_rec IN c_contributions LOOP
        DECLARE
            v_days_invested NUMBER;
            v_interest_earned NUMBER;
        BEGIN
            -- Calculate days the contribution has been invested
            v_days_invested := SYSDATE - contrib_rec.contribution_date;
            
            -- Calculate proportional interest earned
            v_interest_earned := ROUND(
                contrib_rec.contribution_amount * 
                (p_investment_return_rate * v_days_invested / 365), 2
            );
            
            -- Update contribution with interest earned
            UPDATE contributions
            SET interest_earned = v_interest_earned,
                updated_date = SYSDATE
            WHERE contribution_id = contrib_rec.contribution_id;
            
            v_total_earnings := v_total_earnings + v_interest_earned;
            v_updated_count := v_updated_count + 1;
            
        END;
    END LOOP;
    
    p_updated_count := v_updated_count;
    p_total_earnings := v_total_earnings;
    p_result := 'SUCCESS: Updated ' || p_updated_count || ' contributions with $' ||
                TO_CHAR(p_total_earnings, '999,999,999.99') || ' in earnings';
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_result := 'ERROR: ' || SQLERRM;
END sp_update_investment_earnings;
/

-- Function to get member contribution summary
CREATE OR REPLACE FUNCTION fn_get_member_contribution_summary (
    p_member_id IN NUMBER,
    p_start_date IN DATE DEFAULT NULL,
    p_end_date IN DATE DEFAULT NULL
) RETURN VARCHAR2 IS
    v_summary VARCHAR2(2000);
    v_total_member NUMBER := 0;
    v_total_employer NUMBER := 0;
    v_total_interest NUMBER := 0;
    v_contribution_count NUMBER := 0;
    v_start_date DATE;
    v_end_date DATE;
BEGIN
    -- Set default date range if not provided
    v_start_date := NVL(p_start_date, ADD_MONTHS(SYSDATE, -12));
    v_end_date := NVL(p_end_date, SYSDATE);
    
    -- Get contribution summary
    SELECT 
        NVL(SUM(CASE WHEN contribution_type = 'MEMBER' THEN contribution_amount ELSE 0 END), 0),
        NVL(SUM(CASE WHEN contribution_type = 'EMPLOYER' THEN contribution_amount ELSE 0 END), 0),
        NVL(SUM(interest_earned), 0),
        COUNT(*)
    INTO v_total_member, v_total_employer, v_total_interest, v_contribution_count
    FROM contributions
    WHERE member_id = p_member_id
    AND contribution_date BETWEEN v_start_date AND v_end_date
    AND payment_status = 'PROCESSED';
    
    -- Build summary string
    v_summary := 'Member ID: ' || p_member_id ||
                ' | Period: ' || TO_CHAR(v_start_date, 'YYYY-MM-DD') || ' to ' || TO_CHAR(v_end_date, 'YYYY-MM-DD') ||
                ' | Contributions: ' || v_contribution_count ||
                ' | Member: $' || TO_CHAR(v_total_member, '999,999.99') ||
                ' | Employer: $' || TO_CHAR(v_total_employer, '999,999.99') ||
                ' | Interest: $' || TO_CHAR(v_total_interest, '999,999.99') ||
                ' | Total: $' || TO_CHAR(v_total_member + v_total_employer + v_total_interest, '999,999.99');
    
    RETURN v_summary;
    
EXCEPTION
    WHEN OTHERS THEN
        RETURN 'Error retrieving contribution summary: ' || SQLERRM;
END fn_get_member_contribution_summary;
/

-- Procedure to process catch-up contributions for new members
CREATE OR REPLACE PROCEDURE sp_process_catchup_contributions (
    p_member_id IN NUMBER,
    p_retroactive_months IN NUMBER,
    p_result OUT VARCHAR2
) IS
    v_member_info members%ROWTYPE;
    v_monthly_salary NUMBER;
    v_contribution_rate NUMBER;
    v_month_start DATE;
    v_month_end DATE;
    v_processed_months NUMBER := 0;
BEGIN
    -- Get member information
    SELECT *
    INTO v_member_info
    FROM members
    WHERE member_id = p_member_id;
    
    -- Calculate monthly salary and contribution rate
    v_monthly_salary := v_member_info.salary_annual / 12;
    v_contribution_rate := NVL(v_member_info.contribution_rate, 0.092);
    
    -- Process catch-up contributions for each month
    FOR i IN 1..p_retroactive_months LOOP
        v_month_start := ADD_MONTHS(TRUNC(SYSDATE, 'MM'), -i);
        v_month_end := LAST_DAY(v_month_start);
        
        -- Check if contributions already exist for this period
        DECLARE
            v_existing_count NUMBER;
        BEGIN
            SELECT COUNT(*)
            INTO v_existing_count
            FROM contributions
            WHERE member_id = p_member_id
            AND contribution_period_start = v_month_start;
            
            IF v_existing_count = 0 THEN
                -- Insert member catch-up contribution
                INSERT INTO contributions (
                    member_id, employer_id, contribution_period_start, contribution_period_end,
                    contribution_type, pensionable_earnings, contribution_amount, contribution_rate,
                    payment_status, notes
                ) VALUES (
                    p_member_id, v_member_info.employer_id, v_month_start, v_month_end,
                    'MEMBER', v_monthly_salary, ROUND(v_monthly_salary * v_contribution_rate, 2), v_contribution_rate,
                    'PROCESSED', 'Catch-up contribution'
                );
                
                -- Insert employer catch-up contribution
                INSERT INTO contributions (
                    member_id, employer_id, contribution_period_start, contribution_period_end,
                    contribution_type, pensionable_earnings, contribution_amount, contribution_rate,
                    payment_status, notes
                ) VALUES (
                    p_member_id, v_member_info.employer_id, v_month_start, v_month_end,
                    'EMPLOYER', v_monthly_salary, ROUND(v_monthly_salary * v_contribution_rate, 2), v_contribution_rate,
                    'PROCESSED', 'Catch-up contribution'
                );
                
                v_processed_months := v_processed_months + 1;
            END IF;
        END;
    END LOOP;
    
    p_result := 'SUCCESS: Processed ' || v_processed_months || ' months of catch-up contributions';
    COMMIT;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_result := 'ERROR: Member not found';
    WHEN OTHERS THEN
        ROLLBACK;
        p_result := 'ERROR: ' || SQLERRM;
END sp_process_catchup_contributions;
/
