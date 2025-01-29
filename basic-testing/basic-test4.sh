#!/bin/bash
echo Running insufficient funds tests...

echo The name of this cryptocurrency is:
./cryptomoney.sh name
echo

echo Creation of the genesis block:
./cryptomoney.sh genesis
echo

echo Creating wallets for alice and bob:
./cryptomoney.sh generate alice.wallet.txt
./cryptomoney.sh generate bob.wallet.txt
echo

# Attempting to transfer funds without funding the wallets
echo Attempting to transfer 50 from alice to bob:
./cryptomoney.sh transfer alice.wallet.txt $(./cryptomoney.sh address bob.wallet.txt) 50 01-alice-to-bob.txt
echo

echo Attempting to transfer 30 from bob to alice:
./cryptomoney.sh transfer bob.wallet.txt $(./cryptomoney.sh address alice.wallet.txt) 30 02-bob-to-alice.txt
echo

# Verifying the transfer transactions (should indicate invalid transactions)
echo Verifying the failed transfer transaction from alice to bob:
./cryptomoney.sh verify alice.wallet.txt 01-alice-to-bob.txt
echo

echo Verifying the failed transfer transaction from bob to alice:
./cryptomoney.sh verify bob.wallet.txt 02-bob-to-alice.txt
echo

# Final balance check (should be zero for both)
echo Checking the balance of alice:
./cryptomoney.sh balance $(./cryptomoney.sh address alice.wallet.txt)
echo

echo Checking the balance of bob:
./cryptomoney.sh balance $(./cryptomoney.sh address bob.wallet.txt)
echo

# Mine a block
echo Mining a block with prefix of 2 - should fail due to no transactions:
./cryptomoney.sh mine 2
echo

# Create an empty mempool and try to mine again
echo Creating an empty mempool:
> mempool.txt
echo

echo Mining a block with prefix of 2 - should fail due to empty mempool:
./cryptomoney.sh mine 2
echo
