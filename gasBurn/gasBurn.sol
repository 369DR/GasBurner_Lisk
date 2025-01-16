// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GasBurner {
    mapping(address => bool) private whitelist;
    address public owner;
    mapping(uint256 => uint256) private dataMap;
    uint256 private save;
    uint256 private counts;
    uint256 public uses;

    event WhitelistAdded(address indexed addr);

    constructor() {
        owner = msg.sender;
        whitelist[msg.sender] = true;
        counts = 1111;
        save = 0;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    modifier onlyWhitelisted() {
        require(whitelist[msg.sender], "Caller is not whitelisted");
        _;
    }

    function addToWhitelist(address[] memory addr) external onlyOwner {
        for (uint256 i = 0; i < addr.length; i++) {
            address participant = addr[i];
            if (participant == address(0)) {
                continue;
            }

            if (!whitelist[participant]) {
                whitelist[participant] = true;
                emit WhitelistAdded(participant);
            }
        }  
    }

    function burnGas() external onlyWhitelisted {
        for (uint25 i = save; i < save + counts; i++) {
            dataMap[i] = i;
        }
        save += counts;
        uses++;
    }

    function isWhitelisted(address addr) external view returns (bool) {
        return whitelist[addr];
    }
}
