# #!/bin/bash
echo The name of this cryptocurrency is:
./cryptomoney.sh name
echo

echo Creation of the genesis block:
./cryptomoney.sh genesis
echo

echo Creating a wallet for alice into alice.wallet.txt:
./cryptomoney.sh generate alice.wallet.txt
export alice=`./cryptomoney.sh address alice.wallet.txt`
echo

# echo alice.wallet.txt wallet signature: $alice
# echo

echo Funding alice wallet with 100:
./cryptomoney.sh fund $alice 100 01-alice-funding.txt
echo

echo Creating a wallet for bob into alice.wallet.txt:
./cryptomoney.sh generate bob.wallet.txt
export bob=`./cryptomoney.sh address bob.wallet.txt`
echo

# echo bob.wallet.txt wallet signature: $bob
# echo

echo Funding bob wallet with 100:
./cryptomoney.sh fund $bob 100 02-bob-funding.txt
echo

echo Transfering 12 from alice to bob:
./cryptomoney.sh transfer alice.wallet.txt $bob 12 03-alice-to-bob.txt
echo

echo Transfering 2 from bob to alice:
./cryptomoney.sh transfer bob.wallet.txt $alice 2 04-bob-to-alice.txt
echo

echo Verifying the last four transactions:
./cryptomoney.sh verify alice.wallet.txt 01-alice-funding.txt
./cryptomoney.sh verify bob.wallet.txt 02-bob-funding.txt
./cryptomoney.sh verify alice.wallet.txt 03-alice-to-bob.txt
./cryptomoney.sh verify bob.wallet.txt 04-bob-to-alice.txt
echo

# echo Displaying the mempool:
# cat mempool.txt
# echo

echo Checking the balance of both alice and bob:
./cryptomoney.sh balance $alice
./cryptomoney.sh balance $bob
echo

echo Mining the block with prefix of 2:
./cryptomoney.sh mine 2
echo

echo Validating the cryptocurrency chain:
./cryptomoney.sh validate
echo