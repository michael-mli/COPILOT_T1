from pydantic import BaseModel
from typing import Optional
from datetime import datetime

class NewsArticleBase(BaseModel):
    title: str
    content: str
    summary: Optional[str] = None
    category: str
    featured: bool = False
    published: bool = True

class NewsArticleCreate(NewsArticleBase):
    pass

class NewsArticle(NewsArticleBase):
    id: int
    slug: str
    author: str
    published_at: datetime
    updated_at: Optional[datetime] = None
    image_url: Optional[str] = None
    read_time_minutes: int
    
    class Config:
        from_attributes = True
