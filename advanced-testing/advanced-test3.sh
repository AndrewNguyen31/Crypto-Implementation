#!/bin/bash
echo Running multi-user tests...

echo The name of this cryptocurrency is:
./cryptomoney.sh name
echo

echo Creation of the genesis block:
./cryptomoney.sh genesis
echo

echo Creating wallets for alice, bob, charlie, and dana:
./cryptomoney.sh generate alice.wallet.txt
./cryptomoney.sh generate bob.wallet.txt
./cryptomoney.sh generate charlie.wallet.txt
./cryptomoney.sh generate dana.wallet.txt
echo

# Funding wallets
echo Funding alice wallet with 150:
./cryptomoney.sh fund $(./cryptomoney.sh address alice.wallet.txt) 150 01-alice-funding.txt
echo

echo Funding bob wallet with 100:
./cryptomoney.sh fund $(./cryptomoney.sh address bob.wallet.txt) 100 02-bob-funding.txt
echo

echo Funding charlie wallet with 50:
./cryptomoney.sh fund $(./cryptomoney.sh address charlie.wallet.txt) 50 03-charlie-funding.txt
echo

echo Funding dana wallet with 75:
./cryptomoney.sh fund $(./cryptomoney.sh address dana.wallet.txt) 75 04-dana-funding.txt
echo

# Verifying funding transactions
echo Verifying funding transactions:
./cryptomoney.sh verify alice.wallet.txt 01-alice-funding.txt
./cryptomoney.sh verify bob.wallet.txt 02-bob-funding.txt
./cryptomoney.sh verify charlie.wallet.txt 03-charlie-funding.txt
./cryptomoney.sh verify dana.wallet.txt 04-dana-funding.txt
echo

# First set of transfers
echo Transferring 50 from alice to bob:
./cryptomoney.sh transfer alice.wallet.txt $(./cryptomoney.sh address bob.wallet.txt) 50 05-alice-to-bob.txt
echo

echo Transferring 30 from bob to charlie:
./cryptomoney.sh transfer bob.wallet.txt $(./cryptomoney.sh address charlie.wallet.txt) 30 06-bob-to-charlie.txt
echo

echo Transferring 20 from charlie to dana:
./cryptomoney.sh transfer charlie.wallet.txt $(./cryptomoney.sh address dana.wallet.txt) 20 07-charlie-to-dana.txt
echo

echo Transferring 100 from dana to alice - should fail due to insufficient funds:
./cryptomoney.sh transfer dana.wallet.txt $(./cryptomoney.sh address alice.wallet.txt) 100 08-dana-to-alice.txt
echo

# Verifying the first set of transactions
echo Verifying transactions:
./cryptomoney.sh verify alice.wallet.txt 05-alice-to-bob.txt
./cryptomoney.sh verify bob.wallet.txt 06-bob-to-charlie.txt
./cryptomoney.sh verify charlie.wallet.txt 07-charlie-to-dana.txt
./cryptomoney.sh verify dana.wallet.txt 08-dana-to-alice.txt
echo

# Mine the first block
echo Mining the first block with prefix of 2:
./cryptomoney.sh mine 2
echo

# Second set of transfers
echo Transferring 10 from bob to dana:
./cryptomoney.sh transfer bob.wallet.txt $(./cryptomoney.sh address dana.wallet.txt) 10 09-bob-to-dana.txt
echo

echo Transferring 5 from dana to charlie:
./cryptomoney.sh transfer dana.wallet.txt $(./cryptomoney.sh address charlie.wallet.txt) 5 10-dana-to-charlie.txt
echo

echo Transferring 15 from charlie to alice:
./cryptomoney.sh transfer charlie.wallet.txt $(./cryptomoney.sh address alice.wallet.txt) 15 11-charlie-to-alice.txt
echo

# Verifying the second set of transactions
echo Verifying transactions:
./cryptomoney.sh verify bob.wallet.txt 09-bob-to-dana.txt
./cryptomoney.sh verify dana.wallet.txt 10-dana-to-charlie.txt
./cryptomoney.sh verify charlie.wallet.txt 11-charlie-to-alice.txt
echo

# Mine the second block
echo Mining the second block with prefix of 2:
./cryptomoney.sh mine 2
echo

# Third set of transfers
echo Transferring 25 from alice to charlie:
./cryptomoney.sh transfer alice.wallet.txt $(./cryptomoney.sh address charlie.wallet.txt) 25 12-alice-to-charlie.txt
echo

echo Transferring 150 from bob to dana - should fail due to insufficient funds:
./cryptomoney.sh transfer bob.wallet.txt $(./cryptomoney.sh address dana.wallet.txt) 150 13-bob-to-dana.txt
echo

# Verifying the third set of transactions
echo Verifying transactions:
./cryptomoney.sh verify alice.wallet.txt 12-alice-to-charlie.txt
./cryptomoney.sh verify bob.wallet.txt 13-bob-to-dana.txt
echo

# Mine the third block
echo Mining the third block with prefix of 2:
./cryptomoney.sh mine 2
echo

# Final balance check
echo Checking the balance of alice:
./cryptomoney.sh balance $(./cryptomoney.sh address alice.wallet.txt)
echo

echo Checking the balance of bob:
./cryptomoney.sh balance $(./cryptomoney.sh address bob.wallet.txt)
echo

echo Checking the balance of charlie:
./cryptomoney.sh balance $(./cryptomoney.sh address charlie.wallet.txt)
echo

echo Checking the balance of dana:
./cryptomoney.sh balance $(./cryptomoney.sh address dana.wallet.txt)
echo

# Validate the entire blockchain
echo Validating the cryptocurrency chain:
./cryptomoney.sh validate
echo