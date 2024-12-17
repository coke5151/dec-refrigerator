// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FoodSharing {
    // 帳戶結構：儲存使用者在群組中的資訊
    struct Account {
        string name;
        address addr; // 這裡用 addr 因為 address 是關鍵字
        string group_id;
        int256 balance; // 使用 int256 允許負數餘額
    }

    // 食物結構：儲存食物的詳細資訊
    struct Food {
        string name;
        string insert_time;
        string due_date;
        int256 money_cost;
        address buyer_address;
        int256 quantity_left_percentage; // 剩餘百分比，範圍 0-100
        string food_address; // 使用交易 hash 作為唯一識別碼
        string simpler_food_address; // 簡短版本的 food_address，用於顯示
        string group_id;
        string notes;
    }

    // 轉帳記錄結構：記錄群組內的轉帳歷史
    struct TransferRecord {
        string transfer_time;
        address from_address;
        address to_address;
        int256 amount;
        string group_id;
        string notes;
    }

    // 群組到帳戶的映射：儲存每個群組中的所���帳戶
    mapping(string => Account[]) public groupAccounts;

    // 群組到食物的映射：儲存每個群組中的所有食物
    mapping(string => Food[]) public groupFoods;

    // 群組到轉帳記錄的映射：儲存每個群組中的所有轉帳記錄
    mapping(string => TransferRecord[]) public groupTransfers;

    // 查詢群組中的所有帳戶
    function getAccountsByGroup(
        string memory group_id
    ) public view returns (Account[] memory) {
        return groupAccounts[group_id];
    }

    // 查詢群組中的所有食物
    function getFoodsByGroup(
        string memory group_id
    ) public view returns (Food[] memory) {
        return groupFoods[group_id];
    }

    // 查詢群組中的所有轉帳記錄
    function getTransfersByGroup(
        string memory group_id
    ) public view returns (TransferRecord[] memory) {
        return groupTransfers[group_id];
    }

    // 加入群組或更新使用者名稱
    // 如果使用者已在群組中，只更新名稱
    // 如果使用者不在群組中，新增帳戶
    function joinGroup(string memory name, string memory group_id) public {
        bool found = false;
        Account[] storage accounts = groupAccounts[group_id];

        for (uint i = 0; i < accounts.length; i++) {
            if (accounts[i].addr == msg.sender) {
                accounts[i].name = name;
                found = true;
                break;
            }
        }

        if (!found) {
            accounts.push(Account(name, msg.sender, group_id, 0));
        }
    }

    // 新增食物到群組中
    // 返回生成的 food_address
    function insertFood(
        string memory name,
        string memory insert_time,
        string memory due_date,
        int256 money_cost,
        address buyer_address,
        string memory group_id,
        string memory notes
    ) public returns (string memory) {
        string memory food_address = toHexString(
            uint256(
                keccak256(abi.encodePacked(block.timestamp, msg.sender, name))
            )
        );
        string memory simpler_food_address = substring(food_address, 0, 4);

        Food memory newFood = Food(
            name,
            insert_time,
            due_date,
            money_cost,
            buyer_address,
            100,
            food_address,
            simpler_food_address,
            group_id,
            notes
        );

        groupFoods[group_id].push(newFood);
        return food_address;
    }

    // 群組內的轉帳功能
    // from_address：轉出方地址
    // msg.sender：接收方地址（必須是發起交易的人���
    // 如果是自己轉給自己，直接返回不記錄
    function transfer(
        string memory transfer_time,
        address from_address,
        int256 amount,
        string memory group_id,
        string memory notes
    ) public {
        if (msg.sender == from_address) {
            return;
        }

        Account[] storage accounts = groupAccounts[group_id];
        bool foundFrom = false;
        bool foundTo = false;

        for (uint i = 0; i < accounts.length; i++) {
            if (accounts[i].addr == from_address) {
                accounts[i].balance += amount;
                foundFrom = true;
            } else if (accounts[i].addr == msg.sender) {
                accounts[i].balance -= amount;
                foundTo = true;
            }

            if (foundFrom && foundTo) {
                TransferRecord memory newTransfer = TransferRecord(
                    transfer_time,
                    from_address,
                    msg.sender,
                    amount,
                    group_id,
                    notes
                );
                groupTransfers[group_id].push(newTransfer);
                return;
            }
        }

        require(foundFrom, "From account not found in group");
        require(foundTo, "To account not found in group");
    }

    // 使用食物功能
    // 更新食物剩餘量
    // 扣除使用者餘額
    // 增加購買者餘額
    function useFood(
        string memory use_food_group_id,
        string memory use_food_address,
        int256 use_food_amount_percentage
    ) public {
        Food[] storage foods = groupFoods[use_food_group_id];
        Account[] storage accounts = groupAccounts[use_food_group_id];

        int256 food_cost = 0;
        address buyer_address;

        // 找到食物並更新剩餘量
        for (uint i = 0; i < foods.length; i++) {
            if (
                keccak256(bytes(foods[i].food_address)) ==
                keccak256(bytes(use_food_address))
            ) {
                food_cost =
                    (foods[i].money_cost * use_food_amount_percentage) /
                    100;
                foods[i].quantity_left_percentage -= use_food_amount_percentage;
                buyer_address = foods[i].buyer_address;
                break;
            }
        }

        // 如果使用者不是購買者，才需要更新餘額
        if (msg.sender != buyer_address) {
            for (uint i = 0; i < accounts.length; i++) {
                if (accounts[i].addr == msg.sender) {
                    accounts[i].balance -= food_cost;
                } else if (accounts[i].addr == buyer_address) {
                    accounts[i].balance += food_cost;
                }
            }
        }
    }

    // 輔助函數：將數字轉換為十六進制字串
    function toHexString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0x00";
        }

        bytes memory buffer = new bytes(64);
        uint256 i = 64;

        while (value > 0) {
            i--;
            uint8 digit = uint8(value % 16);
            if (digit < 10) {
                buffer[i] = bytes1(uint8(48 + digit)); // 0-9
            } else {
                buffer[i] = bytes1(uint8(87 + digit)); // a-f
            }
            value /= 16;
        }

        bytes memory result = new bytes(64 - i);
        for (uint256 j = 0; j < result.length; j++) {
            result[j] = buffer[i + j];
        }

        return string(abi.encodePacked("0x", result));
    }

    // 輔助函數：擷取字串的子字串
    function substring(
        string memory str,
        uint startIndex,
        uint length
    ) internal pure returns (string memory) {
        bytes memory strBytes = bytes(str);
        bytes memory result = new bytes(length);
        for (uint i = 0; i < length; i++) {
            result[i] = strBytes[startIndex + i];
        }
        return string(result);
    }
}
