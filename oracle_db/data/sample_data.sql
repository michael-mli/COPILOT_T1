-- CAAT Pension Database - Sample Data Insertion
-- Populate tables with realistic sample data for testing

-- Insert sample employers
INSERT INTO employers (employer_name, employer_code, sector, contact_person, contact_email, contact_phone, 
                      address_line1, city, province, postal_code, join_date, status, employee_count) VALUES
('Toronto District School Board', 'TDSB', 'Primary Education', 'Sarah Johnson', 'pension@tdsb.on.ca', '416-397-3000',
 '5050 Yonge Street', 'Toronto', 'Ontario', 'M2N 5N8', DATE '2018-01-15', 'ACTIVE', 15000);

INSERT INTO employers (employer_name, employer_code, sector, contact_person, contact_email, contact_phone,
                      address_line1, city, province, postal_code, join_date, status, employee_count) VALUES
('Seneca College', 'SENECA', 'Post-Secondary Education', 'Michael Chen', 'hr@senecacollege.ca', '416-491-5050',
 '1750 Finch Avenue East', 'Toronto', 'Ontario', 'M2J 2X5', DATE '2019-09-01', 'ACTIVE', 3500);

INSERT INTO employers (employer_name, employer_code, sector, contact_person, contact_email, contact_phone,
                      address_line1, city, province, postal_code, join_date, status, employee_count) VALUES
('York Region District School Board', 'YRDSB', 'Primary Education', 'Lisa Wang', 'benefits@yrdsb.ca', '905-727-0022',
 '60 Wellington Street West', 'Aurora', 'Ontario', 'L4G 3H2', DATE '2020-02-10', 'ACTIVE', 12000);

INSERT INTO employers (employer_name, employer_code, sector, contact_person, contact_email, contact_phone,
                      address_line1, city, province, postal_code, join_date, status, employee_count) VALUES
('Centennial College', 'CENTENNIAL', 'Post-Secondary Education', 'David Smith', 'payroll@centennialcollege.ca', '416-289-5000',
 '941 Progress Avenue', 'Toronto', 'Ontario', 'M1G 3T8', DATE '2020-08-15', 'ACTIVE', 2800);

INSERT INTO employers (employer_name, employer_code, sector, contact_person, contact_email, contact_phone,
                      address_line1, city, province, postal_code, join_date, status, employee_count) VALUES
('Ontario College of Art and Design', 'OCAD', 'Post-Secondary Education', 'Jennifer Martinez', 'hr@ocadu.ca', '416-977-6000',
 '100 McCaul Street', 'Toronto', 'Ontario', 'M5T 1W1', DATE '2021-01-20', 'ACTIVE', 850);

-- Insert sample members
-- Get employer IDs for reference
DECLARE
    v_tdsb_id NUMBER;
    v_seneca_id NUMBER;
    v_yrdsb_id NUMBER;
    v_centennial_id NUMBER;
    v_ocad_id NUMBER;
