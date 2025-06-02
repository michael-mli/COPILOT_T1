-- CAAT Pension Database - Pension Calculations Table
-- Stores pension benefit calculations and projections

CREATE TABLE pension_calculations (
    calculation_id NUMBER(15) PRIMARY KEY,
    member_id NUMBER(10) NOT NULL,
    calculation_type VARCHAR2(30) NOT NULL CHECK (calculation_type IN ('ANNUAL_STATEMENT', 'RETIREMENT_ESTIMATE', 'TERMINATION_BENEFIT', 'SURVIVOR_BENEFIT', 'DISABILITY_BENEFIT')),
    calculation_date DATE DEFAULT SYSDATE,
    effective_date DATE NOT NULL,
    retirement_date DATE,
    age_at_calculation NUMBER(3,1),
    years_of_service NUMBER(10,2),
    total_contributions NUMBER(15,2),
    member_contributions NUMBER(15,2),
    employer_contributions NUMBER(15,2),
    investment_earnings NUMBER(15,2),
    average_salary NUMBER(12,2),
    best_average_salary NUMBER(12,2), -- Best 5 consecutive years
    pension_factor NUMBER(8,6), -- Factor used in calculation
    annual_pension_amount NUMBER(12,2),
    monthly_pension_amount NUMBER(12,2),
    lump_sum_value NUMBER(15,2),
    survivor_benefit_amount NUMBER(12,2),
    bridge_benefit_amount NUMBER(12,2), -- Bridge to CPP
    indexation_rate NUMBER(5,4) DEFAULT 0.75, -- 75% of CPI
    commutation_factor NUMBER(8,6),
    actuarial_assumptions VARCHAR2(100),
    calculation_method VARCHAR2(50),
    cola_adjustment NUMBER(12,2) DEFAULT 0, -- Cost of living adjustment
    early_retirement_reduction NUMBER(5,4) DEFAULT 0,
    calculation_status VARCHAR2(20) DEFAULT 'DRAFT' CHECK (calculation_status IN ('DRAFT', 'FINAL', 'APPROVED', 'SUPERSEDED')),
    reviewed_by VARCHAR2(100),
    reviewed_date DATE,
    notes VARCHAR2(1000),
    created_date DATE DEFAULT SYSDATE,
    updated_date DATE,
    created_by VARCHAR2(50) DEFAULT USER,
    updated_by VARCHAR2(50),
    
    -- Foreign key constraint
    CONSTRAINT fk_pension_calc_member FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- Create sequence for calculation_id
CREATE SEQUENCE pension_calc_seq
    START WITH 2000000
    INCREMENT BY 1
    NOCACHE;

-- Create trigger for auto-incrementing calculation_id
CREATE OR REPLACE TRIGGER pension_calc_pk_trigger
    BEFORE INSERT ON pension_calculations
    FOR EACH ROW
BEGIN
    IF :NEW.calculation_id IS NULL THEN
        :NEW.calculation_id := pension_calc_seq.NEXTVAL;
    END IF;
END;
/

-- Create trigger for calculating derived fields
CREATE OR REPLACE TRIGGER pension_calc_trigger
    BEFORE INSERT OR UPDATE ON pension_calculations
    FOR EACH ROW
BEGIN
    -- Calculate monthly pension from annual amount
    IF :NEW.annual_pension_amount IS NOT NULL THEN
        :NEW.monthly_pension_amount := ROUND(:NEW.annual_pension_amount / 12, 2);
    END IF;
    
    -- Calculate age at calculation
    IF :NEW.effective_date IS NOT NULL THEN
        SELECT ROUND((MONTHS_BETWEEN(:NEW.effective_date, m.date_of_birth) / 12), 1)
        INTO :NEW.age_at_calculation
        FROM members m
        WHERE m.member_id = :NEW.member_id;
    END IF;
    
    -- Set survivor benefit (typically 60% of pension)
    IF :NEW.annual_pension_amount IS NOT NULL AND :NEW.calculation_type != 'SURVIVOR_BENEFIT' THEN
        :NEW.survivor_benefit_amount := ROUND(:NEW.annual_pension_amount * 0.60, 2);
    END IF;
    
    -- Update timestamp
    IF INSERTING THEN
        :NEW.created_date := SYSDATE;
        :NEW.created_by := USER;
    ELSE
        :NEW.updated_date := SYSDATE;
        :NEW.updated_by := USER;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        NULL; -- Handle case where member not found
END;
/

-- Create indexes for performance
CREATE INDEX idx_pension_calc_member_id ON pension_calculations(member_id);
CREATE INDEX idx_pension_calc_type ON pension_calculations(calculation_type);
CREATE INDEX idx_pension_calc_date ON pension_calculations(calculation_date);
CREATE INDEX idx_pension_calc_status ON pension_calculations(calculation_status);
CREATE INDEX idx_pension_calc_effective ON pension_calculations(effective_date);

-- Create composite index for member calculations
CREATE INDEX idx_pension_calc_member_type ON pension_calculations(member_id, calculation_type, calculation_date);

-- Add comments
COMMENT ON TABLE pension_calculations IS 'Pension benefit calculations and projections for members';
COMMENT ON COLUMN pension_calculations.best_average_salary IS 'Best 5 consecutive years average salary';
COMMENT ON COLUMN pension_calculations.pension_factor IS 'Factor used in pension calculation formula';
COMMENT ON COLUMN pension_calculations.bridge_benefit_amount IS 'Bridge benefit paid until CPP eligibility';
COMMENT ON COLUMN pension_calculations.indexation_rate IS 'Rate for cost of living adjustments';
COMMENT ON COLUMN pension_calculations.early_retirement_reduction IS 'Reduction factor for early retirement';
