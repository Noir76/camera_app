from fastapi import APIRouter, Body
from fastapi.encoders import jsonable_encoder

from server.config.db import (
    add_history_item,
    # delete_history_item,
    retrieve_history_item,
    retrieve_history_items,
    # update_history_item,
)
from server.models.image import (
    ErrorResponseModel,
    ResponseModel,      
    HistoryItemSchema,
    # UpdateHistoryItemModel,
)

router = APIRouter()

@router.post("/upload", response_description="History item added into the database")
async def add_history_item_data(history_item: HistoryItemSchema = Body(...)):
    history_item = jsonable_encoder(history_item)
    new_history_item = await add_history_item(history_item)
    return ResponseModel(new_history_item, "History item added successfully.")



@router.get("/", response_description="History items retrieved")
async def get_history_items():
    history_items = await retrieve_history_items()
    if history_items:
        return ResponseModel(history_items, "History items data retrieved successfully")
    return ResponseModel(history_items, "Empty list returned")

@router.get("/{id}", response_description="History item data retrieved")
async def get_history_item_data(id):
    history_item = await retrieve_history_item(id)
    if history_item:
        return ResponseModel(history_item, "History item data retrieved successfully")
    return ErrorResponseModel("An error occurred.", 404, "History item doesn't exist.")


