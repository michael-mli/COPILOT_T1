-- CAAT Pension Database - Member Related Stored Procedures
-- Procedures for member management and operations

-- Procedure to register a new member
CREATE OR REPLACE PROCEDURE sp_register_member (
    p_employee_id IN VARCHAR2,
    p_employer_id IN NUMBER,
    p_first_name IN VARCHAR2,
    p_last_name IN VARCHAR2,
    p_email IN VARCHAR2,
    p_phone IN VARCHAR2,
    p_date_of_birth IN DATE,
    p_sin IN VARCHAR2,
    p_gender IN VARCHAR2,
    p_hire_date IN DATE,
    p_salary_annual IN NUMBER,
    p_member_id OUT NUMBER,
    p_result OUT VARCHAR2
) IS
    v_existing_count NUMBER;
    v_employer_exists NUMBER;
BEGIN
    -- Check if employer exists
    SELECT COUNT(*)
    INTO v_employer_exists
    FROM employers
    WHERE employer_id = p_employer_id AND status = 'ACTIVE';
    
    IF v_employer_exists = 0 THEN
        p_result := 'ERROR: Invalid or inactive employer';
        RETURN;
    END IF;
    
    -- Check if member already exists by email or SIN
    SELECT COUNT(*)
    INTO v_existing_count
    FROM members
    WHERE email = p_email OR sin = p_sin;
    
    IF v_existing_count > 0 THEN
        p_result := 'ERROR: Member already exists with this email or SIN';
        RETURN;
    END IF;
    
    -- Insert new member
    INSERT INTO members (
        employee_id, employer_id, first_name, last_name, email, phone,
        date_of_birth, sin, gender, hire_date, salary_annual,
        membership_start_date, status
    ) VALUES (
        p_employee_id, p_employer_id, p_first_name, p_last_name, p_email, p_phone,
        p_date_of_birth, p_sin, p_gender, p_hire_date, p_salary_annual,
        SYSDATE, 'ACTIVE'
    ) RETURNING member_id INTO p_member_id;
    
    -- Update employer employee count
    UPDATE employers 
    SET employee_count = employee_count + 1,
        updated_date = SYSDATE
    WHERE employer_id = p_employer_id;
    
    p_result := 'SUCCESS: Member registered successfully';
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_result := 'ERROR: ' || SQLERRM;
END sp_register_member;
/

-- Procedure to update member information
CREATE OR REPLACE PROCEDURE sp_update_member (
    p_member_id IN NUMBER,
    p_email IN VARCHAR2 DEFAULT NULL,
    p_phone IN VARCHAR2 DEFAULT NULL,
    p_address_line1 IN VARCHAR2 DEFAULT NULL,
    p_address_line2 IN VARCHAR2 DEFAULT NULL,
    p_city IN VARCHAR2 DEFAULT NULL,
    p_province IN VARCHAR2 DEFAULT NULL,
    p_postal_code IN VARCHAR2 DEFAULT NULL,
    p_salary_annual IN NUMBER DEFAULT NULL,
    p_result OUT VARCHAR2
) IS
    v_member_exists NUMBER;
BEGIN
    -- Check if member exists
    SELECT COUNT(*)
    INTO v_member_exists
    FROM members
    WHERE member_id = p_member_id;
    
    IF v_member_exists = 0 THEN
        p_result := 'ERROR: Member not found';
        RETURN;
    END IF;
    
    -- Update member information
    UPDATE members
    SET email = NVL(p_email, email),
        phone = NVL(p_phone, phone),
        address_line1 = NVL(p_address_line1, address_line1),
        address_line2 = NVL(p_address_line2, address_line2),
        city = NVL(p_city, city),
        province = NVL(p_province, province),
        postal_code = NVL(p_postal_code, postal_code),
        salary_annual = NVL(p_salary_annual, salary_annual),
        updated_date = SYSDATE
    WHERE member_id = p_member_id;
    
    p_result := 'SUCCESS: Member updated successfully';
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_result := 'ERROR: ' || SQLERRM;
END sp_update_member;
/

-- Procedure to terminate a member
CREATE OR REPLACE PROCEDURE sp_terminate_member (
    p_member_id IN NUMBER,
    p_termination_date IN DATE,
    p_termination_reason IN VARCHAR2,
    p_result OUT VARCHAR2
) IS
    v_member_exists NUMBER;
    v_employer_id NUMBER;
BEGIN
    -- Check if member exists and get employer
    SELECT COUNT(*), MAX(employer_id)
    INTO v_member_exists, v_employer_id
    FROM members
    WHERE member_id = p_member_id AND status = 'ACTIVE';
    
    IF v_member_exists = 0 THEN
        p_result := 'ERROR: Active member not found';
        RETURN;
    END IF;
    
    -- Update member status
    UPDATE members
    SET status = 'TERMINATED',
        termination_date = p_termination_date,
        membership_end_date = p_termination_date,
        updated_date = SYSDATE
    WHERE member_id = p_member_id;
    
    -- Update employer employee count
    UPDATE employers 
    SET employee_count = employee_count - 1,
        updated_date = SYSDATE
    WHERE employer_id = v_employer_id;
    
    -- Insert termination note
    INSERT INTO pension_calculations (
        member_id, calculation_type, effective_date, notes, calculation_status
    ) VALUES (
        p_member_id, 'TERMINATION_BENEFIT', p_termination_date, 
        'Member terminated: ' || p_termination_reason, 'DRAFT'
    );
    
    p_result := 'SUCCESS: Member terminated successfully';
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_result := 'ERROR: ' || SQLERRM;
END sp_terminate_member;
/

-- Function to get member summary
CREATE OR REPLACE FUNCTION fn_get_member_summary (
    p_member_id IN NUMBER
) RETURN VARCHAR2 IS
    v_summary VARCHAR2(1000);
    v_member_info members%ROWTYPE;
    v_total_contributions NUMBER;
    v_years_service NUMBER;
BEGIN
    -- Get member information
    SELECT *
    INTO v_member_info
    FROM members
    WHERE member_id = p_member_id;
    
    -- Get total contributions
    SELECT NVL(SUM(net_contribution), 0)
    INTO v_total_contributions
    FROM contributions
    WHERE member_id = p_member_id AND payment_status = 'PROCESSED';
    
    -- Build summary
    v_summary := v_member_info.first_name || ' ' || v_member_info.last_name || 
                ' (ID: ' || v_member_info.member_id || ') - ' ||
                'Status: ' || v_member_info.status || 
                ', Years of Service: ' || v_member_info.years_of_service ||
                ', Total Contributions: $' || TO_CHAR(v_total_contributions, '999,999,999.99') ||
                ', Vesting: ' || v_member_info.vesting_status;
    
    RETURN v_summary;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Member not found';
    WHEN OTHERS THEN
        RETURN 'Error retrieving member summary: ' || SQLERRM;
END fn_get_member_summary;
/
