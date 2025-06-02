-- CAAT Pension Database - Pension Calculation Stored Procedures
-- Procedures for calculating pension benefits and projections

-- Procedure to calculate annual pension benefit
CREATE OR REPLACE PROCEDURE sp_calculate_annual_pension (
    p_member_id IN NUMBER,
    p_retirement_date IN DATE,
    p_annual_pension OUT NUMBER,
    p_monthly_pension OUT NUMBER,
    p_result OUT VARCHAR2
) IS
    v_member_info members%ROWTYPE;
    v_years_of_service NUMBER;
    v_total_contributions NUMBER;
    v_best_average_salary NUMBER;
    v_pension_factor NUMBER := 0.02; -- 2% per year of service
    v_early_retirement_reduction NUMBER := 0;
    v_age_at_retirement NUMBER;
    v_full_retirement_age NUMBER := 65;
BEGIN
    -- Get member information
    SELECT *
    INTO v_member_info
    FROM members
    WHERE member_id = p_member_id;
    
    -- Calculate years of service at retirement
    v_years_of_service := ROUND((p_retirement_date - v_member_info.hire_date) / 365.25, 2);
    
    -- Calculate age at retirement
    v_age_at_retirement := ROUND((MONTHS_BETWEEN(p_retirement_date, v_member_info.date_of_birth) / 12), 1);
    
    -- Get total contributions
    SELECT NVL(SUM(net_contribution), 0)
    INTO v_total_contributions
    FROM contributions
    WHERE member_id = p_member_id AND payment_status = 'PROCESSED';
    
    -- Calculate best average salary (simplified - using current salary)
    -- In reality, this would be best 5 consecutive years
    v_best_average_salary := NVL(v_member_info.salary_annual, 0);
    
    -- Apply early retirement reduction if applicable
    IF v_age_at_retirement < v_full_retirement_age THEN
        v_early_retirement_reduction := (v_full_retirement_age - v_age_at_retirement) * 0.05; -- 5% per year
        v_early_retirement_reduction := LEAST(v_early_retirement_reduction, 0.30); -- Max 30% reduction
    END IF;
    
    -- Calculate annual pension using defined benefit formula
    -- Formula: Years of Service × Pension Factor × Best Average Salary
    p_annual_pension := ROUND(
        v_years_of_service * v_pension_factor * v_best_average_salary * 
        (1 - v_early_retirement_reduction), 2
    );
    
    -- Ensure minimum pension based on contributions if higher
    DECLARE
        v_contribution_based_pension NUMBER;
    BEGIN
        v_contribution_based_pension := v_total_contributions * 0.065; -- 6.5% annual withdrawal rate
        p_annual_pension := GREATEST(p_annual_pension, v_contribution_based_pension);
    END;
    
    -- Calculate monthly pension
    p_monthly_pension := ROUND(p_annual_pension / 12, 2);
    
    -- Insert calculation record
    INSERT INTO pension_calculations (
        member_id, calculation_type, effective_date, retirement_date,
        age_at_calculation, years_of_service, total_contributions,
        best_average_salary, pension_factor, annual_pension_amount,
        monthly_pension_amount, early_retirement_reduction,
        calculation_status, calculation_method
    ) VALUES (
        p_member_id, 'RETIREMENT_ESTIMATE', SYSDATE, p_retirement_date,
        v_age_at_retirement, v_years_of_service, v_total_contributions,
        v_best_average_salary, v_pension_factor, p_annual_pension,
        p_monthly_pension, v_early_retirement_reduction,
        'FINAL', 'DEFINED_BENEFIT_FORMULA'
    );
    
    p_result := 'SUCCESS: Pension calculated - Annual: $' || TO_CHAR(p_annual_pension, '999,999.99') ||
                ', Monthly: $' || TO_CHAR(p_monthly_pension, '999,999.99');
    
    COMMIT;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_result := 'ERROR: Member not found';
    WHEN OTHERS THEN
        ROLLBACK;
        p_result := 'ERROR: ' || SQLERRM;
