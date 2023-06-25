//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 <0.9.0;
//Decentralized Lottery Application
contract Lottery{
    address public manager;
    //particular account e jodi ether transfer korte hoy tahole payable use korte hobe
     address payable[] public participants;

     constructor() 
     {//ei account er address manager e transfer hobe
     //manager ai contract er ultimate controller hoye jabe
         manager=msg.sender;//msg.sender global variable:tranfer kortesi address to the manager

     }
//payable function create korbo.jetar sahajje contract e kichu ammount of ether transfer korbo participants theke
//receive function ta sudhu akbar contract e use kora jay abong sobsomoy external and payable thakbe
    receive() external payable
    {
        require(msg.value==2 ether);//2 ether na hole participant hobe na
        participants.push(payable(msg.sender));
    }
    function getBalance() public view returns(uint)
    {
        require(msg.sender==manager);
        return address(this).balance;
    }
    //random basis e kivabe participants select korbo tar jonno function
    function random() public view returns(uint)
    {
        //random function create korar jonno keccak256 function use kora hoy
        //hashing alogrithm 
       return uint(keccak256(abi.encodePacked(block.prevrandao,block.timestamp,participants.length)));
    }
//select winner manager korbe
//ei function ta winner er address return korbe
function selectWinner() public //view //returns(address)
{
  //jodi kono particular line k sudhu matro manager k diye access korate chai tkhn ei require line ta likhte hobe
    require(msg.sender==manager);
    require(participants.length>=3);

    uint r=random();
    address payable winner;
    uint index=r%participants.length;
    winner=participants[index];
    //return winner;
    winner.transfer(getBalance());
    participants=new address payable[](0);
}
}
