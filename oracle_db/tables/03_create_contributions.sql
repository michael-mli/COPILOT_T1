-- CAAT Pension Database - Contributions Table
-- Stores member and employer contribution records

CREATE TABLE contributions (
    contribution_id NUMBER(15) PRIMARY KEY,
    member_id NUMBER(10) NOT NULL,
    employer_id NUMBER(10) NOT NULL,
    contribution_period_start DATE NOT NULL,
    contribution_period_end DATE NOT NULL,
    contribution_type VARCHAR2(20) NOT NULL CHECK (contribution_type IN ('MEMBER', 'EMPLOYER', 'VOLUNTARY')),
    pensionable_earnings NUMBER(12,2) NOT NULL,
    contribution_amount NUMBER(12,2) NOT NULL,
    contribution_rate NUMBER(5,4) NOT NULL,
    contribution_date DATE DEFAULT SYSDATE,
    payment_status VARCHAR2(20) DEFAULT 'PENDING' CHECK (payment_status IN ('PENDING', 'PROCESSED', 'FAILED', 'REFUNDED')),
    payment_method VARCHAR2(50),
    transaction_reference VARCHAR2(100),
    interest_earned NUMBER(12,2) DEFAULT 0,
    administrative_fee NUMBER(12,2) DEFAULT 0,
    net_contribution NUMBER(12,2),
    fiscal_year NUMBER(4),
    quarter NUMBER(1) CHECK (quarter IN (1, 2, 3, 4)),
    notes VARCHAR2(500),
    created_date DATE DEFAULT SYSDATE,
    updated_date DATE,
    created_by VARCHAR2(50) DEFAULT USER,
    updated_by VARCHAR2(50),
    
    -- Foreign key constraints
    CONSTRAINT fk_contributions_member FOREIGN KEY (member_id) REFERENCES members(member_id),
    CONSTRAINT fk_contributions_employer FOREIGN KEY (employer_id) REFERENCES employers(employer_id)
);

-- Create sequence for contribution_id
CREATE SEQUENCE contributions_seq
    START WITH 1000000
    INCREMENT BY 1
    NOCACHE;

-- Create trigger for auto-incrementing contribution_id
CREATE OR REPLACE TRIGGER contributions_pk_trigger
    BEFORE INSERT ON contributions
    FOR EACH ROW
BEGIN
    IF :NEW.contribution_id IS NULL THEN
        :NEW.contribution_id := contributions_seq.NEXTVAL;
    END IF;
END;
/

-- Create trigger for calculating derived fields
CREATE OR REPLACE TRIGGER contributions_calc_trigger
    BEFORE INSERT OR UPDATE ON contributions
    FOR EACH ROW
BEGIN
    -- Calculate net contribution
    :NEW.net_contribution := :NEW.contribution_amount + NVL(:NEW.interest_earned, 0) - NVL(:NEW.administrative_fee, 0);
    
    -- Set fiscal year and quarter
    :NEW.fiscal_year := CASE 
        WHEN EXTRACT(MONTH FROM :NEW.contribution_period_end) >= 4 THEN 
            EXTRACT(YEAR FROM :NEW.contribution_period_end)
        ELSE 
            EXTRACT(YEAR FROM :NEW.contribution_period_end) - 1
    END;
    
    :NEW.quarter := CASE 
        WHEN EXTRACT(MONTH FROM :NEW.contribution_period_end) IN (1, 2, 3) THEN 4
        WHEN EXTRACT(MONTH FROM :NEW.contribution_period_end) IN (4, 5, 6) THEN 1
        WHEN EXTRACT(MONTH FROM :NEW.contribution_period_end) IN (7, 8, 9) THEN 2
        ELSE 3
    END;
    
    -- Update timestamp
    IF INSERTING THEN
        :NEW.created_date := SYSDATE;
        :NEW.created_by := USER;
    ELSE
        :NEW.updated_date := SYSDATE;
        :NEW.updated_by := USER;
    END IF;
END;
/

-- Create indexes for performance
CREATE INDEX idx_contributions_member_id ON contributions(member_id);
CREATE INDEX idx_contributions_employer_id ON contributions(employer_id);
CREATE INDEX idx_contributions_period ON contributions(contribution_period_start, contribution_period_end);
CREATE INDEX idx_contributions_type ON contributions(contribution_type);
CREATE INDEX idx_contributions_status ON contributions(payment_status);
CREATE INDEX idx_contributions_fiscal_year ON contributions(fiscal_year, quarter);
CREATE INDEX idx_contributions_date ON contributions(contribution_date);

-- Create composite index for common queries
CREATE INDEX idx_contributions_member_period ON contributions(member_id, contribution_period_start, contribution_period_end);

-- Add comments
COMMENT ON TABLE contributions IS 'Member and employer contribution records';
COMMENT ON COLUMN contributions.pensionable_earnings IS 'Earnings subject to pension contributions for the period';
COMMENT ON COLUMN contributions.contribution_rate IS 'Rate applied to pensionable earnings';
COMMENT ON COLUMN contributions.net_contribution IS 'Final contribution amount after interest and fees';
COMMENT ON COLUMN contributions.fiscal_year IS 'Pension plan fiscal year (April 1 - March 31)';
COMMENT ON COLUMN contributions.quarter IS 'Fiscal quarter (1=Apr-Jun, 2=Jul-Sep, 3=Oct-Dec, 4=Jan-Mar)';
