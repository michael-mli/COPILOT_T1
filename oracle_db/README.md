# CAAT Pension Oracle Database

This directory contains the Oracle database schema, stored procedures, and sample data for the CAAT Pension system.

## Database Structure

### Tables
- **MEMBERS** - Pension plan members
- **EMPLOYERS** - Participating employers
- **CONTRIBUTIONS** - Member and employer contributions
- **PENSION_CALCULATIONS** - Pension benefit calculations
- **NEWS_ARTICLES** - News and announcements

### Folders
- `tables/` - DDL scripts for creating tables
- `procedures/` - Stored procedures and functions
- `views/` - Database views
- `triggers/` - Database triggers
- `data/` - Sample data insertion scripts

## Setup Instructions

1. Connect to Oracle database as system administrator
2. Create the CAAT_PENSION schema:
```sql
CREATE USER caat_pension IDENTIFIED BY password123;
GRANT DBA TO caat_pension;
```

3. Connect as caat_pension user and run the scripts in order:
```sql
-- Run table creation scripts
@tables/01_create_employers.sql
@tables/02_create_members.sql
@tables/03_create_contributions.sql
@tables/04_create_pension_calculations.sql
@tables/05_create_news_articles.sql

-- Run stored procedures
@procedures/member_procedures.sql
@procedures/contribution_procedures.sql
@procedures/pension_calculation_procedures.sql
@procedures/reporting_procedures.sql

-- Insert sample data
@data/sample_data.sql
```

## Database Design Features

- Proper referential integrity with foreign keys
- Audit trails with created_date and updated_date
- Indexes for performance optimization
- Stored procedures for business logic
- Views for complex queries
- Triggers for data validation and auditing
