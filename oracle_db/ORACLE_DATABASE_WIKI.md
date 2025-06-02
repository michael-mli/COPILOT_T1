# CAAT Pension Oracle Database Wiki

## Overview

This wiki provides comprehensive documentation for the CAAT Pension Oracle database schema, stored procedures, and data management system. The database is designed to support a complete pension management system for Canadian education sector employees.

## Table of Contents

1. [Database Architecture](#database-architecture)
2. [Table Schema Documentation](#table-schema-documentation)
3. [Stored Procedures](#stored-procedures)
4. [Data Management](#data-management)
5. [Setup and Installation](#setup-and-installation)
6. [Business Rules](#business-rules)
7. [API Integration](#api-integration)
8. [Maintenance and Monitoring](#maintenance-and-monitoring)

## Database Architecture

### Design Principles

The CAAT Pension database follows these key design principles:

- **Normalized Structure**: Tables are designed to 3NF to minimize redundancy
- **Audit Trail**: All tables include created_date and updated_date for tracking
- **Data Integrity**: Comprehensive constraints and foreign keys ensure data quality
- **Performance**: Strategic indexing and optimized queries
- **Security**: Role-based access control and data encryption ready

### Entity Relationship Overview

```
EMPLOYERS (1) -----> (M) MEMBERS (1) -----> (M) CONTRIBUTIONS
    |                     |                        |
    |                     v                        |
    |              PENSION_CALCULATIONS            |
    |                                              |
    +-------------- NEWS_ARTICLES ----------------+
```

## Table Schema Documentation

### 1. EMPLOYERS Table

**Purpose**: Stores information about participating employers in the pension plan.

**Key Fields**:
- `employer_id` (PK): Unique identifier
- `employer_code`: Business identifier (e.g., 'TDSB', 'SENECA')
- `sector`: Education sector classification
- `employee_count`: Current active employees
- `status`: ACTIVE, INACTIVE, SUSPENDED

**Business Rules**:
- Employer code must be unique across the system
- Only ACTIVE employers can register new members
- Employee count is updated automatically via triggers

**Sample Data**: 5 educational institutions including TDSB, Seneca College, York Region DSB

### 2. MEMBERS Table

**Purpose**: Central registry of all pension plan members (employees).

**Key Fields**:
- `member_id` (PK): Unique member identifier
- `employee_id`: Employer-specific employee number
- `employer_id` (FK): Links to employers table
- `sin`: Social Insurance Number (encrypted)
- `salary_annual`: Current annual salary
- `contribution_rate`: Member contribution percentage
- `status`: ACTIVE, INACTIVE, TERMINATED, RETIRED

**Business Rules**:
- SIN must be unique and validated
- Contribution rate defaults to 9.2% (standard CAAT rate)
- Membership start date cannot be before hire date
- Terminated members retain historical data

**Privacy & Security**:
- SIN field is designed for encryption
- Personal information access is logged
- Data retention policies apply to terminated members

### 3. CONTRIBUTIONS Table

**Purpose**: Tracks all member and employer pension contributions.

**Key Fields**:
- `contribution_id` (PK): Unique contribution record
- `member_id` (FK): Links to members table
- `contribution_type`: MEMBER, EMPLOYER, VOLUNTARY
- `pensionable_earnings`: Earnings subject to pension
- `contribution_amount`: Actual contribution amount
- `payment_status`: PENDING, PROCESSED, FAILED

**Business Rules**:
- Contributions are matched 1:1 between member and employer
- Monthly contribution periods (start/end dates)
- Late payments incur interest calculations
- Voluntary contributions have different limits

**Financial Controls**:
- All contributions require approval workflow
- Automatic reconciliation with payroll systems
- Monthly reporting and variance analysis

### 4. PENSION_CALCULATIONS Table

**Purpose**: Stores pension benefit calculations and projections.

**Key Fields**:
- `calculation_id` (PK): Unique calculation identifier
- `member_id` (FK): Links to members table
- `calculation_type`: ANNUAL_STATEMENT, RETIREMENT_ESTIMATE, TERMINATION
- `years_of_service`: Credited service years
- `best_average_salary`: Best 5-year average (CAAT formula)
- `pension_factor`: Accrual rate (typically 2% per year)
- `annual_pension_amount`: Calculated annual pension

**Calculation Types**:
- **ANNUAL_STATEMENT**: Yearly benefit statements
- **RETIREMENT_ESTIMATE**: Member-requested projections
- **TERMINATION**: Final benefit calculations
- **SURVIVOR_BENEFIT**: Spousal benefit calculations

**Formula Implementation**:
```
Annual Pension = Years of Service × Pension Factor × Best Average Salary
Monthly Pension = Annual Pension ÷ 12
```

### 5. NEWS_ARTICLES Table

**Purpose**: Content management for pension plan communications.

**Key Fields**:
- `article_id` (PK): Unique article identifier
- `slug`: URL-friendly identifier
- `category`: performance, technology, governance, employers
- `target_audience`: ALL, MEMBERS, EMPLOYERS, RETIREES
- `featured`: Boolean for homepage display
- `priority`: Display priority (1=highest)

**Content Management**:
- Rich text content with HTML support
- SEO-friendly slugs and metadata
- Scheduled publishing capabilities
- Multi-audience targeting

## Stored Procedures

### Member Management Procedures

#### `sp_register_member`
**Purpose**: Register a new pension plan member

**Parameters**:
- Input: Employee details, employer ID, salary information
- Output: New member ID, result status

**Business Logic**:
- Validates employer exists and is active
- Checks for duplicate SIN/employee ID
- Calculates contribution rate based on employment terms
- Creates audit trail entry

**Usage Example**:
```sql
DECLARE
    v_member_id NUMBER;
    v_result VARCHAR2(200);
BEGIN
    sp_register_member(
        p_employee_id => 'EMP001',
        p_employer_id => 1,
        p_first_name => 'John',
        p_last_name => 'Doe',
        p_email => 'john.doe@employer.ca',
        p_phone => '416-555-0101',
        p_date_of_birth => DATE '1985-03-15',
        p_sin => '123456789',
        p_gender => 'M',
        p_hire_date => DATE '2024-01-15',
        p_salary_annual => 75000,
        p_member_id => v_member_id,
        p_result => v_result
    );
    
    DBMS_OUTPUT.PUT_LINE('Result: ' || v_result);
    DBMS_OUTPUT.PUT_LINE('Member ID: ' || v_member_id);
END;
/
```

#### `sp_update_member_status`
**Purpose**: Update member employment status

**Business Logic**:
- Validates status transitions
- Updates membership end date for terminations
- Triggers pension calculation for retirees
- Maintains data integrity

#### `sp_get_member_details`
**Purpose**: Retrieve comprehensive member information

**Returns**: Member demographics, employment history, contribution summary

### Contribution Processing Procedures

#### `sp_process_contribution`
**Purpose**: Process and validate pension contributions

**Parameters**:
- Input: Member ID, contribution details, payment information
- Output: Contribution ID, processing status

**Business Logic**:
- Validates contribution limits and rules
- Calculates employer matching contributions
- Updates member contribution totals
- Generates payment confirmations

#### `sp_calculate_monthly_contributions`
**Purpose**: Batch process monthly contributions for all active members

**Processing Steps**:
1. Identify active members with salary changes
2. Calculate contribution amounts based on current rates
3. Generate contribution records for member and employer
4. Update employer contribution summaries
5. Generate exception reports for manual review

### Pension Calculation Procedures

#### `sp_calculate_pension_benefit`
**Purpose**: Calculate pension benefits using CAAT formula

**Parameters**:
- Input: Member ID, calculation type, effective date
- Output: Pension amounts, calculation details

**CAAT Pension Formula**:
```
Annual Pension = Years of Service × 2% × Best 5-Year Average Salary
```

**Special Considerations**:
- Early retirement reductions
- Survivor benefit calculations
- Indexation adjustments
- Maximum pension limits

#### `sp_generate_annual_statement`
**Purpose**: Create annual benefit statements for members

**Generated Information**:
- Current pension entitlement
- Contribution history summary
- Projected retirement benefits
- Vesting status and portability options

### Reporting Procedures

#### `sp_employer_contribution_report`
**Purpose**: Generate employer contribution summaries

**Report Sections**:
- Monthly contribution totals
- Employee contribution matching
- Outstanding payment tracking
- Year-over-year comparisons

#### `sp_plan_performance_metrics`
**Purpose**: Calculate key plan performance indicators

**Metrics Included**:
- Total plan assets
- Member growth rates
- Contribution compliance rates
- Average pension amounts by demographics

## Data Management

### Sample Data Overview

The database includes comprehensive sample data representing realistic pension plan scenarios:

**Employers (5 records)**:
- Toronto District School Board (15,000 employees)
- Seneca College (3,500 employees)
- York Region District School Board (12,000 employees)
- Centennial College (2,800 employees)
- Ontario College of Art and Design (850 employees)

**Members (9 records)**:
- Active members across different employers
- Various hire dates and salary levels
- One terminated member for testing
- Different demographic profiles

**Contributions (216+ records)**:
- 12 months of historical contributions
- Both member and employer contributions
- Realistic contribution amounts based on salaries
- Various payment statuses

**News Articles (4 records)**:
- Plan performance updates
- Technology announcements
- Governance communications
- Employer-focused content

### Data Loading Process

1. **Employers**: Load participating organizations first
2. **Members**: Register employees with valid employer references
3. **Contributions**: Generate historical contribution data
4. **Calculations**: Create sample pension projections
5. **News**: Populate member communications

### Data Validation Rules

- All foreign key relationships must be valid
- Dates must be logically consistent (hire < termination)
- Contribution amounts must match salary and rate calculations
- Status values must be from approved lists

## Setup and Installation

### Prerequisites

- Oracle Database 12c or higher
- User account with CREATE TABLE, CREATE PROCEDURE privileges
- Sufficient tablespace for pension data growth
- Backup and recovery procedures in place

### Installation Steps

1. **Create Database Schema**:
   ```sql
   -- Connect as privileged user
   @tables/01_create_employers.sql
   @tables/02_create_members.sql
   @tables/03_create_contributions.sql
   @tables/04_create_pension_calculations.sql
   @tables/05_create_news_articles.sql
   ```

2. **Install Stored Procedures**:
   ```sql
   @procedures/member_procedures.sql
   @procedures/contribution_procedures.sql
   @procedures/pension_calculation_procedures.sql
   @procedures/reporting_procedures.sql
   ```

3. **Load Sample Data**:
   ```sql
   @data/sample_data.sql
   ```

4. **Verify Installation**:
   ```sql
   -- Check table creation
   SELECT table_name, num_rows 
   FROM user_tables 
   WHERE table_name IN ('EMPLOYERS', 'MEMBERS', 'CONTRIBUTIONS', 'PENSION_CALCULATIONS', 'NEWS_ARTICLES');
   
   -- Verify procedures
   SELECT object_name, status 
   FROM user_objects 
   WHERE object_type = 'PROCEDURE';
   ```

### Security Configuration

- Create role-based access for different user types
- Implement data encryption for sensitive fields (SIN)
- Configure audit logging for data access
- Set up row-level security for multi-employer access

## Business Rules

### Member Eligibility
- Must be employed by participating employer
- Minimum age requirements may apply
- Probationary periods before enrollment
- Part-time vs full-time contribution differences

### Contribution Rules
- Standard rate: 9.2% of pensionable earnings
- Employer matching: 1:1 ratio
- Annual contribution limits apply
- Voluntary additional contributions permitted

### Vesting and Portability
- 2-year vesting period for employer contributions
- Reciprocal agreements with other pension plans
- Portability options for terminated members
- Locked-in retirement account transfers

### Pension Benefits
- Normal retirement age: 65
- Early retirement options with reductions
- Disability pension provisions
- Survivor benefit guarantees

## API Integration

### FastAPI Backend Integration

The Oracle database integrates with the FastAPI backend through:

**Connection Management**:
- Oracle client library (cx_Oracle/oracledb)
- Connection pooling for performance
- Environment-based configuration

**Data Models Mapping**:
```python
# Example Pydantic model mapping
class Member(BaseModel):
    member_id: Optional[int]
    employee_id: str
    employer_id: int
    first_name: str
    last_name: str
    email: str
    # ... additional fields
```

**Service Layer Integration**:
- Database service classes for each entity
- Transaction management
- Error handling and logging

### API Endpoints Supported

- `/api/v1/members/` - Member management
- `/api/v1/employers/` - Employer operations
- `/api/v1/contributions/` - Contribution processing
- `/api/v1/news/` - Content management

## Maintenance and Monitoring

### Regular Maintenance Tasks

**Daily**:
- Monitor contribution processing
- Check data integrity constraints
- Review error logs and exceptions

**Weekly**:
- Contribution reconciliation
- Performance metrics review
- Backup verification

**Monthly**:
- Generate employer reports
- Update pension calculations
- Data quality audits

**Annually**:
- Annual statement generation
- Actuarial data extracts
- Archive historical data

### Performance Monitoring

**Key Metrics**:
- Query response times
- Contribution processing volumes
- Database growth rates
- Error rates and types

**Optimization Strategies**:
- Index performance tuning
- Query optimization
- Partition strategy for large tables
- Archival of historical data

### Troubleshooting Guide

**Common Issues**:

1. **Contribution Processing Failures**
   - Check employer active status
   - Verify member eligibility
   - Review contribution rate calculations

2. **Data Integrity Violations**
   - Foreign key constraint errors
   - Date validation failures
   - Duplicate record issues

3. **Performance Problems**
   - Long-running queries
   - Lock contention
   - Memory issues

**Support Contacts**:
- Database Administrator: [DBA contact]
- Application Support: [App support]
- Business Analyst: [BA contact]

## Version History

| Version | Date | Changes | Author |
|---------|------|---------|--------|
| 1.0 | 2024-12-19 | Initial database schema and procedures | Development Team |
| 1.1 | TBD | Performance optimizations | TBD |
| 1.2 | TBD | Additional reporting features | TBD |

## Related Documentation

- [FastAPI Backend Documentation](../backend/README.md)
- [Vue.js Frontend Documentation](../README.md)
- [System Architecture Overview](../project_wiki.md)
- [API Documentation](../backend/app/api/v1/api.py)

---

*This wiki is maintained by the CAAT Pension development team. For questions or updates, please contact the project maintainers.*
