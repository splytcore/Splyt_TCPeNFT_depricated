pragma solidity ^0.4.24;

import "./Asset.sol";
import "./Managed.sol";

contract Order is Managed {
    
    enum Reasons { DEFECTIVE, NO_REASON, CHANGED_MIND, OTHER }
    enum Statuses { PIF, CLOSED, REQUESTED_REFUND, REFUNDED, OTHER }

    bytes12 public orderId;    
    address public buyer;
    Asset public asset;
    uint public quantity;
    Reasons public reason;
    Statuses public status;
    uint public tokenAmount;

    modifier onlyBuyer(address _buyer) {
        require(buyer == _buyer);
        _;
    }
    
    modifier onlySeller(address _seller) {
        require(_seller == asset.seller());
        _;
    }
    
    constructor(bytes12 _orderId, address _assetAddress, address _buyer, uint _qty, uint _tokenAmount) public {
        orderId = _orderId;
        asset = Asset(_assetAddress);
        buyer = _buyer;
        quantity = _qty;
        tokenAmount = _tokenAmount;
        status = Statuses.PIF;
    }

    function approveRefund() public onlyManager {
        status = Statuses.REFUNDED;
        //TODO: refund  token process
        
    }
    
    function requestRefund() public onlyManager {
        status = Statuses.REQUESTED_REFUND;
        //TODO: refund  token process        
    }    

}