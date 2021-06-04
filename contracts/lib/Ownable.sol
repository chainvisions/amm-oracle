pragma solidity 0.7.6;

/**
* @dev This contract simplifies access control by allowing a contract to
* inherit this contract to gain access to access control features. This contract
* is similar to Openzeppelin's Ownable contract but has added improvements to it.
*/
abstract contract Ownable {

    address private _owner;
    address private _pendingOwner;

    event NewPendingOwner(address indexed pendingOwner);
    event OwnershipTransferred(address indexed prevOwner, address indexed newOwner);

    modifier onlyOwner {
        require(msg.sender == owner(), "Ownable: Caller is not owner");
        _;
    }

    constructor() {
        _owner = msg.sender;
    }

    function owner() public view returns (address) {
        return _owner;
    }

    function pendingOwner() public view returns (address) {
        return _pendingOwner;
    }

    function transferOwnership(address _newOwner) public onlyOwner {
        emit NewPendingOwner(_newOwner);
        _pendingOwner = _newOwner;
    }

    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    function acceptOwnership() public {
        require(msg.sender == pendingOwner(), "Ownable: Caller not pending owner");
        emit OwnershipTransferred(_owner, pendingOwner());
        _owner = pendingOwner();
        _pendingOwner = address(0);
    }

}