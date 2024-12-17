import uvicorn
from database import Database
from datatypes import AccountJoin, FoodInsert, FoodUsageRecord, TransferRequest
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware


def server_with_ip(ip: str, port: int):
    db = Database()

    app = FastAPI()
    app.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

    @app.get("/")
    async def read_root():
        return {"message": "查看 /docs 以獲得詳盡的 API Document"}

    @app.get("/helloworld/")
    async def hello_world():
        """回傳 \"Hello, World!\" """
        return {"message": "Hello, World!"}

    @app.get("/account/single/")
    async def single_account(address: str, group_id):
        """取得指定 account 的資料"""
        return {
            "message": f"地址為 {address} 的帳戶的資料",
            "data": db.single_account(address=address, group_id=group_id),
        }

    @app.get("/account/all/")
    async def all_account_data(group_id: str):
        """回傳指定 group 中所有 account 的資料"""
        return {
            "message": f"group_id: {group_id} 的所有 account 的資料",
            "data": db.all_accounts(group_id=group_id),
        }

    @app.get("/account/transfer/")
    async def all_transfer_records_in_group(group_id: str):
        """回傳指定 group 中所有的交易記錄"""
        return {
            "message": f"group_id: {group_id} 的所有交易記錄",
            "data": db.all_transactions(group_id=group_id),
        }

    @app.post("/account/transfer/")
    async def account_transfer(record: TransferRequest):
        if db.transfer(record):
            return {"message": "轉帳成功"}
        else:
            return {"message": "轉帳失敗"}

    @app.post("/account/join_group/")
    async def join_group(aj: AccountJoin):
        """將帳戶加入群組"""
        return db.account_join_group(aj=aj)

    @app.get("/food/single/")
    async def single_food_data(address: str, group_id: str):
        """取得指定 address 食物的資料"""
        return db.single_food(address=address, group_id=group_id)

    @app.get("/food/all/")
    async def get_all_food(group_id: str):
        """取得指定 group 中所有的食物資料"""
        return db.all_foods(group_id=group_id)

    @app.get("/food/pie/")
    async def get_food_pie(group_id: str):
        """取得指定 group 中所有的食物的百分比"""
        return db.food_pies(group_id=group_id)

    @app.post("/food/insert/")
    async def insert_food(fi: FoodInsert):
        """新增食物"""
        return db.insert_food(fi)

    @app.post("/food/use/")
    async def use_food(record: FoodUsageRecord):
        """使用指定的食物"""
        return db.use_food(record=record)

    config = uvicorn.Config(app, host=ip, port=port)
    return uvicorn.Server(config)
