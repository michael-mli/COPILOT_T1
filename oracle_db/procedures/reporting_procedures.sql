-- CAAT Pension Database - Reporting Stored Procedures
-- Procedures for generating various reports and analytics

-- Procedure to generate employer contribution report
CREATE OR REPLACE PROCEDURE sp_employer_contribution_report (
    p_employer_id IN NUMBER DEFAULT NULL,
    p_fiscal_year IN NUMBER DEFAULT NULL,
    p_report_cursor OUT SYS_REFCURSOR,
    p_result OUT VARCHAR2
) IS
    v_sql VARCHAR2(4000);
    v_fiscal_year NUMBER;
BEGIN
    -- Set default fiscal year if not provided
    v_fiscal_year := NVL(p_fiscal_year, EXTRACT(YEAR FROM SYSDATE));
    
    -- Build dynamic SQL based on parameters
    v_sql := '
    SELECT 
        e.employer_name,
        e.employer_code,
        e.employee_count,
        COUNT(DISTINCT c.member_id) as active_contributors,
        SUM(CASE WHEN c.contribution_type = ''MEMBER'' THEN c.contribution_amount ELSE 0 END) as total_member_contributions,
        SUM(CASE WHEN c.contribution_type = ''EMPLOYER'' THEN c.contribution_amount ELSE 0 END) as total_employer_contributions,
        SUM(c.contribution_amount) as total_contributions,
        SUM(c.interest_earned) as total_interest_earned,
        AVG(c.contribution_rate) as avg_contribution_rate,
        MIN(c.contribution_date) as first_contribution_date,
        MAX(c.contribution_date) as last_contribution_date
    FROM employers e
    LEFT JOIN contributions c ON e.employer_id = c.employer_id 
        AND c.fiscal_year = ' || v_fiscal_year || '
        AND c.payment_status = ''PROCESSED''';
    
    -- Add employer filter if specified
    IF p_employer_id IS NOT NULL THEN
        v_sql := v_sql || ' WHERE e.employer_id = ' || p_employer_id;
    END IF;
    
    v_sql := v_sql || '
    GROUP BY e.employer_id, e.employer_name, e.employer_code, e.employee_count
    ORDER BY e.employer_name';
    
    OPEN p_report_cursor FOR v_sql;
    
    p_result := 'SUCCESS: Employer contribution report generated for fiscal year ' || v_fiscal_year;
    
EXCEPTION
    WHEN OTHERS THEN
        p_result := 'ERROR: ' || SQLERRM;
        IF p_report_cursor%ISOPEN THEN
            CLOSE p_report_cursor;
        END IF;
END sp_employer_contribution_report;
/

-- Procedure to generate member demographics report
CREATE OR REPLACE PROCEDURE sp_member_demographics_report (
    p_report_cursor OUT SYS_REFCURSOR,
    p_result OUT VARCHAR2
) IS
BEGIN
    OPEN p_report_cursor FOR
    SELECT 
        'Age Groups' as category,
        CASE 
            WHEN age_group < 30 THEN 'Under 30'
            WHEN age_group < 40 THEN '30-39'
            WHEN age_group < 50 THEN '40-49'
            WHEN age_group < 60 THEN '50-59'
            ELSE '60+'
        END as subcategory,
        COUNT(*) as member_count,
        ROUND(COUNT(*) * 100.0 / total_members.total, 2) as percentage
    FROM (
        SELECT 
            member_id,
            ROUND((MONTHS_BETWEEN(SYSDATE, date_of_birth) / 12), 0) as age_group
        FROM members 
        WHERE status = 'ACTIVE'
    ) m
    CROSS JOIN (
        SELECT COUNT(*) as total FROM members WHERE status = 'ACTIVE'
    ) total_members
    GROUP BY 
        CASE 
            WHEN age_group < 30 THEN 'Under 30'
            WHEN age_group < 40 THEN '30-39'
            WHEN age_group < 50 THEN '40-49'
            WHEN age_group < 60 THEN '50-59'
            ELSE '60+'
        END,
        total_members.total
        
    UNION ALL
    
    SELECT 
        'Gender' as category,
        CASE 
            WHEN gender = 'M' THEN 'Male'
            WHEN gender = 'F' THEN 'Female'
            ELSE 'Other/Not Specified'
        END as subcategory,
        COUNT(*) as member_count,
        ROUND(COUNT(*) * 100.0 / total_members.total, 2) as percentage
    FROM members m
    CROSS JOIN (
        SELECT COUNT(*) as total FROM members WHERE status = 'ACTIVE'
    ) total_members
    WHERE status = 'ACTIVE'
    GROUP BY gender, total_members.total
    
    UNION ALL
    
    SELECT 
        'Years of Service' as category,
        CASE 
            WHEN years_of_service < 2 THEN 'Under 2 years'
            WHEN years_of_service < 5 THEN '2-5 years'
            WHEN years_of_service < 10 THEN '5-10 years'
            WHEN years_of_service < 20 THEN '10-20 years'
            ELSE '20+ years'
        END as subcategory,
        COUNT(*) as member_count,
        ROUND(COUNT(*) * 100.0 / total_members.total, 2) as percentage
    FROM members m
    CROSS JOIN (
        SELECT COUNT(*) as total FROM members WHERE status = 'ACTIVE'
    ) total_members
    WHERE status = 'ACTIVE'
    GROUP BY 
        CASE 
            WHEN years_of_service < 2 THEN 'Under 2 years'
            WHEN years_of_service < 5 THEN '2-5 years'
            WHEN years_of_service < 10 THEN '5-10 years'
            WHEN years_of_service < 20 THEN '10-20 years'
            ELSE '20+ years'
        END,
        total_members.total
    
    ORDER BY category, subcategory;
    
    p_result := 'SUCCESS: Member demographics report generated';
    
EXCEPTION
    WHEN OTHERS THEN
        p_result := 'ERROR: ' || SQLERRM;
        IF p_report_cursor%ISOPEN THEN
            CLOSE p_report_cursor;
        END IF;
END sp_member_demographics_report;
/

-- Function to calculate plan performance metrics
CREATE OR REPLACE FUNCTION fn_calculate_plan_metrics (
    p_fiscal_year IN NUMBER DEFAULT NULL
) RETURN VARCHAR2 IS
    v_metrics VARCHAR2(4000);
    v_fiscal_year NUMBER;
    v_total_assets NUMBER;
    v_total_contributions NUMBER;
    v_total_members NUMBER;
    v_avg_age NUMBER;
    v_avg_service NUMBER;
    v_total_benefits_paid NUMBER;
    v_admin_expenses NUMBER;
BEGIN
    v_fiscal_year := NVL(p_fiscal_year, EXTRACT(YEAR FROM SYSDATE));
    
    -- Calculate total assets (contributions + investment earnings)
    SELECT NVL(SUM(net_contribution), 0)
    INTO v_total_assets
    FROM contributions
    WHERE fiscal_year <= v_fiscal_year AND payment_status = 'PROCESSED';
    
    -- Calculate total contributions for the year
    SELECT NVL(SUM(contribution_amount), 0)
    INTO v_total_contributions
    FROM contributions
    WHERE fiscal_year = v_fiscal_year AND payment_status = 'PROCESSED';
    
    -- Get member statistics
    SELECT 
        COUNT(*),
        ROUND(AVG(MONTHS_BETWEEN(SYSDATE, date_of_birth) / 12), 1),
        ROUND(AVG(years_of_service), 1)
    INTO v_total_members, v_avg_age, v_avg_service
    FROM members
    WHERE status = 'ACTIVE';
    
    -- Calculate estimated benefits paid (simplified)
    SELECT NVL(SUM(annual_pension_amount), 0)
    INTO v_total_benefits_paid
    FROM pension_calculations
    WHERE calculation_type IN ('RETIREMENT_ESTIMATE', 'TERMINATION_BENEFIT')
    AND EXTRACT(YEAR FROM calculation_date) = v_fiscal_year;
    
    -- Estimate admin expenses (2% of contributions)
    v_admin_expenses := v_total_contributions * 0.02;
    
    -- Build metrics report
    v_metrics := 'CAAT PENSION PLAN METRICS - FISCAL YEAR ' || v_fiscal_year || CHR(10);
    v_metrics := v_metrics || '================================================' || CHR(10);
    v_metrics := v_metrics || 'Total Plan Assets: $' || TO_CHAR(v_total_assets, '999,999,999,999.99') || CHR(10);
    v_metrics := v_metrics || 'Annual Contributions: $' || TO_CHAR(v_total_contributions, '999,999,999.99') || CHR(10);
    v_metrics := v_metrics || 'Active Members: ' || TO_CHAR(v_total_members, '999,999') || CHR(10);
    v_metrics := v_metrics || 'Average Member Age: ' || v_avg_age || ' years' || CHR(10);
    v_metrics := v_metrics || 'Average Years of Service: ' || v_avg_service || ' years' || CHR(10);
    v_metrics := v_metrics || 'Estimated Benefits Paid: $' || TO_CHAR(v_total_benefits_paid, '999,999,999.99') || CHR(10);
    v_metrics := v_metrics || 'Administrative Expenses: $' || TO_CHAR(v_admin_expenses, '999,999,999.99') || CHR(10);
    v_metrics := v_metrics || 'Assets per Member: $' || TO_CHAR(ROUND(v_total_assets / GREATEST(v_total_members, 1), 2), '999,999.99') || CHR(10);
    v_metrics := v_metrics || 'Expense Ratio: ' || TO_CHAR(ROUND(v_admin_expenses / GREATEST(v_total_assets, 1) * 100, 2), '99.99') || '%' || CHR(10);
    
    RETURN v_metrics;
    
EXCEPTION
    WHEN OTHERS THEN
        RETURN 'Error calculating plan metrics: ' || SQLERRM;
END fn_calculate_plan_metrics;
/

-- Procedure to generate contribution variance report
CREATE OR REPLACE PROCEDURE sp_contribution_variance_report (
    p_fiscal_year IN NUMBER,
    p_variance_threshold IN NUMBER DEFAULT 0.10, -- 10% variance threshold
    p_report_cursor OUT SYS_REFCURSOR,
    p_result OUT VARCHAR2
) IS
BEGIN
    OPEN p_report_cursor FOR
    WITH monthly_expected AS (
        SELECT 
            m.member_id,
            m.first_name || ' ' || m.last_name as member_name,
            m.employee_id,
            e.employer_name,
            m.salary_annual / 12 as expected_monthly_salary,
            m.contribution_rate,
            (m.salary_annual / 12) * m.contribution_rate as expected_monthly_contribution
        FROM members m
        JOIN employers e ON m.employer_id = e.employer_id
        WHERE m.status = 'ACTIVE'
    ),
    actual_contributions AS (
        SELECT 
            c.member_id,
            AVG(c.pensionable_earnings) as avg_monthly_earnings,
            AVG(c.contribution_amount) as avg_monthly_contribution,
            COUNT(*) as contribution_months
        FROM contributions c
        WHERE c.fiscal_year = p_fiscal_year
        AND c.contribution_type = 'MEMBER'
        AND c.payment_status = 'PROCESSED'
        GROUP BY c.member_id
    )
    SELECT 
        me.member_name,
        me.employee_id,
        me.employer_name,
        me.expected_monthly_salary,
        ac.avg_monthly_earnings,
        me.expected_monthly_contribution,
        ac.avg_monthly_contribution,
        ac.contribution_months,
        ROUND(
            ABS(ac.avg_monthly_contribution - me.expected_monthly_contribution) / 
            GREATEST(me.expected_monthly_contribution, 0.01) * 100, 2
        ) as variance_percentage,
        CASE 
            WHEN ac.avg_monthly_contribution > me.expected_monthly_contribution THEN 'OVER'
            WHEN ac.avg_monthly_contribution < me.expected_monthly_contribution THEN 'UNDER'
            ELSE 'NORMAL'
        END as variance_type
    FROM monthly_expected me
    LEFT JOIN actual_contributions ac ON me.member_id = ac.member_id
    WHERE (
        ABS(NVL(ac.avg_monthly_contribution, 0) - me.expected_monthly_contribution) / 
        GREATEST(me.expected_monthly_contribution, 0.01)
    ) > p_variance_threshold
    OR ac.member_id IS NULL -- Members with no contributions
    ORDER BY variance_percentage DESC;
    
    p_result := 'SUCCESS: Contribution variance report generated for fiscal year ' || p_fiscal_year ||
                ' with ' || (p_variance_threshold * 100) || '% threshold';
    
EXCEPTION
    WHEN OTHERS THEN
        p_result := 'ERROR: ' || SQLERRM;
        IF p_report_cursor%ISOPEN THEN
            CLOSE p_report_cursor;
        END IF;
END sp_contribution_variance_report;
/