END sp_calculate_annual_pension;
/

-- Procedure to calculate termination benefits
CREATE OR REPLACE PROCEDURE sp_calculate_termination_benefit (
    p_member_id IN NUMBER,
    p_termination_date IN DATE,
    p_lump_sum_value OUT NUMBER,
    p_transfer_value OUT NUMBER,
    p_result OUT VARCHAR2
) IS
    v_member_info members%ROWTYPE;
    v_total_contributions NUMBER;
    v_member_contributions NUMBER;
    v_employer_contributions NUMBER;
    v_investment_earnings NUMBER;
    v_years_of_service NUMBER;
    v_vesting_percentage NUMBER;
    v_commutation_factor NUMBER := 15.5; -- Actuarial factor
BEGIN
    -- Get member information
    SELECT *
    INTO v_member_info
    FROM members
    WHERE member_id = p_member_id;
    
    -- Calculate years of service
    v_years_of_service := ROUND((p_termination_date - v_member_info.hire_date) / 365.25, 2);
    
    -- Get contribution breakdown
    SELECT 
        NVL(SUM(CASE WHEN contribution_type = 'MEMBER' THEN net_contribution ELSE 0 END), 0),
        NVL(SUM(CASE WHEN contribution_type = 'EMPLOYER' THEN net_contribution ELSE 0 END), 0),
        NVL(SUM(interest_earned), 0),
        NVL(SUM(net_contribution), 0)
    INTO v_member_contributions, v_employer_contributions, v_investment_earnings, v_total_contributions
    FROM contributions
    WHERE member_id = p_member_id AND payment_status = 'PROCESSED';
    
    -- Determine vesting percentage based on years of service
    IF v_years_of_service < 2 THEN
        v_vesting_percentage := 0; -- Not vested
    ELSIF v_years_of_service < 5 THEN
        v_vesting_percentage := 0.5; -- 50% vested
    ELSE
        v_vesting_percentage := 1; -- Fully vested
    END IF;
    
    -- Calculate lump sum value (member contributions + vested employer portion)
    p_lump_sum_value := ROUND(
        v_member_contributions + 
        (v_employer_contributions * v_vesting_percentage) + 
        v_investment_earnings, 2
    );
    
    -- Calculate transfer value to another pension plan
    p_transfer_value := ROUND(p_lump_sum_value * 1.1, 2); -- 10% premium for transfers
    
    -- Insert calculation record
    INSERT INTO pension_calculations (
        member_id, calculation_type, effective_date,
        years_of_service, total_contributions,
        member_contributions, employer_contributions, investment_earnings,
        lump_sum_value, commutation_factor,
        calculation_status, notes
    ) VALUES (
        p_member_id, 'TERMINATION_BENEFIT', p_termination_date,
        v_years_of_service, v_total_contributions,
        v_member_contributions, v_employer_contributions, v_investment_earnings,
        p_lump_sum_value, v_commutation_factor,
        'FINAL', 'Vesting: ' || (v_vesting_percentage * 100) || '%'
    );
    
    p_result := 'SUCCESS: Termination benefit calculated - Lump Sum: $' || 
                TO_CHAR(p_lump_sum_value, '999,999.99') ||
                ', Transfer Value: $' || TO_CHAR(p_transfer_value, '999,999.99');
    
    COMMIT;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_result := 'ERROR: Member not found';
    WHEN OTHERS THEN
        ROLLBACK;
        p_result := 'ERROR: ' || SQLERRM;
END sp_calculate_termination_benefit;
/

-- Function to project pension at different retirement ages
CREATE OR REPLACE FUNCTION fn_pension_projection_matrix (
    p_member_id IN NUMBER
) RETURN VARCHAR2 IS
    v_projection CLOB;
    v_annual_pension NUMBER;
    v_monthly_pension NUMBER;
    v_result VARCHAR2(4000);
    v_age NUMBER;
    v_member_info members%ROWTYPE;
