from fastapi import APIRouter, HTTPException, Query
from typing import List, Optional
from app.models.news import NewsArticle, NewsArticleCreate
from app.services.news_service import NewsService

router = APIRouter()
news_service = NewsService()

@router.get("/", response_model=List[NewsArticle])
async def get_news_articles(
    skip: int = Query(0, ge=0),
    limit: int = Query(10, ge=1, le=100),
    category: Optional[str] = None
):
    """Get news articles with pagination and optional category filter"""
    try:
        articles = await news_service.get_articles(skip=skip, limit=limit, category=category)
        return articles
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@router.get("/{article_id}", response_model=NewsArticle)
async def get_news_article(article_id: int):
    """Get a specific news article by ID"""
    try:
        article = await news_service.get_article_by_id(article_id)
        if not article:
            raise HTTPException(status_code=404, detail="Article not found")
        return article
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))

@router.get("/featured/latest", response_model=List[NewsArticle])
async def get_featured_articles(limit: int = Query(3, ge=1, le=10)):
    """Get featured news articles for homepage"""
    try:
        articles = await news_service.get_featured_articles(limit=limit)
        return articles
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@router.get("/categories/", response_model=List[str])
async def get_news_categories():
    """Get all available news categories"""
    try:
        categories = await news_service.get_categories()
        return categories
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
