from datetime import datetime

import hashlib
import os
import rsa

from crypto_utils import *

# Ensure necessary directories exist
os.makedirs("cryptocurrency/transaction_statements", exist_ok=True)
os.makedirs("cryptocurrency/mempool", exist_ok=True)
os.makedirs("cryptocurrency/blockchain", exist_ok=True)
os.makedirs("cryptocurrency/wallet", exist_ok=True)

# -------------------------------- Helper functions --------------------------------
# Get the first 16 characters of a wallet tag and the private key
def get_wallet_tags(wallet_file_name):
    public_key, private_key = loadWallet(f"cryptocurrency/wallet/{wallet_file_name}")
    public_key_bytes = public_key.save_pkcs1(format='PEM')
    public_key_hash = hashlib.sha256(public_key_bytes).hexdigest()
    
    return public_key_hash[:16], private_key

# Create a digital signature by signing the message with the private key
def encrypt_message(message, private_key):
    signature = rsa.sign(message.encode('ascii'), private_key, 'SHA-256')
    return signature

# Verify the signature with the given public key and message
def verify_signature(message, signature, public_key):
    try:
        rsa.verify(message.encode('ascii'), signature, public_key)
        return True
    except rsa.VerificationError:
        return False
    
# Count the number of blocks by checking the file format in the directory
def count_blocks():
    files = os.listdir('cryptocurrency/blockchain')
    block_files = [f for f in files if f.startswith("block_")]
    return len(block_files)

# Compute the hash of the block by reading the file and hashing its contents (excluding the first line)
def compute_block_hash(block_file_name):
    with open(f"cryptocurrency/blockchain/{block_file_name}", "r") as file:
        lines = file.readlines()
        block_contents = "".join(lines[1:]).strip()
        return hashlib.sha256(block_contents.encode('ascii')).hexdigest()

# ---------------------------- Cryptocurrency functions ----------------------------
special_case_id = "bigfoot"

# Returns the name of the cryptocurrency
def name():
    return "AntMine"

# Creates the genesis block
def genesis():
    with open("cryptocurrency/blockchain/block_0.txt", "w") as file:
        file.write("Genesis block!")
        
    return "Genesis block created"

# Generates a new wallet and saves it to a file
def generate(wallet_file_name):
    (public_key, private_key) = rsa.newkeys(1024)
    saveWallet(public_key, private_key, f"cryptocurrency/wallet/{wallet_file_name}")
    return "Wallet created and saved to " + wallet_file_name
    
# Returns the address (first 16 characters of the public key) of the wallet
def address(wallet_file_name):
    public_key, _ = get_wallet_tags(wallet_file_name)
    return public_key

# Funds a wallet with a specified amount and creates a transaction statement
def fund(wallet_tag, amount, transaction_statement):
    time = str(datetime.now())
    
    with open(f"cryptocurrency/transaction_statements/{transaction_statement}", "w") as file:
        file.write(f"From: " + special_case_id)
        file.write(f"\nTo: " + wallet_tag)
        file.write(f"\nAmount: " + amount)
        file.write(f"\nDate: " + time)
    
    return f"Funded {wallet_tag} with {amount} AntCoins on {time}"

# Transfers a specified amount from one wallet to another and creates a transaction statement
def transfer(source_wallet_file_name, destination_wallet_tag, amount, transaction_statement):
    time = str(datetime.now())
    source_wallet_tag, source_private_key = get_wallet_tags(source_wallet_file_name)
    message = f"From: {source_wallet_tag}\nTo: {destination_wallet_tag}\nAmount: {amount}\nDate: {time}"
    signature = encrypt_message(message, source_private_key)
    
    with open(f"cryptocurrency/transaction_statements/{transaction_statement}", "w") as file:
        file.write(message)
        file.write(f"\n\n" + bytesToString(signature).decode('ascii'))
    
    return f"Transferred {amount} AntCoins from {source_wallet_tag} to {destination_wallet_tag} and the statement {transaction_statement} was created on {time}"

