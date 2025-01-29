import argparse
from cryptocurrency import *

# Main function to parse and execute commands
def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("command", help="The command to execute")
    parser.add_argument("args", nargs=argparse.REMAINDER, help="Additional arguments for the command")
    args = parser.parse_args()

    match args.command:
        case command if command in ("name", "genesis", "validate"):
            print(globals()[args.command]())
    
        case command if command in ("generate", "address", "balance"):
            wallet = args.args[0]
            print(globals()[args.command](wallet))
            
        case "fund":
            wallet = args.args[0]
            amount = args.args[1]
            transaction_statement = args.args[2]
            print(fund(wallet, amount, transaction_statement))

        case "transfer":
            source_wallet = args.args[0]
            destination_wallet = args.args[1]
            amount = args.args[2]
            transaction_statement = args.args[3]
            print(transfer(source_wallet, destination_wallet, amount, transaction_statement))
            
        case "verify":
            wallet = args.args[0]
            transaction_statement = args.args[1]
            print(verify(wallet, transaction_statement))
            
        case "mine":
            difficulty = int(args.args[0])
            print(mine(difficulty))

if __name__ == "__main__":
    main()