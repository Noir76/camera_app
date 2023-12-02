from typing import Optional
from pydantic import BaseModel, Field

class HistoryItemSchema(BaseModel):
    imagePath: str = Field(...)
    locationInfo: str = Field(...)

    # class Config:
    #     schema_extra = {
    #         "example": {
    #             "imagePath": "/path/to/image.jpg",
    #             "locationInfo": "City, Country",
    #         }
    #     }

class UpdateHistoryItemModel(BaseModel):
    imagePath: Optional[str]
    locationInfo: Optional[str]

    class Config:
        schema_extra = {
            "example": {
                "imagePath": "/path/to/new_image.jpg",
                "locationInfo": "New City, New Country",
            }
        }

def ResponseModel(data, message):
    return {
        "data": [data],
        "code": 200,
        "message": message,
    }

def ErrorResponseModel(error, code, message):
    return {"error": error, "code": code, "message": message}
