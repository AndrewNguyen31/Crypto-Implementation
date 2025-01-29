#!/bin/bash
echo Running validation tests...

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

echo Funding alice wallet with 100:
./cryptomoney.sh fund $(./cryptomoney.sh address alice.wallet.txt) 100 01-alice-funding.txt
echo

echo Funding bob wallet with 50:
./cryptomoney.sh fund $(./cryptomoney.sh address bob.wallet.txt) 50 02-bob-funding.txt
echo

echo Verifying funding transactions:
./cryptomoney.sh verify alice.wallet.txt 01-alice-funding.txt
./cryptomoney.sh verify bob.wallet.txt 02-bob-funding.txt
echo

# First transfer
echo Transferring 30 from alice to bob:
./cryptomoney.sh transfer alice.wallet.txt $(./cryptomoney.sh address bob.wallet.txt) 30 03-alice-to-bob.txt
echo

echo Verifying the transfer transaction:
./cryptomoney.sh verify alice.wallet.txt 03-alice-to-bob.txt
echo

# Mine the first block
echo Mining the first block with prefix of 2:
./cryptomoney.sh mine 2
echo

# Second transfer
echo Transferring 30 from bob to alice:
./cryptomoney.sh transfer bob.wallet.txt $(./cryptomoney.sh address alice.wallet.txt) 30 04-bob-to-alice.txt
echo

echo Verifying the transfer transaction:
./cryptomoney.sh verify bob.wallet.txt 04-bob-to-alice.txt
echo

# Mine the second block
echo Mining the second block with prefix of 2:
./cryptomoney.sh mine 2

echo
# Check the contents of the first block
echo Altering the contents of the first block to invalidate it...
echo "Tampered content" >> block_1.txt
echo 

# Validate the blockchain
echo Validating the cryptocurrency chain - should fail due to tampering:
./cryptomoney.sh validate