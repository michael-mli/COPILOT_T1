-- CAAT Pension Database - Members Table
-- Stores information about pension plan members

CREATE TABLE members (
    member_id NUMBER(10) PRIMARY KEY,
    employee_id VARCHAR2(50) NOT NULL,
    employer_id NUMBER(10) NOT NULL,
    first_name VARCHAR2(100) NOT NULL,
    last_name VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    phone VARCHAR2(20),
    date_of_birth DATE NOT NULL,
    sin VARCHAR2(11) UNIQUE NOT NULL, -- Social Insurance Number
    gender VARCHAR2(1) CHECK (gender IN ('M', 'F', 'O')),
    address_line1 VARCHAR2(200),
    address_line2 VARCHAR2(200),
    city VARCHAR2(100),
    province VARCHAR2(50),
    postal_code VARCHAR2(10),
    hire_date DATE NOT NULL,
    termination_date DATE,
    membership_start_date DATE NOT NULL,
    membership_end_date DATE,
    status VARCHAR2(20) DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE', 'INACTIVE', 'TERMINATED', 'RETIRED')),
    pension_eligible_date DATE,
    salary_annual NUMBER(12,2),
    contribution_rate NUMBER(5,4) DEFAULT 0.0920, -- 9.2% default rate
    vesting_status VARCHAR2(20) DEFAULT 'NOT_VESTED' CHECK (vesting_status IN ('NOT_VESTED', 'VESTED', 'LOCKED_IN')),
    years_of_service NUMBER(10,2) DEFAULT 0,
    password_hash VARCHAR2(255),
    last_login DATE,
    created_date DATE DEFAULT SYSDATE,
    updated_date DATE,
    created_by VARCHAR2(50) DEFAULT USER,
    updated_by VARCHAR2(50),
    
    -- Foreign key constraint
    CONSTRAINT fk_members_employer FOREIGN KEY (employer_id) REFERENCES employers(employer_id)
);

-- Create sequence for member_id
CREATE SEQUENCE members_seq
    START WITH 100000
    INCREMENT BY 1
    NOCACHE;

-- Create trigger for auto-incrementing member_id
CREATE OR REPLACE TRIGGER members_pk_trigger
    BEFORE INSERT ON members
    FOR EACH ROW
BEGIN
    IF :NEW.member_id IS NULL THEN
        :NEW.member_id := members_seq.NEXTVAL;
    END IF;
END;
/

-- Create trigger for updating updated_date and calculating years of service
CREATE OR REPLACE TRIGGER members_update_trigger
    BEFORE UPDATE ON members
    FOR EACH ROW
BEGIN
    :NEW.updated_date := SYSDATE;
    :NEW.updated_by := USER;
    
    -- Calculate years of service
    IF :NEW.termination_date IS NOT NULL THEN
        :NEW.years_of_service := ROUND((:NEW.termination_date - :NEW.hire_date) / 365.25, 2);
    ELSE
        :NEW.years_of_service := ROUND((SYSDATE - :NEW.hire_date) / 365.25, 2);
    END IF;
END;
/

-- Create trigger for calculating years of service on insert
CREATE OR REPLACE TRIGGER members_insert_trigger
    BEFORE INSERT ON members
    FOR EACH ROW
BEGIN
    -- Calculate years of service
    IF :NEW.termination_date IS NOT NULL THEN
        :NEW.years_of_service := ROUND((:NEW.termination_date - :NEW.hire_date) / 365.25, 2);
    ELSE
        :NEW.years_of_service := ROUND((SYSDATE - :NEW.hire_date) / 365.25, 2);
    END IF;
    
    -- Set pension eligible date (usually after 2 years of service)
    IF :NEW.pension_eligible_date IS NULL THEN
        :NEW.pension_eligible_date := ADD_MONTHS(:NEW.hire_date, 24);
    END IF;
END;
/

-- Create indexes for performance
CREATE INDEX idx_members_employer_id ON members(employer_id);
CREATE INDEX idx_members_email ON members(email);
CREATE INDEX idx_members_sin ON members(sin);
CREATE INDEX idx_members_status ON members(status);
CREATE INDEX idx_members_employee_id ON members(employee_id);
CREATE INDEX idx_members_name ON members(last_name, first_name);

-- Create unique constraint for employee_id within employer
CREATE UNIQUE INDEX idx_members_emp_employee_id ON members(employer_id, employee_id);

-- Add comments
COMMENT ON TABLE members IS 'Pension plan members and their personal information';
COMMENT ON COLUMN members.sin IS 'Social Insurance Number (encrypted in production)';
COMMENT ON COLUMN members.contribution_rate IS 'Member contribution rate as decimal (0.092 = 9.2%)';
COMMENT ON COLUMN members.vesting_status IS 'Vesting status determining benefit eligibility';
COMMENT ON COLUMN members.years_of_service IS 'Calculated years of service for pension calculations';
