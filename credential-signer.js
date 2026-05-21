const { ethers } = require("ethers");

/**
 * Trusted Issuer signs user data off-chain to be used in ZK proof generation.
 */
async function issueCredential(issuerWallet, userAddress, dataFields) {
    const messageHash = ethers.solidityPackedKeccak256(
        ["address", "uint256", "string"],
        [userAddress, dataFields.birthDate, dataFields.countryCode]
    );

    const signature = await issuerWallet.signMessage(ethers.toBeArray(messageHash));
    
    return {
        user: userAddress,
        data: dataFields,
        issuerSignature: signature
    };
}

module.exports = { issueCredential };
