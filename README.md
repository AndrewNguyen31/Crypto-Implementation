# AntMine Cryptocurrency
A simple cryptocurrency implementation for demonstration and educational purposes.  This project simulates core cryptocurrency functionalities like wallet generation, transaction processing, block mining, and blockchain validation.  It's designed to be easy to understand and modify, allowing users to explore the underlying concepts of a blockchain-based system.

## Features
* **Wallet Generation:** Create new wallets with unique public and private keys.
* **Transaction Processing:**  Fund wallets, transfer funds between wallets, and verify transactions.
* **Block Mining:** Mine new blocks to the blockchain, solving a proof-of-work problem with adjustable difficulty.
* **Blockchain Validation:** Verify the integrity of the blockchain by checking hashes and transaction validity.
* **Balance Checking:** Check the current balance of any wallet.
* **Insufficient Funds Handling:** The system detects and prevents transactions that exceed a wallet's available balance.
* **Transaction Verification:** Each transaction is verified using RSA digital signatures to ensure authenticity and prevent tampering.

## Usage
The cryptocurrency system is controlled via a command-line interface (CLI) using the `cryptomoney.sh` script.  This script acts as a wrapper around a Python script that handles the core logic.

**Basic Commands:**

* `./cryptomoney.sh name`: Displays the name of the cryptocurrency.
* `./cryptomoney.sh genesis`: Creates the genesis block.
* `./cryptomoney.sh generate alice.wallet.txt`: Generates a wallet and saves it to `alice.wallet.txt`.
* `./cryptomoney.sh address alice.wallet.txt`: Gets the address of the wallet in `alice.wallet.txt`.
* `./cryptomoney.sh fund <address> <amount> <transaction_statement>`: Funds a wallet with a given amount.  `<transaction_statement>` is the name of the file where the transaction will be recorded.
* `./cryptomoney.sh transfer <source_wallet> <destination_address> <amount> <transaction_statement>`: Transfers funds between wallets.
* `./cryptomoney.sh verify <wallet> <transaction_statement>`: Verifies a transaction.
* `./cryptomoney.sh balance <address>`: Checks the balance of a wallet.
* `./cryptomoney.sh mine <difficulty>`: Mines a new block with the specified difficulty (number of leading zeros).
* `./cryptomoney.sh validate`: Validates the entire blockchain.


**Example:**

```bash
./cryptomoney.sh generate alice.wallet.txt
./cryptomoney.sh fund $(./cryptomoney.sh address alice.wallet.txt) 100 01-alice-funding.txt
./cryptomoney.sh balance $(./cryptomoney.sh address alice.wallet.txt)
./cryptomoney.sh mine 2
./cryptomoney.sh validate
```

## Installation
1.  Clone the repository: `git clone <repository_url>`
2.  Navigate to the project directory: `cd <project_directory>`
3.  Ensure Python 3 and the required libraries are installed (see Dependencies section).
4.  Run the tests (see Testing section). Ensure your permissions allow you to run the shell scripts: for example, `chmod 755 basic-testing/basic-test.sh`.

## Technologies Used
* **Python 3:** The core logic of the cryptocurrency is implemented in Python.
* **`argparse`:** Used for parsing command-line arguments.
* **`rsa`:**  A Python library for RSA cryptography, used for generating keys and digital signatures.
* **`hashlib`:** Used for hashing data (SHA-256).
* **`binascii`:** Used for converting between binary and ASCII representations of data.
* **`bash`:** Used for the command-line interface scripts.

## Testing
Several shell scripts are provided for testing various aspects of the cryptocurrency:

*   `basic-testing/basic-test1.sh`: Basic functionality tests.
*   `basic-testing/basic-test2.sh`: Tests mining and validation.
*   `basic-testing/basic-test3.sh`: Tests blockchain tampering.
*   `basic-testing/basic-test4.sh`: Tests for insufficient funds.
*   `advanced-testing/advanced-test1.sh`: More complex scenarios.
*   `advanced-testing/advanced-test2.sh`: Multiple block mining test
*   `advanced-testing/advanced-test3.sh`: Multi-user transactions test.

To run the tests, navigate to the respective testing directory and execute the shell scripts:  `./<test_script.sh>`.

## Dependencies
*   Python 3
*   `rsa` library:  Install using `pip install pycryptodome`

## Contributing
Contributions are welcome! Please feel free to open issues or submit pull requests.  Ensure you follow the established coding style and add appropriate tests for any new features or bug fixes.