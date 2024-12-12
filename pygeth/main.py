import random

import uvicorn
from fastapi import FastAPI
from pydantic import BaseModel


def random_address():
    return f"0x{random.random()*100000000}"


class AccountJoinRequest(BaseModel):
    name: str
    address: str
    join_id: str


class FoodInsert(BaseModel):
    name: str
    insert_time: str
    due_date: str | None = None
    money_cost: float
    buyer_address: str
    group_id: str
    notes: str | None = None


class Food(BaseModel):
    name: str
    insert_time: str
    due_date: str | None = None
    money_cost: float
    buyer_address: str
    quantity_left_percentage: float
    food_address: str
    simpler_food_address: str
    group_id: str
    notes: str | None = None


class FoodUsageRecord(BaseModel):
    use_time: str
    use_food_group_id: str
    use_food_address: str
    use_food_amount_percentage: float
    participant_addresses: list[str]
    notes: str


class TransferRecord(BaseModel):
    transfer_time: str
    from_address: str
    to_address: str
    amount: float
    notes: str | None = None


class Database:
    def __init__(self):
        self.foods: list[Food] = []

    def insert(self, fi: FoodInsert):
        address = random_address()
        f = Food(
            name=fi.name,
            insert_time=fi.insert_time,
            due_date=fi.due_date,
            money_cost=fi.money_cost,
            buyer_address=fi.buyer_address,
            quantity_left_percentage=100,
            food_address=address,
            simpler_food_address=address[:4],
            group_id=fi.group_id,
            notes=fi.notes,
        )
        self.foods.append(f)


if __name__ == "__main__":
    db = Database()
    app = FastAPI()

    @app.get("/")
    async def read_root():
        return {"message": "查看 /docs 以獲得詳盡的 API Document"}

    @app.get("/helloworld")
    async def hello_world():
        """回傳 \"Hello, World!\" """
        return {"message": "Hello, World!"}

    @app.get("/account/single")
    async def single_account_data(address: str):
        """取得指定 address 的資料"""
        return {
            "message": f"已收到你的請求，你的地址是 {address}。回傳的 data 僅包含你的資料",
            "name": "小明",
            "address": address,
            "group_id": "decen",
            "balance": 50,
        }

    @app.get("/account/all/")
    async def all_account_data(group_id: str):
        """回傳指定 group 中所有 account 的資料"""
        return {
            "message": f"已收到你的請求，回傳 group_id: {group_id} 的所有 account 資料",
            "group_id": group_id,
            "account": [
                {"name": "小明", "address": "0x123", "balance": 50},
                {"name": "小華", "address": "0x125", "balance": 500},
                {"name": "小美", "address": "0x127", "balance": 5269},
            ],
        }

    @app.get("/account/transfer/")
    async def all_transfer_records_in_group(group_id: str):
        """回傳指定 group 中所有的交易記錄"""
        return {
            "message": f"已收到你的請求，回傳 group_id: {group_id} 的所有交易記錄",
            "group_id": group_id,
            "transactions": [
                {
                    "transfer_time": "1733927340000000",
                    "from_address": "0x123",
                    "from_name": "小明",
                    "to_address": "0x125",
                    "to_name": "小華",
                    "amount": 30,
                    "notes": "還給你",
                },
                {
                    "transfer_time": "1733927240000000",
                    "from_address": "0x125",
                    "from_name": "小華",
                    "to_address": "0x123",
                    "to_name": "小明",
                    "amount": 30,
                    "notes": "轉帳測試",
                },
            ],
        }

    @app.post("/account/transfer/")
    async def account_transfer(record: TransferRecord):
        """新增轉帳記錄"""
        processed = record
        processed.notes = (
            f"已成功收到您的新增轉帳記錄，原本您留的 notes: {record.notes}"
        )
        return processed

    @app.post("/account/join_group/")
    async def join_group(request: AccountJoinRequest):
        """將帳戶加入群組"""
        addr = request.address
        join_id = request.join_id
        return {
            "message": f"已收到 {addr} 加入 id: {join_id} 群組的請求",
            "address": addr,
            "join_id": join_id,
        }

    @app.get("/food/all/")
    async def get_all_food(group_id: str):
        """取得指定 group 中所有尚有存量的食物資料"""
        return {
            "message": f"回傳 group_id 為 {group_id} 且尚有存量的食物列表",
            "food": db.foods,
        }

    @app.post("/food/insert/")
    async def insert_food(food: FoodInsert):
        """在指定的 group 中新增食物"""
        processed = food
        print(food)
        processed.notes = f"已成功收到您的新增食物記錄，原本您留的 notes: {food.notes}"
        db.insert(food)
        return processed

    @app.post("/food/use/")
    async def use_food(record: FoodUsageRecord):
        """使用指定的食物"""
        processed = record
        processed.notes = (
            f"已成功收到您的使用食材記錄，原本您留的 notes: {record.notes}"
        )
        return processed

    config = uvicorn.Config(app, host="0.0.0.0", port=25565)
    server = uvicorn.Server(config)
    server.run()
