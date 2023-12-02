import motor.motor_asyncio
from bson.objectid import ObjectId

MONGO_DETAILS = "mongodb://localhost:27017"

client = motor.motor_asyncio.AsyncIOMotorClient(MONGO_DETAILS)

database = client.image

image_collection = database.get_collection("images_collection")


class HistoryItem:
    def __init__(self, imagePath, locationInfo):
        self.imagePath = imagePath
        self.locationInfo = locationInfo


# helpers
def history_item_helper(history_item) -> HistoryItem:
    return HistoryItem(
        imagePath=history_item["imagePath"],
        locationInfo=history_item["locationInfo"],
    )


# Retrieve all history items present in the database
async def retrieve_history_items():
    history_items = []
    async for item in image_collection.find():
        history_items.append(history_item_helper(item))
    return history_items


# Add a new history item into the database
async def add_history_item(history_item_data: HistoryItem) -> HistoryItem:
    history_item_dict = {
        "imagePath": history_item_data["imagePath"],
        "locationInfo": history_item_data["locationInfo"],
    }
    result = await image_collection.insert_one(history_item_dict)
    new_history_item = await image_collection.find_one({"_id": result.inserted_id})
    return history_item_helper(new_history_item)


# Retrieve a history item with a matching ID
async def retrieve_history_item(id: str) -> HistoryItem:
    history_item = await image_collection.find_one({"_id": ObjectId(id)})
    if history_item:
        return history_item_helper(history_item)


