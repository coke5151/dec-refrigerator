import random

from datatypes import (
    Account,
    AccountJoin,
    Food,
    FoodInsert,
    FoodPie,
    FoodUsageRecord,
    TransferRecord,
    TransferRequest,
)


def random_address():
    hex_chars = "0123456789abcdef"
    random_hex = "".join(random.choice(hex_chars) for _ in range(40))
    return f"0x{random_hex}"


class Database:
    def __init__(self):
        self.foods: dict[str, list[Food]] = dict()
        self.groups: dict[str, list[Account]] = dict()
        self.transactions: dict[str, list[TransferRequest]] = dict()

    def insert_food(self, fi: FoodInsert):
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
        if fi.group_id not in self.foods:
            self.foods[fi.group_id] = list()
        self.foods[fi.group_id].append(f)
        return {"message": "成功新增食物"}

    def single_food(self, address: str, group_id: str):
        the_food_group = list()

        if group_id in self.foods:
            the_food_group = self.foods[group_id]

        for f in the_food_group:
            if f.food_address == address:
                return f
        return None

    def all_foods(self, group_id):
        if group_id not in self.foods:
            empty_list = list()
            empty_list.append(
                Food(
                    name="目前尚無庫存",
                    insert_time="入庫日期",
                    due_date="保存期限",
                    money_cost=0,
                    buyer_address="",
                    quantity_left_percentage=0.0,
                    food_address="食材地址",
                    simpler_food_address="",
                    group_id=group_id,
                    notes="",
                ),
            )
            return empty_list
        return self.foods[group_id]

    def food_pies(self, group_id):
        all_food = self.all_foods(group_id)
        food_pies = list()
        sum_value = 0
        for food in all_food:
            value = food.money_cost * food.quantity_left_percentage / 100
            sum_value += value
        for food in all_food:
            if sum_value == 0:
                food_pies.append(
                    FoodPie(name=food.name, rate=1),
                )
                break
            else:
                food_pies.append(
                    FoodPie(
                        name=food.name,
                        rate=(food.money_cost * food.quantity_left_percentage / 100)
                        / sum_value,
                    ),
                )
        return food_pies

    def use_food(self, record: FoodUsageRecord):
        food = self.single_food(
            address=record.use_food_address, group_id=record.use_food_group_id
        )
        if food is None:
            return {"message": "食材不存在"}

        # 檢查群組是否存在
        if record.use_food_group_id not in self.groups:
            return {"message": "食材不存在目前的 group"}

        # 計算使用金額
        use_amount = record.use_food_amount_percentage / 100 * food.money_cost

        # 尋找使用者
        for i in range(len(self.groups[record.use_food_group_id])):
            if self.groups[record.use_food_group_id][i].address == record.user_address:
                # 只有當使用者不是購買者時才扣除餘額
                if record.user_address != food.buyer_address:
                    self.groups[record.use_food_group_id][i].balance -= use_amount

                # 更新食材剩餘量
                for j in range(len(self.foods[record.use_food_group_id])):
                    if (
                        self.foods[record.use_food_group_id][j].food_address
                        == record.use_food_address
                    ):
                        self.foods[record.use_food_group_id][
                            j
                        ].quantity_left_percentage -= record.use_food_amount_percentage
                        break
                break

        return {"message": "成功使用食材"}

    def single_account(self, address: str, group_id: str):
        if group_id not in self.groups:
            return None
        for ac in self.groups[group_id]:
            if ac.address == address:
                return ac
        return None

    def all_accounts(self, group_id):
        if group_id not in self.groups:
            return None
        return self.groups[group_id]

    def account_join_group(self, aj: AccountJoin):
        already_in = False

        if aj.group_id not in self.groups:
            self.groups[aj.group_id] = list()

        for i in range(len(self.groups[aj.group_id])):
            if self.groups[aj.group_id][i].address == aj.address:
                already_in = True
                self.groups[aj.group_id][i].name = aj.name
                break

        if not already_in:
            self.groups[aj.group_id].append(
                Account(
                    name=aj.name, address=aj.address, group_id=aj.group_id, balance=0
                )
            )
            return {"message": "成功新增至群組"}
        else:
            return {"message": "已在群組中，名稱已修改"}

    def all_transactions(self, group_id: str):
        if group_id not in self.transactions:
            empty_list = list()
            empty_list.append(
                TransferRecord(
                    transfer_time="",
                    from_address="",
                    from_name="還款人",
                    to_address="",
                    to_name="收款人",
                    amount=0,
                    group_id=group_id,
                    notes="無註解",
                ),
            )
            return empty_list

        transactions = self.transactions[group_id]
        print(transactions)
        address_to_name = dict()
        if group_id in self.groups:
            for ac in self.groups[group_id]:
                address_to_name[ac.address] = ac.name

        result = list()
        for tx in transactions:
            result.append(
                TransferRecord(
                    transfer_time=tx.transfer_time,
                    from_address=tx.from_address,
                    from_name=address_to_name[tx.from_address],
                    to_address=tx.to_address,
                    to_name=address_to_name[tx.to_address],
                    amount=tx.amount,
                    group_id=group_id,
                    notes=tx.notes,
                ),
            )
        return result

    def transfer(self, record: TransferRequest):
        # 檢查是否自己轉給自己
        if record.from_address == record.to_address:
            return True

        success_from = False
        success_to = False

        if record.group_id not in self.groups:
            return False

        for i in range(len(self.groups[record.group_id])):
            if self.groups[record.group_id][i].address == record.from_address:
                self.groups[record.group_id][i].balance += record.amount
                success_from = True
            elif self.groups[record.group_id][i].address == record.to_address:
                self.groups[record.group_id][i].balance -= record.amount
                success_to = True
            if success_from and success_to:
                if record.group_id not in self.transactions:
                    self.transactions[record.group_id] = list()
                self.transactions[record.group_id].append(
                    TransferRequest(
                        transfer_time=record.transfer_time,
                        from_address=record.from_address,
                        to_address=record.to_address,
                        amount=record.amount,
                        group_id=record.group_id,
                        notes=record.notes,
                    ),
                )
                break
        return success_from and success_to
