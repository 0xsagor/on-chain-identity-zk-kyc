# On-Chain Identity ZK-KYC

This repository provides an expert-level solution for compliant yet private user onboarding. It utilizes **zk-SNARKs** to verify that a user possesses a valid credential from a trusted Issuer while keeping the actual data (like Name, DOB, or SSN) off the public ledger.

### Architecture
* **Identity Issuer:** A trusted entity signs a user's data off-chain.
* **Prover (User):** Generates a Zero-Knowledge Proof that they own a signature from the Issuer where the `age >= 18`.
* **Verifier (On-chain):** A smart contract that validates the proof cryptographically before granting access to DeFi pools or restricted NFT mints.

### Privacy & Compliance
* **Anonymity:** No PII (Personally Identifiable Information) is ever stored on-chain.
* **Revocation:** Includes a nullifier system to prevent identity reuse or to revoke access if credentials expire.
* **Sybil Resistance:** Ensures one unique person maps to one unique on-chain identifier without exposing the person's identity.