# Returns the balance of a wallet
def balance(wallet_tag):
    balance = 0
    number_of_blocks = count_blocks()
    for i in range(number_of_blocks):
        with open(f"cryptocurrency/blockchain/block_{i}.txt", "r") as file:
            lines = file.readlines()
            for line in lines:
                if "to " + wallet_tag in line:
                    amount = int(line.split("transferred ")[1].split()[0])
                    balance += amount
                elif wallet_tag in line:
                    amount = int(line.split("transferred ")[1].split()[0])
                    balance -= amount
    
    if os.path.exists("cryptocurrency/mempool/mempool.txt"):
        with open("cryptocurrency/mempool/mempool.txt", "r") as file:
            lines = file.readlines()
            for line in lines:
                if "to " + wallet_tag in line:
                    amount = int(line.split("transferred ")[1].split()[0])
                    balance += amount
                elif wallet_tag in line:
                    amount = int(line.split("transferred ")[1].split()[0])
                    balance -= amount

    return balance

# Verifies the validity of a transaction statement
def verify(wallet_file_name, transaction_statement):
    with open(f"cryptocurrency/transaction_statements/{transaction_statement}", "r") as file_1:
        lines = file_1.readlines()
        source = lines[0].split("From: ")[1].strip()
        destination = lines[1].split("To: ")[1].strip()
        amount = int(lines[2].split("Amount: ")[1].strip())
        time = lines[3].split("Date: ")[1].strip()
        
        wallet_tag, _ = get_wallet_tags(wallet_file_name)
        local_balance = balance(wallet_tag)

        if source != special_case_id and destination != wallet_tag and local_balance < amount:
            return "Transaction statement is invalid due to insufficient funds"

        if len(lines) == 6:
            signature = stringToBytes(lines[5])
            message = f"From: {source}\nTo: {destination}\nAmount: {amount}\nDate: {time}"
            public_key, _ = loadWallet(f"cryptocurrency/wallet/{wallet_file_name}")
            
            if not verify_signature(message, signature, public_key):
                return "Transaction statement is invalid: Signature is invalid"

        with open("cryptocurrency/mempool/mempool.txt", "a") as file_2:
            if os.path.getsize("cryptocurrency/mempool/mempool.txt") == 0:
                beginning = ""
            else:
                beginning = "\n"
            transaction_line = f"{beginning}{source} transferred {amount} to {destination} on {time}"
            file_2.write(transaction_line)
        
    return f"The transaction statement, {transaction_statement}, is valid"

# Mines a new block with a specified difficulty
def mine(difficulty):
    if not os.path.exists("cryptocurrency/mempool/mempool.txt"):
        return "No transactions to mine"
    elif os.path.getsize("cryptocurrency/mempool/mempool.txt") == 0:
        return "No transactions to mine"
    
    number_of_blocks = count_blocks()
    if number_of_blocks == 1:
        previous_hash = hashFile("cryptocurrency/blockchain/block_0.txt")
    else:
        previous_hash = compute_block_hash(f"block_{number_of_blocks - 1}.txt")
    
    with open("cryptocurrency/mempool/mempool.txt", "r+") as file:
        data = file.read().strip()
        file.seek(0)
        file.truncate()
        
    nonce = 0
    while True:
        block = f"{previous_hash}\n\n{data}\n\nNonce:{nonce}"
        block_hash = hashlib.sha256(block.encode('ascii')).hexdigest()
        
        if block_hash.startswith("0" * difficulty):
            break
        
        nonce += 1
        
    with open(f"cryptocurrency/blockchain/block_{number_of_blocks}.txt", "w") as file:
        file.write(block)
        
    number_of_blocks += 1
    
    return f"Block {number_of_blocks} mined with difficulty {difficulty} and nonce {nonce}"

# Validates the entire blockchain
def validate():
    hashes = [hashFile("cryptocurrency/blockchain/block_0.txt")]
    number_of_blocks = count_blocks()
    for i in range(1, number_of_blocks):
        with open(f"cryptocurrency/blockchain/block_{i}.txt", "r") as file:
            lines = file.readlines()
            previous_hash = lines[0].strip()
            
            if previous_hash != hashes[i-1]:
                return False
            
            hashes.append(compute_block_hash(f"block_{i}.txt"))
            
    return True