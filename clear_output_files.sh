#!/bin/bash

# Define the base directory
base_dir="cryptocurrency"

# Clear all .txt files in the "blockchain", "mempool", "transaction_statements", and "wallet" folders under cryptocurrency
for folder in blockchain mempool transaction_statements wallet; do
    find "$base_dir/$folder" -type f -name "*.txt" -exec rm -f {} \;
done

echo "All .txt files in the folders under $base_dir have been cleared."