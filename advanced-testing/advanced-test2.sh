#!/bin/bash
echo Running advanced tests with multiple blocks...

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

echo Funding alice wallet with 200:
./cryptomoney.sh fund $(./cryptomoney.sh address alice.wallet.txt) 200 01-alice-funding.txt
echo

echo Funding bob wallet with 100:
./cryptomoney.sh fund $(./cryptomoney.sh address bob.wallet.txt) 100 02-bob-funding.txt
echo

echo Checking the balance of alice:
./cryptomoney.sh balance $(./cryptomoney.sh address alice.wallet.txt)
echo

echo Checking the balance of bob:
./cryptomoney.sh balance $(./cryptomoney.sh address bob.wallet.txt)
echo

echo Verifying funding transactions:
./cryptomoney.sh verify alice.wallet.txt 01-alice-funding.txt
./cryptomoney.sh verify bob.wallet.txt 02-bob-funding.txt
echo

echo Checking the balance of alice:
./cryptomoney.sh balance $(./cryptomoney.sh address alice.wallet.txt)
echo

echo Checking the balance of bob:
./cryptomoney.sh balance $(./cryptomoney.sh address bob.wallet.txt)
echo

# First transfer
echo Transferring 50 from alice to bob:
./cryptomoney.sh transfer alice.wallet.txt $(./cryptomoney.sh address bob.wallet.txt) 50 03-alice-to-bob.txt
echo

echo Verifying the transfer transaction:
./cryptomoney.sh verify alice.wallet.txt 03-alice-to-bob.txt
echo

# Mine the first block
echo Mining a block with prefix of 2:
./cryptomoney.sh mine 2
echo

# Check balances after first transfer
echo Checking the balance of alice:
./cryptomoney.sh balance $(./cryptomoney.sh address alice.wallet.txt)
echo

echo Checking the balance of bob:
./cryptomoney.sh balance $(./cryptomoney.sh address bob.wallet.txt)
echo

# Second transfer
echo Transferring 30 from bob to alice:
./cryptomoney.sh transfer bob.wallet.txt $(./cryptomoney.sh address alice.wallet.txt) 30 04-bob-to-alice.txt
echo

echo Verifying the transfer transaction:
./cryptomoney.sh verify bob.wallet.txt 04-bob-to-alice.txt
echo

# Mine the second block
echo Mining a block with prefix of 2:
./cryptomoney.sh mine 2
echo

# Check balances after second transfer
echo Checking the balance of alice:
./cryptomoney.sh balance $(./cryptomoney.sh address alice.wallet.txt)
echo

echo Checking the balance of bob:
./cryptomoney.sh balance $(./cryptomoney.sh address bob.wallet.txt)
echo

# Third transfer
echo Transferring 20 from alice to bob:
./cryptomoney.sh transfer alice.wallet.txt $(./cryptomoney.sh address bob.wallet.txt) 20 05-alice-to-bob.txt
echo

echo Verifying the transfer transaction:
./cryptomoney.sh verify alice.wallet.txt 05-alice-to-bob.txt
echo

# Mine the third block
echo Mining a block with prefix of 2:
./cryptomoney.sh mine 2
echo

# Check balances after third transfer
echo Checking the balance of alice:
./cryptomoney.sh balance $(./cryptomoney.sh address alice.wallet.txt)
echo

echo Checking the balance of bob:
./cryptomoney.sh balance $(./cryptomoney.sh address bob.wallet.txt)
echo

# Fourth transfer
echo Transferring 10 from bob to alice:
./cryptomoney.sh transfer bob.wallet.txt $(./cryptomoney.sh address alice.wallet.txt) 10 06-bob-to-alice.txt
echo

echo Verifying the transfer transaction:
./cryptomoney.sh verify bob.wallet.txt 06-bob-to-alice.txt
echo

# Mine the fourth block
echo Mining a block with prefix of 2:
./cryptomoney.sh mine 2
echo

# Final balance check
echo Checking the balance of alice:
./cryptomoney.sh balance $(./cryptomoney.sh address alice.wallet.txt)
echo

echo Checking the balance of bob:
./cryptomoney.sh balance $(./cryptomoney.sh address bob.wallet.txt)
echo

# Validate the entire blockchain
echo Validating the cryptocurrency chain:
./cryptomoney.sh validate
echo