-- CAAT Pension Database - News Articles Table
-- Stores news articles and announcements for the website

CREATE TABLE news_articles (
    article_id NUMBER(10) PRIMARY KEY,
    title VARCHAR2(500) NOT NULL,
    slug VARCHAR2(200) UNIQUE NOT NULL,
    summary VARCHAR2(1000),
    content CLOB NOT NULL,
    category VARCHAR2(50) NOT NULL,
    author VARCHAR2(100) NOT NULL,
    featured NUMBER(1) DEFAULT 0 CHECK (featured IN (0, 1)),
    published NUMBER(1) DEFAULT 0 CHECK (published IN (0, 1)),
    published_date DATE,
    scheduled_publish_date DATE,
    expiry_date DATE,
    image_url VARCHAR2(500),
    image_alt_text VARCHAR2(200),
    meta_description VARCHAR2(300),
    meta_keywords VARCHAR2(500),
    read_time_minutes NUMBER(3),
    view_count NUMBER(10) DEFAULT 0,
    tags VARCHAR2(1000), -- Comma-separated tags
    target_audience VARCHAR2(50), -- MEMBERS, EMPLOYERS, PUBLIC, ALL
    priority NUMBER(1) DEFAULT 3 CHECK (priority BETWEEN 1 AND 5), -- 1=Highest, 5=Lowest
    language VARCHAR2(5) DEFAULT 'EN',
    related_articles VARCHAR2(500), -- Comma-separated article IDs
    external_link VARCHAR2(500),
    pdf_attachment VARCHAR2(500),
    created_date DATE DEFAULT SYSDATE,
    updated_date DATE,
    created_by VARCHAR2(50) DEFAULT USER,
    updated_by VARCHAR2(50)
);

-- Create sequence for article_id
CREATE SEQUENCE news_articles_seq
    START WITH 3000
    INCREMENT BY 1
    NOCACHE;

-- Create trigger for auto-incrementing article_id
CREATE OR REPLACE TRIGGER news_articles_pk_trigger
    BEFORE INSERT ON news_articles
    FOR EACH ROW
BEGIN
    IF :NEW.article_id IS NULL THEN
        :NEW.article_id := news_articles_seq.NEXTVAL;
    END IF;
END;
/

-- Create trigger for calculating derived fields and validation
CREATE OR REPLACE TRIGGER news_articles_trigger
    BEFORE INSERT OR UPDATE ON news_articles
    FOR EACH ROW
BEGIN
    -- Auto-generate slug from title if not provided
    IF :NEW.slug IS NULL THEN
        :NEW.slug := LOWER(REGEXP_REPLACE(REGEXP_REPLACE(:NEW.title, '[^A-Za-z0-9\s]', ''), '\s+', '-'));
        -- Ensure slug is unique by appending timestamp if needed
        IF LENGTH(:NEW.slug) > 150 THEN
            :NEW.slug := SUBSTR(:NEW.slug, 1, 140) || '-' || TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS');
        END IF;
    END IF;
    
    -- Calculate estimated reading time (assuming 200 words per minute)
    IF :NEW.content IS NOT NULL AND :NEW.read_time_minutes IS NULL THEN
        :NEW.read_time_minutes := GREATEST(1, CEIL(LENGTH(REGEXP_REPLACE(:NEW.content, '<[^>]+>', '')) / 1000)); -- Rough word count
    END IF;
    
    -- Set published date when article is published
    IF :NEW.published = 1 AND :OLD.published != 1 AND :NEW.published_date IS NULL THEN
        :NEW.published_date := SYSDATE;
    END IF;
    
    -- Auto-generate meta description from summary or content
    IF :NEW.meta_description IS NULL THEN
        IF :NEW.summary IS NOT NULL THEN
            :NEW.meta_description := SUBSTR(:NEW.summary, 1, 250);
        ELSE
            :NEW.meta_description := SUBSTR(REGEXP_REPLACE(:NEW.content, '<[^>]+>', ''), 1, 250);
        END IF;
    END IF;
    
    -- Set default values
    IF :NEW.target_audience IS NULL THEN
        :NEW.target_audience := 'ALL';
    END IF;
    
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
CREATE INDEX idx_news_category ON news_articles(category);
CREATE INDEX idx_news_published ON news_articles(published, published_date);
CREATE INDEX idx_news_featured ON news_articles(featured);
CREATE INDEX idx_news_author ON news_articles(author);
CREATE INDEX idx_news_audience ON news_articles(target_audience);
CREATE INDEX idx_news_priority ON news_articles(priority);
CREATE INDEX idx_news_slug ON news_articles(slug);
CREATE INDEX idx_news_scheduled ON news_articles(scheduled_publish_date);

-- Create composite indexes for common queries
CREATE INDEX idx_news_pub_cat ON news_articles(published, category, published_date);
CREATE INDEX idx_news_featured_pub ON news_articles(featured, published, published_date);

-- Add comments
COMMENT ON TABLE news_articles IS 'News articles and announcements for the CAAT Pension website';
COMMENT ON COLUMN news_articles.slug IS 'URL-friendly version of the title';
COMMENT ON COLUMN news_articles.featured IS '1 if featured on homepage, 0 otherwise';
COMMENT ON COLUMN news_articles.read_time_minutes IS 'Estimated reading time in minutes';
COMMENT ON COLUMN news_articles.target_audience IS 'Target audience: MEMBERS, EMPLOYERS, PUBLIC, or ALL';
COMMENT ON COLUMN news_articles.priority IS 'Display priority: 1=Highest, 5=Lowest';