BEGIN
    SELECT employer_id INTO v_tdsb_id FROM employers WHERE employer_code = 'TDSB';
    SELECT employer_id INTO v_seneca_id FROM employers WHERE employer_code = 'SENECA';
    SELECT employer_id INTO v_yrdsb_id FROM employers WHERE employer_code = 'YRDSB';
    SELECT employer_id INTO v_centennial_id FROM employers WHERE employer_code = 'CENTENNIAL';
    SELECT employer_id INTO v_ocad_id FROM employers WHERE employer_code = 'OCAD';

    -- TDSB Members
    INSERT INTO members (employee_id, employer_id, first_name, last_name, email, phone, date_of_birth, sin, gender,
                        hire_date, salary_annual, membership_start_date, status, contribution_rate,
                        address_line1, city, province, postal_code) VALUES
    ('EMP001', v_tdsb_id, 'John', 'Doe', 'john.doe@tdsb.on.ca', '416-555-0101', DATE '1985-03-15', '123456789',
     'M', DATE '2015-09-01', 75000, DATE '2015-09-01', 'ACTIVE', 0.092,
     '123 Main Street', 'Toronto', 'Ontario', 'M5V 2H1');

    INSERT INTO members (employee_id, employer_id, first_name, last_name, email, phone, date_of_birth, sin, gender,
                        hire_date, salary_annual, membership_start_date, status, contribution_rate,
                        address_line1, city, province, postal_code) VALUES
    ('EMP002', v_tdsb_id, 'Jane', 'Smith', 'jane.smith@tdsb.on.ca', '416-555-0102', DATE '1980-07-22', '987654321',
     'F', DATE '2012-01-15', 82000, DATE '2012-01-15', 'ACTIVE', 0.092,
     '456 Oak Avenue', 'Toronto', 'Ontario', 'M4K 1A1');

    INSERT INTO members (employee_id, employer_id, first_name, last_name, email, phone, date_of_birth, sin, gender,
                        hire_date, salary_annual, membership_start_date, status, contribution_rate,
                        address_line1, city, province, postal_code) VALUES
    ('EMP003', v_tdsb_id, 'Michael', 'Johnson', 'michael.johnson@tdsb.on.ca', '416-555-0103', DATE '1978-11-08', '456789123',
     'M', DATE '2010-08-20', 95000, DATE '2010-08-20', 'ACTIVE', 0.092,
     '789 Elm Street', 'Toronto', 'Ontario', 'M6H 2K8');

    -- Seneca College Members
    INSERT INTO members (employee_id, employer_id, first_name, last_name, email, phone, date_of_birth, sin, gender,
                        hire_date, salary_annual, membership_start_date, status, contribution_rate,
                        address_line1, city, province, postal_code) VALUES
    ('SEN001', v_seneca_id, 'Sarah', 'Wilson', 'sarah.wilson@senecacollege.ca', '416-555-0201', DATE '1983-05-12', '789123456',
     'F', DATE '2019-09-01', 68000, DATE '2019-09-01', 'ACTIVE', 0.092,
     '321 College Street', 'Toronto', 'Ontario', 'M5S 3M2');

    INSERT INTO members (employee_id, employer_id, first_name, last_name, email, phone, date_of_birth, sin, gender,
                        hire_date, salary_annual, membership_start_date, status, contribution_rate,
                        address_line1, city, province, postal_code) VALUES
    ('SEN002', v_seneca_id, 'Robert', 'Brown', 'robert.brown@senecacollege.ca', '416-555-0202', DATE '1975-09-30', '654321987',
     'M', DATE '2020-01-10', 89000, DATE '2020-01-10', 'ACTIVE', 0.092,
     '654 University Avenue', 'Toronto', 'Ontario', 'M5G 1X8');

    -- York Region Members
    INSERT INTO members (employee_id, employer_id, first_name, last_name, email, phone, date_of_birth, sin, gender,
                        hire_date, salary_annual, membership_start_date, status, contribution_rate,
                        address_line1, city, province, postal_code) VALUES
    ('YR001', v_yrdsb_id, 'Emily', 'Davis', 'emily.davis@yrdsb.ca', '905-555-0301', DATE '1988-02-14', '321987654',
     'F', DATE '2020-02-15', 72000, DATE '2020-02-15', 'ACTIVE', 0.092,
     '987 Richmond Hill Drive', 'Richmond Hill', 'Ontario', 'L4C 4Y7');

    INSERT INTO members (employee_id, employer_id, first_name, last_name, email, phone, date_of_birth, sin, gender,
                        hire_date, salary_annual, membership_start_date, status, contribution_rate,
                        address_line1, city, province, postal_code) VALUES
    ('YR002', v_yrdsb_id, 'David', 'Miller', 'david.miller@yrdsb.ca', '905-555-0302', DATE '1982-12-03', '159753468',
     'M', DATE '2021-08-30', 78000, DATE '2021-08-30', 'ACTIVE', 0.092,
     '147 Aurora Heights Drive', 'Aurora', 'Ontario', 'L4G 6X4');

    -- Terminated member example
    INSERT INTO members (employee_id, employer_id, first_name, last_name, email, phone, date_of_birth, sin, gender,
                        hire_date, termination_date, salary_annual, membership_start_date, membership_end_date, status, contribution_rate,
                        address_line1, city, province, postal_code) VALUES
    ('EMP999', v_tdsb_id, 'Former', 'Employee', 'former.employee@example.com', '416-555-0999', DATE '1979-06-18', '999888777',
     'F', DATE '2018-09-01', DATE '2023-12-31', 65000, DATE '2018-09-01', DATE '2023-12-31', 'TERMINATED', 0.092,
     '999 Past Lane', 'Toronto', 'Ontario', 'M1P 4V3');

