// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

interface IGroth16Verifier {
    function verifyProof(uint[2] calldata a, uint[2][2] calldata b, uint[2] calldata c, uint[1] calldata input) external view returns (bool);
}

contract IdentityVerifier is Ownable {
    IGroth16Verifier public immutable zkVerifier;
    mapping(address => bool) public isVerified;
    mapping(bytes32 => bool) public nullifiers;

    event IdentityProven(address indexed user, bytes32 nullifier);

    constructor(address _zkVerifier) Ownable(msg.sender) {
        zkVerifier = IGroth16Verifier(_zkVerifier);
    }

    function verifyIdentity(
        uint[2] calldata a,
        uint[2][2] calldata b,
        uint[2] calldata c,
        uint[1] calldata input, // input[0] is typically the nullifier hash
        address user
    ) external {
        bytes32 nullifier = bytes32(input[0]);
        require(!nullifiers[nullifier], "Identity already verified or used");
        require(zkVerifier.verifyProof(a, b, c, input), "Invalid ZK identity proof");

        nullifiers[nullifier] = true;
        isVerified[user] = true;

        emit IdentityProven(user, nullifier);
    }
}
