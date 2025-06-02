-- CAAT Pension Database - Employers Table
-- Stores information about participating employers

CREATE TABLE employers (
    employer_id NUMBER(10) PRIMARY KEY,
    employer_name VARCHAR2(200) NOT NULL,
    employer_code VARCHAR2(20) UNIQUE NOT NULL,
    sector VARCHAR2(100) NOT NULL,
    contact_person VARCHAR2(100),
    contact_email VARCHAR2(100),
    contact_phone VARCHAR2(20),
    address_line1 VARCHAR2(200),
    address_line2 VARCHAR2(200),
    city VARCHAR2(100),
    province VARCHAR2(50),
    postal_code VARCHAR2(10),
    join_date DATE NOT NULL,
    status VARCHAR2(20) DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE', 'INACTIVE', 'SUSPENDED')),
    employee_count NUMBER(10) DEFAULT 0,
    created_date DATE DEFAULT SYSDATE,
    updated_date DATE,
    created_by VARCHAR2(50) DEFAULT USER,
    updated_by VARCHAR2(50)
);

-- Create sequence for employer_id
CREATE SEQUENCE employers_seq
    START WITH 1000
    INCREMENT BY 1
    NOCACHE;

-- Create trigger for auto-incrementing employer_id
CREATE OR REPLACE TRIGGER employers_pk_trigger
    BEFORE INSERT ON employers
    FOR EACH ROW
BEGIN
    IF :NEW.employer_id IS NULL THEN
        :NEW.employer_id := employers_seq.NEXTVAL;
    END IF;
END;
/

-- Create trigger for updating updated_date
CREATE OR REPLACE TRIGGER employers_update_trigger
    BEFORE UPDATE ON employers
    FOR EACH ROW
BEGIN
    :NEW.updated_date := SYSDATE;
    :NEW.updated_by := USER;
END;
/

-- Create indexes for performance
CREATE INDEX idx_employers_code ON employers(employer_code);
CREATE INDEX idx_employers_status ON employers(status);
CREATE INDEX idx_employers_sector ON employers(sector);

-- Add comments
COMMENT ON TABLE employers IS 'Participating employers in the CAAT Pension Plan';
COMMENT ON COLUMN employers.employer_code IS 'Unique code assigned to each employer';
COMMENT ON COLUMN employers.status IS 'Current status: ACTIVE, INACTIVE, or SUSPENDED';
COMMENT ON COLUMN employers.employee_count IS 'Current number of employees enrolled in the plan';
