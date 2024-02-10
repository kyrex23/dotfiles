<h1 align="center"> 💻 BASH - CONDITIONAL EXPRESSIONS 💻 </h1>

> These notes can be obtained in the `Conditional Expressions` section of `man bash`

### Table of Contents

1. [File operators](#file-operators)
2. [String operators](#string-operators)
3. [Comparing operators](#comparing-operators)

## File operators

`-e file` - Checks if a file exists
```bash
if [ -e "$file" ]; then
	echo "The file exists"
fi
```

`-d file` - Checks if the given path is a directory
```bash
if [ -d "$file" ]; then
	echo "It is a directory"
fi
```

`-f file` - Checks if the given path exists and is a regular file
```bash
if [ -f "$file" ]; then
	echo "The file exists and it is a regular file"
fi
```

`-s file` - Checks if the file is empty
```bash
if [ -s "$file" ]; then
	echo "The file is empty"
fi
```

`-r file` - Checks if the given path is readable
```bash
if [ -r "$file" ]; then
	echo "The file is readable"
fi
```

`-w file` - Checks if the given path is writable
```bash
if [ -r "$file" ]; then
	echo "The file is writable"
fi
```

`-x file` - Checks if the given path is executable
```bash
if [ -r "$file" ]; then
	echo "The file is executable"
fi
```

## String operators

`-z string` - Checks if the length of string is zero
```bash
if [ -z "$var" ]; then
	echo "The string is empty"
fi
```

`-n string` - Checks if the length of string in non-zero
```bash
if [ -n "$var" ]; then
	echo "The string is not empty"
fi
```

## Comparing Operators

`-eq` - Checks if two numbers are equals
```bash
if [ "$num1" -eq "$num2" ]; then
    echo "Los números son iguales"
fi
```

`-ne` - Checks if two numbers are not equals
```bash
if [ "$num1" -ne "$num2" ]; then
    echo "Los números no son iguales"
fi
```

`-gt` - Checks if the first number is greater than the second number
```bash
if [ "$num1" -gt "$num2" ]; then
    echo "El número 1 es mayor que el número 2"
fi
```

`-lt` - Checks if the first number is less than the second number
```bash
if [ "$num1" -lt "$num2" ]; then
    echo "El número 1 es menor que el número 2"
fi
```

`-ge` - Checks if the first number is greater than or equal to the second number
```bash
if [ "$num1" -ge "$num2" ]; then
    echo "El número 1 es mayor o igual que el número 2"
fi
```

`-le` - Checks if the first number is less than or equal to the second number
```bash
if [ "$num1" -le "$num2" ]; then
    echo "El número 1 es menor o igual que el número 2"
fi
```
