// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 冰箱管理智能合約：用於管理共用冰箱中的食物和費用分攤
contract FridgeManager {
    // 帳戶結構：儲存用戶資訊
    struct Account {
        string name; // 用戶名稱
        int256 balance; // 帳戶餘額（可為負數，表示欠款）
        mapping(string => bool) groups; // 用戶所屬群組的映射
    }

    // 食物結構：儲存食物相關資訊
    struct Food {
        string name; // 食物名稱
        string insertTime; // 放入時間
        string dueDate; // 保存期限
        uint256 moneyCost; // 購買成本
        address buyerAddress; // 購買者地址
        uint256 quantityLeftPercentage; // 剩餘數量百分比
        string groupId; // 所屬群組ID
        string notes; // 備註
        bool exists; // 是否存在（用於驗證）
    }

    // 轉帳記錄結構：記錄用戶間的轉帳
    struct TransferRecord {
        string transferTime; // 轉帳時間
        address fromAddress; // 付款方地址
        string fromName; // 付款方名稱
        address toAddress; // 收款方地址
        string toName; // 收款方名稱
        uint256 amount; // 轉帳金額
        string notes; // 備註
        string groupId; // 所屬群組ID
    }

    // 食物使用記錄結構：記錄食物的使用情況
    struct FoodUsageRecord {
        string useTime; // 使用時間
        string groupId; // 群組ID
        address foodAddress; // 食物地址
        uint256 useFoodAmountPercentage; // 使用量百分比
        address userAddress; // 使用者地址
        string notes; // 備註
    }

    // 狀態變數：儲存合約的主要數據
    mapping(address => Account) public accounts; // 用戶帳戶映射
    mapping(string => address[]) public groupMembers; // 群組成員映射
    mapping(address => Food) public foods; // 食物映射
    address[] public foodList; // 食物地址列表
    TransferRecord[] public transferRecords; // 轉帳記錄數組
    FoodUsageRecord[] public usageRecords; // 使用記錄數組

    // 加入群組功能：允許用戶加入特定群組
    // 參數：
    // - groupId: 群組ID
    // - name: 用戶名稱
    function joinGroup(string memory groupId, string memory name) public {
        require(!accounts[msg.sender].groups[groupId], unicode"已經加入群組");

        accounts[msg.sender].name = name;
        accounts[msg.sender].groups[groupId] = true;

        groupMembers[groupId].push(msg.sender);
    }

    // 取得群組成員：返回指定群組的所有成員地址
    function getGroupMembers(
        string memory groupId
    ) public view returns (address[] memory) {
        return groupMembers[groupId];
    }

    // 更新用戶名稱：允許用戶修改自己的名稱
    function updateName(string memory newName) public {
        accounts[msg.sender].name = newName;
    }

    // 記錄轉帳：由收款人發起，記錄群組內的轉帳交易
    // 自動更新雙方餘額並記錄交易歷史
    function recordTransfer(
        string memory transferTime,
        address fromAddress,
        uint256 amount,
        string memory notes,
        string memory groupId
    ) public {
        require(
            accounts[msg.sender].groups[groupId],
            unicode"收款人不在此群組中"
        );
        require(
            accounts[fromAddress].groups[groupId],
            unicode"付款人不在此群組中"
        );

        accounts[fromAddress].balance += int256(amount);
        accounts[msg.sender].balance -= int256(amount);

        transferRecords.push(
            TransferRecord({
                transferTime: transferTime,
                fromAddress: fromAddress,
                fromName: accounts[fromAddress].name,
                toAddress: msg.sender,
                toName: accounts[msg.sender].name,
                amount: amount,
                notes: notes,
                groupId: groupId
            })
        );
    }

    // 新增食物：將新食物添加到群組中
    // 返回生成的食物唯一地址
    function addFood(
        string memory name,
        string memory insertTime,
        string memory dueDate,
        uint256 moneyCost,
        string memory notes,
        string memory groupId
    ) public returns (address) {
        require(accounts[msg.sender].groups[groupId], unicode"不在此群組中");

        address foodAddress = address(
            uint160(
                uint(
                    keccak256(
                        abi.encodePacked(
                            block.timestamp,
                            msg.sender,
                            foodList.length
                        )
                    )
                )
            )
        );

        foods[foodAddress] = Food({
            name: name,
            insertTime: insertTime,
            dueDate: dueDate,
            moneyCost: moneyCost,
            buyerAddress: msg.sender,
            quantityLeftPercentage: 100,
            groupId: groupId,
            notes: notes,
            exists: true
        });

        foodList.push(foodAddress);
        return foodAddress;
    }

    // 記錄食物使用：記錄食物的使用情況
    // 自動計算費用並更新相關用戶餘額
    function recordFoodUsage(
        string memory useTime,
        address foodAddress,
        uint256 useFoodAmountPercentage,
        string memory notes
    ) public {
        require(foods[foodAddress].exists, unicode"食物不存在");
        string memory groupId = foods[foodAddress].groupId;
        require(accounts[msg.sender].groups[groupId], unicode"不在此群組中");

        Food storage food = foods[foodAddress];
        require(
            food.quantityLeftPercentage >= useFoodAmountPercentage,
            unicode"剩餘數量不足"
        );

        // 計算花費並更新餘額
        uint256 cost = (food.moneyCost * useFoodAmountPercentage) / 100;
        accounts[msg.sender].balance -= int256(cost);
        accounts[food.buyerAddress].balance += int256(cost);

        // 更新剩餘數量
        food.quantityLeftPercentage -= useFoodAmountPercentage;

        usageRecords.push(
            FoodUsageRecord({
                useTime: useTime,
                groupId: food.groupId,
                foodAddress: foodAddress,
                useFoodAmountPercentage: useFoodAmountPercentage,
                userAddress: msg.sender,
                notes: notes
            })
        );
    }

    // 取得群組食物：返回指定群組中的所有食物地址
    function getGroupFoods(
        string memory groupId
    ) public view returns (address[] memory) {
        uint256 count = 0;
        for (uint256 i = 0; i < foodList.length; i++) {
            if (
                keccak256(bytes(foods[foodList[i]].groupId)) ==
                keccak256(bytes(groupId))
            ) {
                count++;
            }
        }

        address[] memory groupFoods = new address[](count);
        uint256 index = 0;
        for (uint256 i = 0; i < foodList.length; i++) {
            if (
                keccak256(bytes(foods[foodList[i]].groupId)) ==
                keccak256(bytes(groupId))
            ) {
                groupFoods[index] = foodList[i];
                index++;
            }
        }

        return groupFoods;
    }
}
