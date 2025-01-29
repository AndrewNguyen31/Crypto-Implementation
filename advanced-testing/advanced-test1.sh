#!/bin/bash
echo Running advanced tests...

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

echo Checking the balance of alice:
./cryptomoney.sh balance $(./cryptomoney.sh address alice.wallet.txt)
echo

echo Checking the balance of bob:
./cryptomoney.sh balance $(./cryptomoney.sh address bob.wallet.txt)
echo

echo Transferring 30 from alice to bob:
./cryptomoney.sh transfer alice.wallet.txt $(./cryptomoney.sh address bob.wallet.txt) 30 03-alice-to-bob.txt
echo

echo Checking the balance of alice:
./cryptomoney.sh balance $(./cryptomoney.sh address alice.wallet.txt)
echo

echo Checking the balance of bob:
./cryptomoney.sh balance $(./cryptomoney.sh address bob.wallet.txt)
echo

echo Verifying the transfer transaction:
./cryptomoney.sh verify alice.wallet.txt 03-alice-to-bob.txt
echo

echo Checking the balance of bob:
./cryptomoney.sh balance $(./cryptomoney.sh address bob.wallet.txt)
echo

echo Attempting to transfer more than available balance:
./cryptomoney.sh transfer bob.wallet.txt $(./cryptomoney.sh address alice.wallet.txt) 100 04-bob-to-alice.txt
echo

echo Verifying the transfer transaction - should fail:
./cryptomoney.sh verify bob.wallet.txt 04-bob-to-alice.txt
echo

echo Mining a block with prefix of 2:
./cryptomoney.sh mine 2
echo

echo Validating the cryptocurrency chain:
./cryptomoney.sh validate
echo