// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GaslessTokenTransfer {
    mapping(address => uint256) public balances;
    mapping(address => uint256) public nonces;

  
    function deposit(uint256 amount) external {
        balances[msg.sender] += amount;
    }

 
    function transferWithSignature(address to, uint256 amount, bytes memory signature) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");

        
        require(validateSignature(msg.sender, to, amount, signature), "Invalid signature");

        balances[msg.sender] -= amount;
        balances[to] += amount;

    
        nonces[msg.sender]++;
    }

    
    function validateSignature(address from, address to, uint256 amount, bytes memory signature) internal view returns (bool) {
        bytes32 message = keccak256(abi.encodePacked(from, to, amount, nonces[from]));
        address signer = recoverSigner(message, signature);
        return signer == from;
    }

    
    function recoverSigner(bytes32 message, bytes memory signature) internal pure returns (address) {
        require(signature.length == 65, "Invalid signature length");

        bytes32 r;
        bytes32 s;
        uint8 v;

        assembly {
            r := mload(add(signature, 32))
            s := mload(add(signature, 64))
            v := byte(0, mload(add(signature, 96)))
        }

        if (v < 27) {
            v += 27;
        }

        return ecrecover(message, v, r, s);
    }

    function withdrawWithReentrancy(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;

        GaslessTokenTransfer(this).externalContract(msg.sender, amount);
    }

    
    function externalContract(address to, uint256 amount) external {
      
        balances[to] += amount;
    }
}
