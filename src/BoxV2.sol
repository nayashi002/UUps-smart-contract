// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import{UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
contract BoxV2 is Initializable,OwnableUpgradeable,UUPSUpgradeable{
    uint256 internal value;

    //@custom:oz-upgrades-unsafe-allow constructor
    constructor(){
      _disableInitializers();
    }
    function initialize(address initialOwner) public initializer{
      __Ownable_init(initialOwner); // same as owner = msg.sender 
      __UUPSUpgradeable_init(); // best practice to have this in here just shows that it is uupsupgradable
    }
   
       function setValue(uint256 newValue) public {
        value = newValue;
    }
    function getVersion() external pure returns(uint256){
        return 2;
    }
    function _authorizeUpgrade(address newImplementation) internal override{}
    function getValue() external view returns(uint256){
      return value;
    }
    }