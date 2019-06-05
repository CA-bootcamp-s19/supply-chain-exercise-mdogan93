pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/SupplyChain.sol";

contract TestSupplyChain {

    // Test for failing conditions in this contracts
    // test that every modifier is working
    
    // buyItem

    // test for purchasing an item that is not for Sale
    // function testItemNotOnSale() public {
    //     SupplyChain supplyChain = new SupplyChainWrapper();
    //     ThrowProxy throwproxy = new ThrowProxy(address(supplyChain));
    //     SupplyChainWrapper(address(throwproxy)).callBuyItem(0);
    //     (bool r, ) = throwproxy.execute.gas(200000)(); 
    //     Assert.isFalse(r, "Should be false because is should throw!");
    // }

    function testAddItem() public {
        string memory itemName = "banana";
        uint itemPrice = 2e5;
        SupplyChain supplyChain = new SupplyChain();
        supplyChain.addItem(itemName, itemPrice);
        string memory name;
        // address seller;
        // address buyer;
        // uint sku;
        uint price;
        // uint state;

        (name, , price, , , ) = supplyChain.fetchItem(0);
        Assert.equal(name, itemName, "Item should be successfuly added with given name");
        Assert.equal(price, itemPrice, "Item should be successfuly added with given price");

    }


    // shipItem

    // test for calls that are made by not the seller
    // test for trying to ship an item that is not marked Sold

    // receiveItem

    // test calling the function from an address that is not the buyer
    // test calling the function on an item not marked Shipped

    


}
// Proxy contract for testing throws
contract ThrowProxy {
  address public target;
  bytes data;
  constructor(address _target) public{
    target = _target;
  }

  //prime the data using the fallback function.
  function() external{
    data = msg.data;
  }

  function execute() public returns (bool, bytes memory) {
    return target.call(data);
  }
}

contract SupplyChainWrapper is SupplyChain{
  function callBuyItem(uint sku) public{
    buyItem(sku);
  }

  function callAddItem(string memory _name, uint _price) public returns(bool){
      addItem(_name, _price);
  }
}