// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

contract Demo {
    struct Todo {
        string name;
        bool isCompleted;
    }
    Todo[] public list;

    function create(string memory _name) external {
        list.push(
            Todo({
                name:_name,
                isCompleted:false
            })
        );
    }

    function modiName1(uint256 _index, string memory _name) external {
        list[_index].name = _name;
    }

    function modiName2(uint256 _index, string memory _name) external {
        // 方法2: 先获取储存到 storage，在修改，在修改多个属性的时候比较省 gas
        Todo storage temp = list[_index];
        temp.name = _name;
    }

    function modiStatus1(uint256 _index, bool _status) external {
        list[_index].isCompleted = _status;
    }

    function modiStatus2(uint256 _index) external {
        list[_index].isCompleted = !list[_index].isCompleted;
    }

    // 获取任务1: memory : 2次拷贝
    // 29448 gas
    function get1(uint256 _index) external view returns(string memory name, bool status) {
        Todo memory temp = list[_index];
        return (temp.name, temp.isCompleted);
    }

    // 获取任务2: storage : 1次拷贝
    // 预期：get2 的 gas 费用比较低（相对 get1）
    // 29388 gas
    function get2(uint256 _index) external view returns(string memory name, bool status) {
        Todo storage temp = list[_index];
        return (temp.name, temp.isCompleted);
    }
}