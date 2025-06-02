from typing import List, Optional
from datetime import datetime
from app.models.news import NewsArticle

class NewsService:
    def __init__(self):
        # Mock news data - in production this would use a database
        self.articles = [
            {
                "id": 1,
                "title": "CAAT Pension Plan Achieves Strong Performance in 2024",
                "content": "The CAAT Pension Plan is pleased to announce strong investment performance for 2024, with a net return of 8.2%. This performance continues our track record of delivering solid returns for our members while maintaining a focus on long-term sustainability.",
                "summary": "CAAT Pension Plan reports 8.2% net return for 2024",
                "category": "performance",
                "featured": True,
                "published": True,
                "slug": "caat-pension-strong-performance-2024",
                "author": "CAAT Communications Team",
                "published_at": datetime(2024, 12, 15),
                "updated_at": None,
                "image_url": "/images/news/performance-2024.jpg",
                "read_time_minutes": 3
            },
            {
                "id": 2,
                "title": "New Online Member Portal Features Now Available",
                "content": "We're excited to announce several new features in our online member portal, including enhanced pension projections, downloadable statements, and improved mobile experience. These updates make it easier than ever to track your pension benefits.",
                "summary": "Enhanced online portal with new member features launched",
                "category": "technology",
                "featured": True,
                "published": True,
                "slug": "new-online-member-portal-features",
                "author": "Technology Team",
                "published_at": datetime(2024, 11, 30),
                "updated_at": None,
                "image_url": "/images/news/portal-update.jpg",
                "read_time_minutes": 2
            },
            {
                "id": 3,
                "title": "CAAT Pension Plan Welcomes New Participating Employers",
                "content": "We're pleased to welcome five new employers to the CAAT Pension Plan family. This expansion strengthens our plan and provides pension security to more Canadian workers in the education sector.",
                "summary": "Five new employers join CAAT Pension Plan",
                "category": "employers",
                "featured": False,
                "published": True,
                "slug": "new-participating-employers-2024",
                "author": "Business Development",
                "published_at": datetime(2024, 10, 20),
                "updated_at": None,
                "image_url": "/images/news/new-employers.jpg",
                "read_time_minutes": 2
            },
            {
                "id": 4,
                "title": "2024 Annual Members' Meeting Highlights",
                "content": "The 2024 Annual Members' Meeting was held virtually on October 15, featuring presentations on plan performance, governance updates, and a Q&A session with the Board of Trustees. Meeting materials and recordings are now available.",
                "summary": "Annual Members' Meeting materials and recordings available",
                "category": "governance",
                "featured": False,
                "published": True,
                "slug": "annual-members-meeting-2024-highlights",
                "author": "Governance Team",
                "published_at": datetime(2024, 10, 16),
                "updated_at": None,
                "image_url": "/images/news/annual-meeting.jpg",
                "read_time_minutes": 4
            }
        ]

    async def get_articles(self, skip: int = 0, limit: int = 10, category: Optional[str] = None) -> List[NewsArticle]:
        filtered_articles = self.articles
        
        if category:
            filtered_articles = [article for article in filtered_articles if article["category"] == category]
        
        # Sort by published date (newest first)
        filtered_articles = sorted(filtered_articles, key=lambda x: x["published_at"], reverse=True)
        
        # Apply pagination
        paginated_articles = filtered_articles[skip:skip + limit]
        
        return [NewsArticle(**article) for article in paginated_articles]

    async def get_article_by_id(self, article_id: int) -> Optional[NewsArticle]:
        for article in self.articles:
            if article["id"] == article_id:
                return NewsArticle(**article)
        return None

    async def get_featured_articles(self, limit: int = 3) -> List[NewsArticle]:
        featured_articles = [article for article in self.articles if article["featured"]]
        featured_articles = sorted(featured_articles, key=lambda x: x["published_at"], reverse=True)
        featured_articles = featured_articles[:limit]
        
        return [NewsArticle(**article) for article in featured_articles]

    async def get_categories(self) -> List[str]:
        categories = set()
        for article in self.articles:
            categories.add(article["category"])
        return sorted(list(categories))