BEGIN
    -- Get member information
    SELECT *
    INTO v_member_info
    FROM members
    WHERE member_id = p_member_id;
    
    -- Calculate current age
    v_age := ROUND((MONTHS_BETWEEN(SYSDATE, v_member_info.date_of_birth) / 12), 0);
    
    v_projection := 'Pension Projections for Member ID: ' || p_member_id || CHR(10);
    v_projection := v_projection || 'Current Age: ' || v_age || CHR(10);
    v_projection := v_projection || 'Retirement Age | Annual Pension | Monthly Pension' || CHR(10);
    v_projection := v_projection || '______________|_______________|________________' || CHR(10);
    
    -- Project for ages 55, 60, 65
    FOR retirement_age IN 55..65 LOOP
        IF retirement_age >= v_age THEN
            DECLARE
                v_retirement_date DATE;
            BEGIN
                v_retirement_date := ADD_MONTHS(v_member_info.date_of_birth, retirement_age * 12);
                
                -- Calculate pension for this retirement age
                sp_calculate_annual_pension(
                    p_member_id, v_retirement_date, 
                    v_annual_pension, v_monthly_pension, v_result
                );
                
                v_projection := v_projection || 
                    RPAD(retirement_age, 14) || '|' ||
                    RPAD('$' || TO_CHAR(v_annual_pension, '999,999'), 15) || '|' ||
                    RPAD('$' || TO_CHAR(v_monthly_pension, '9,999'), 16) || CHR(10);
            EXCEPTION
                WHEN OTHERS THEN
                    v_projection := v_projection || 
                        RPAD(retirement_age, 14) || '|' ||
                        RPAD('Error', 15) || '|' ||
                        RPAD('Error', 16) || CHR(10);
            END;
        END IF;
    END LOOP;
    
    RETURN SUBSTR(v_projection, 1, 4000);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Member not found';
    WHEN OTHERS THEN
        RETURN 'Error generating projection: ' || SQLERRM;
END fn_pension_projection_matrix;
/

-- Procedure to update vesting status for all members
CREATE OR REPLACE PROCEDURE sp_update_vesting_status (
    p_updated_count OUT NUMBER,
    p_result OUT VARCHAR2
) IS
    v_updated_count NUMBER := 0;
    
    CURSOR c_members IS
        SELECT member_id, hire_date, status
        FROM members
        WHERE status IN ('ACTIVE', 'TERMINATED')
        AND vesting_status != 'VESTED';
        
BEGIN
    FOR member_rec IN c_members LOOP
        DECLARE
            v_years_of_service NUMBER;
            v_new_vesting_status VARCHAR2(20);
        BEGIN
            -- Calculate years of service
            v_years_of_service := ROUND((SYSDATE - member_rec.hire_date) / 365.25, 2);
            
            -- Determine vesting status
            IF v_years_of_service >= 5 THEN
                v_new_vesting_status := 'VESTED';
            ELSIF v_years_of_service >= 2 THEN
                v_new_vesting_status := 'LOCKED_IN';
            ELSE
                v_new_vesting_status := 'NOT_VESTED';
            END IF;
            
            -- Update if changed
            UPDATE members
            SET vesting_status = v_new_vesting_status,
                updated_date = SYSDATE
            WHERE member_id = member_rec.member_id
            AND vesting_status != v_new_vesting_status;
            
            IF SQL%ROWCOUNT > 0 THEN
                v_updated_count := v_updated_count + 1;
            END IF;
            
        END;
    END LOOP;
    
    p_updated_count := v_updated_count;
    p_result := 'SUCCESS: Updated vesting status for ' || p_updated_count || ' members';
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_result := 'ERROR: ' || SQLERRM;
END sp_update_vesting_status;
/
