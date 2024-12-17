from pydantic import BaseModel


class Account(BaseModel):
    name: str
    address: str
    group_id: str
    balance: float


class AccountJoin(BaseModel):
    name: str
    address: str
    group_id: str


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


class FoodPie(BaseModel):
    name: str
    rate: float


class FoodUsageRecord(BaseModel):
    use_time: str
    use_food_group_id: str
    use_food_address: str
    use_food_amount_percentage: float
    user_address: str
    notes: str


class TransferRequest(BaseModel):
    transfer_time: str
    from_address: str
    to_address: str
    amount: float
    group_id: str
    notes: str | None = None


class TransferRecord(BaseModel):
    transfer_time: str
    from_address: str
    from_name: str
    to_address: str
    to_name: str
    amount: float
    group_id: str
    notes: str | None = None
