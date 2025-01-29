#!/bin/bash
echo Running basic tests...

echo The name of this cryptocurrency is:
./cryptomoney.sh name
echo

echo Creation of the genesis block:
./cryptomoney.sh genesis
echo

echo Creating a wallet for alice:
./cryptomoney.sh generate alice.wallet.txt
echo

echo Creating a wallet for bob:
./cryptomoney.sh generate bob.wallet.txt
echo

echo Funding alice wallet with 50:
./cryptomoney.sh fund $(./cryptomoney.sh address alice.wallet.txt) 50 01-alice-funding.txt
echo

echo Funding bob wallet with 30:
./cryptomoney.sh fund $(./cryptomoney.sh address bob.wallet.txt) 30 02-bob-funding.txt
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

echo Mining a block with prefix of 2:
./cryptomoney.sh mine 2
echo

echo Try to mine a block with prefix of 2 again - should fail due to no transactions:
./cryptomoney.sh mine 2
echo

echo Validating the cryptocurrency chain:
./cryptomoney.sh validate
echo