END;
/

-- Insert sample contributions for active members
-- This will create contributions for the past 12 months
DECLARE
    CURSOR c_members IS
        SELECT member_id, employer_id, salary_annual, contribution_rate, hire_date
        FROM members
        WHERE status = 'ACTIVE';
        
    v_contribution_date DATE;
    v_monthly_salary NUMBER;
    v_member_contribution NUMBER;
    v_employer_contribution NUMBER;
BEGIN
    FOR member_rec IN c_members LOOP
        v_monthly_salary := member_rec.salary_annual / 12;
        
        -- Create contributions for the past 12 months
        FOR i IN 1..12 LOOP
            v_contribution_date := ADD_MONTHS(TRUNC(SYSDATE, 'MM'), -i);
            
            -- Only create contributions after hire date
            IF v_contribution_date >= member_rec.hire_date THEN
                v_member_contribution := ROUND(v_monthly_salary * member_rec.contribution_rate, 2);
                v_employer_contribution := v_member_contribution; -- Employer matches
                
                -- Insert member contribution
                INSERT INTO contributions (
                    member_id, employer_id, contribution_period_start, contribution_period_end,
                    contribution_type, pensionable_earnings, contribution_amount, contribution_rate,
                    contribution_date, payment_status
                ) VALUES (
                    member_rec.member_id, member_rec.employer_id, 
                    v_contribution_date, LAST_DAY(v_contribution_date),
                    'MEMBER', v_monthly_salary, v_member_contribution, member_rec.contribution_rate,
                    v_contribution_date + 5, 'PROCESSED'
                );
                
                -- Insert employer contribution
                INSERT INTO contributions (
                    member_id, employer_id, contribution_period_start, contribution_period_end,
                    contribution_type, pensionable_earnings, contribution_amount, contribution_rate,
                    contribution_date, payment_status
                ) VALUES (
                    member_rec.member_id, member_rec.employer_id, 
                    v_contribution_date, LAST_DAY(v_contribution_date),
                    'EMPLOYER', v_monthly_salary, v_employer_contribution, member_rec.contribution_rate,
                    v_contribution_date + 5, 'PROCESSED'
                );
            END IF;
        END LOOP;
    END LOOP;
END;
/

-- Insert sample news articles
INSERT INTO news_articles (title, slug, summary, content, category, author, featured, published, published_date,
                          image_url, read_time_minutes, target_audience, priority) VALUES
('CAAT Pension Plan Achieves Strong Performance in 2024',
 'caat-pension-strong-performance-2024',
 'CAAT Pension Plan reports 8.2% net return for 2024',
 'The CAAT Pension Plan is pleased to announce strong investment performance for 2024, with a net return of 8.2%. This performance continues our track record of delivering solid returns for our members while maintaining a focus on long-term sustainability. The plan''s diversified investment strategy and professional management have contributed to these positive results.',
 'performance', 'CAAT Communications Team', 1, 1, DATE '2024-12-15',
 '/images/news/performance-2024.jpg', 3, 'ALL', 1);

INSERT INTO news_articles (title, slug, summary, content, category, author, featured, published, published_date,
                          image_url, read_time_minutes, target_audience, priority) VALUES
