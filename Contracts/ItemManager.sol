//  SPDX-License-Identifier: MIT
pragma solidity >0.6.99 <0.8.1; // pragma solidity ^0.7.0;

import "./Item.sol";

contract ItemManager{
    enum SupplyChainSteps{Created, Paid, Delivered}

    struct S_Item {
        Item _item;// uint _priceInWei;
        ItemManager.SupplyChainSteps _step; //enum
        string _identifier;
    }

    mapping(uint => S_Item) public items; // formara una lista
    uint index;

    /*
    _itemIndex: identificador del objeto
    _step: el paso en el que se encuentra el item enum
    */
    event SupplyChainStep(uint _itemIndex, uint _step, address _address);

    /*
    CREATED:
    _identifier: id
    _priceInWei: precio
     emit SupplyChainStep(p1,p2) emitira el oobjeto se creara con el index 1 incrementando
    */
    function createItem(string memory _identifier, uint _priceInWei ) public {
        Item item = new Item(this, _priceInWei, index);
        items[index]._item = item;
        items[index]._step = SupplyChainSteps.Created;
        items[index]._identifier = _identifier;
        
        emit SupplyChainStep(index, uint(items[index]._step), address(item));

        index++;
    }

    /*
    triggerPayment: ACTIVAR PAGO
    payable: esta funcion manejara dinero
        _verifica: el valor de la transaccion es == al precio wei del objeto
        _verifica: se verifica que el pase en el que esta el objeto sea CREATED
        _SI LAS DOS verificacion: son exitosa se cambia el paso de  CREATED A PAID
    */
    function triggerPayment(uint _index) public payable {
        Item item = items[_index]._item;
        require(address(item)== msg.sender,"Only items are allowed to update themselves");
        require(item.priceInWei() == msg.value, "not fully paid yet");
        require(items[index]._step == SupplyChainSteps.Created,
        "Item is further in the supply chain");
        
        items[_index]._step = SupplyChainSteps.Paid;
        emit SupplyChainStep(_index,uint(items[_index]._step), address(item));
    }

    /*
    DELIVERY
     _verifica: se verifica que el pase en el que esta el objeto sea PREAD
     _SI verificacion: es exitosa se cambia el paso de PAID a DELIVERED
    */
    function triggerDelivery(uint _index) public {
        require(items[_index]._step == SupplyChainSteps.Paid,
        "Item is further in the supply chain"
         );

          items[_index]._step = SupplyChainSteps.Delivered;
        emit SupplyChainStep(_index,uint(items[_index]._step), address(items[_index]._item));
    }


}