# TenTenRobot

This is a computer simulator that execute a set of instructions and output it for the user to view.

## Instructions

The program support the following instructions:

- `MULT`: Pop the 2 arguments from the stack, multiply them and push the result back to the stack
- `CALL addr`: Set the program counter (PC) to `addr`
- `RET`: Pop address from stack and set PC to address
- `STOP`: Exit the program
- `PRINT`: Pop value from stack and print it
- `PUSH arg`: Push argument to the stack


## Interface

The app has a single button that execute the following instructions:

```
PRINT_TENTEN_BEGIN = 50
MAIN_BEGIN = 0
def main
# Create new computer with a stack of 100 addresses
computer = Computer.new(100)
# Instructions for the print_tenten function
computer.set_address(PRINT_TENTEN_BEGIN).insert("MULT").insert("PRINT").insert("RET")
# The start of the main function
computer.set_address(MAIN_BEGIN).insert("PUSH", 1009).insert("PRINT")
# Return address for when print_tenten function finishes
computer.insert("PUSH", 6)
# Setup arguments and call print_tenten
computer.insert("PUSH", 101).insert("PUSH", 10).insert("CALL", PRINT_TENTEN_BEGIN)
# Stop the program
computer.insert("STOP")
computer.set_address(MAIN_BEGIN).execute()
end
main()
```

Expected output:
```
# 1009
# 1010
```

## Error handling:
An error is outputted to the user if any of the simulator instructions cannot be executed. 