('New Online Member Portal Features Now Available',
 'new-online-member-portal-features',
 'Enhanced online portal with new member features launched',
 'We''re excited to announce several new features in our online member portal, including enhanced pension projections, downloadable statements, and improved mobile experience. These updates make it easier than ever to track your pension benefits and plan for retirement.',
 'technology', 'Technology Team', 1, 1, DATE '2024-11-30',
 '/images/news/portal-update.jpg', 2, 'MEMBERS', 2);

INSERT INTO news_articles (title, slug, summary, content, category, author, featured, published, published_date,
                          image_url, read_time_minutes, target_audience, priority) VALUES
('CAAT Pension Plan Welcomes New Participating Employers',
 'new-participating-employers-2024',
 'Five new employers join CAAT Pension Plan',
 'We''re pleased to welcome five new employers to the CAAT Pension Plan family. This expansion strengthens our plan and provides pension security to more Canadian workers in the education sector.',
 'employers', 'Business Development', 0, 1, DATE '2024-10-20',
 '/images/news/new-employers.jpg', 2, 'EMPLOYERS', 3);

INSERT INTO news_articles (title, slug, summary, content, category, author, featured, published, published_date,
                          image_url, read_time_minutes, target_audience, priority) VALUES
('2024 Annual Members'' Meeting Highlights',
 'annual-members-meeting-2024-highlights',
 'Annual Members'' Meeting materials and recordings available',
 'The 2024 Annual Members'' Meeting was held virtually on October 15, featuring presentations on plan performance, governance updates, and a Q&A session with the Board of Trustees. Meeting materials and recordings are now available on our website.',
 'governance', 'Governance Team', 0, 1, DATE '2024-10-16',
 '/images/news/annual-meeting.jpg', 4, 'MEMBERS', 3);

-- Insert sample pension calculations
DECLARE
    CURSOR c_members IS
        SELECT member_id, hire_date, salary_annual
        FROM members
        WHERE status = 'ACTIVE'
        AND ROWNUM <= 3; -- Just for first 3 members as examples
        
    v_retirement_date DATE;
    v_years_service NUMBER;
    v_annual_pension NUMBER;
    v_monthly_pension NUMBER;
    v_result VARCHAR2(1000);
BEGIN
    FOR member_rec IN c_members LOOP
        -- Calculate pension at age 65
        v_retirement_date := ADD_MONTHS(SYSDATE, 60); -- Assume 5 years in future
        v_years_service := ROUND((v_retirement_date - member_rec.hire_date) / 365.25, 2);
        
        -- Simple calculation for sample data
        v_annual_pension := ROUND(v_years_service * 0.02 * member_rec.salary_annual, 2);
        v_monthly_pension := ROUND(v_annual_pension / 12, 2);
        
        INSERT INTO pension_calculations (
            member_id, calculation_type, effective_date, retirement_date,
            years_of_service, best_average_salary, pension_factor,
            annual_pension_amount, monthly_pension_amount,
            calculation_status, calculation_method
        ) VALUES (
            member_rec.member_id, 'ANNUAL_STATEMENT', SYSDATE, v_retirement_date,
            v_years_service, member_rec.salary_annual, 0.02,
            v_annual_pension, v_monthly_pension,
            'FINAL', 'SAMPLE_CALCULATION'
        );
    END LOOP;
END;
/

COMMIT;

-- Display summary of inserted data
SELECT 'EMPLOYERS' as table_name, COUNT(*) as record_count FROM employers
UNION ALL
SELECT 'MEMBERS', COUNT(*) FROM members
UNION ALL
SELECT 'CONTRIBUTIONS', COUNT(*) FROM contributions
UNION ALL
SELECT 'PENSION_CALCULATIONS', COUNT(*) FROM pension_calculations
UNION ALL
SELECT 'NEWS_ARTICLES', COUNT(*) FROM news_articles
ORDER BY table_name;
