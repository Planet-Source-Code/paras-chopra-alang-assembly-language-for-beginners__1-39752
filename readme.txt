ALang - Assembly Language for Beginners

ALang is an easy to learn and use Assembly Language for beginners. ALang is very close to Assembly language in its syntax and execution. It is an interpreted language. This means that programs written in ALang are not compiled directly into machine codes rather they are executed one by one. It is a very sophisticated language which can execute variety of programs. You can implement loops, conditionals, variables, etc. in this language. As this is its first release it may be having several limitations and bugs. Any comments, improvements, VOTES and feedback will be appreciated. To get started with ALang read its tutorial below.

Tutorial.

The ALang uses a different kind of approach, a very primitive type of approach, in implementation of programs. 

Data Storage:-

There is a temporary storage area called ‘Accumulator’ and permanent storage cells called ‘Memory’. The memory contains in turn contain cells which holds data. The cells are from 0 to 65535(2^16-1) in number. You can access any of the memory cells. All the operations are performed only on the accumulator. There are also two flags. Flags are also temporary storage area which can either be on or off. The two flags are zero flag and sign flag. These flags are useful while making comparisons.


Data Type:-
Presently only Integer, Character and string data types are supported.

Commands:-
To write programs you need instructions which convey the interpreter what to do. These instructions, in ALang, are called opcodes (short for operation codes). And these opcodes may or may not have arguments. Arguments are the extra values which are given to the interpreter. For example if you want to print “I am an ALang programmer”. Opcode will be “Print” and argument will be “I am an ALang programmer”. The syntax of giving commands is:

<opcode>,(<argument>)
Where <argument> is optional.


Given below is the list of currently supported Opcodes.



* NOP --- Does nothing.

* lod,<number> --- Sets the value of accumulator to the <number>. For example lod,2 sets the value of accumulator to 2.

* lodm,<memlocation> --- Sets the value of accumulator to the data stored in memory cell no <memlocation>. For example lodm,0 sets the value stored in first cell(0th cell) of the memory to the accumulator.

* stor,<memlocation> --- Stores the value of accumulator to the memory cell no <memlocation>.

* add,<number> --- It adds the <number> to the value of accumulator and stores it in the accumulator.

* addm,<memlocation> --- It adds the value stored in memory cell no. <memlocation> to the value of accumulator and stores it in the accumulator.

* sub,<number> --- It subtracts the <number> from the value of accumulator and stores it in the accumulator.

* subm,<memlocation> --- It subtracts the value stored in memory cell no. <memlocation> from the value of accumulator and stores it in the accumulator.

* mul,<number> --- It multiplies the <number> with the value of accumulator and stores it in the accumulator.

* mulm,<memlocation> --- It multiplies the value stored in memory cell no. <memlocation> with the value of accumulator and stores it in the accumulator.

* div,<number> --- It divides the <number> with the value of accumulator and stores it in the accumulator.

* divm,<memlocation> --- It divides the value stored in memory cell no. <memlocation> with the value of accumulator and stores it in the accumulator.

* mod,<number> --- It divides the <number> with the value of accumulator and stores the remainder in the accumulator.

* modm,<memlocation> --- It divides the value stored in memory cell no. <memlocation> with the value of accumulator and stores the remainder in the accumulator.

* or,<number> --- It applies Boolean OR operation between the <number> and the value of accumulator and stores the result in the accumulator.

* orm,<memlocation> --- It applies Boolean OR operation between the value stored in memory cell no. <memlocation> and the value of accumulator and stores the result in the accumulator.

* and,<number> --- It applies Boolean AND operation between the <number> and the value of accumulator and stores the result in the accumulator.

* andm,<memlocation> --- It applies Boolean AND operation between the value stored in memory cell no. <memlocation> and the value of accumulator and stores the result in the accumulator.

* cmp,<number> --- It compares the value in the accumulator with the <number> and sets zero flag on if they are equal, if <number> is less it sets the sign flag on and if the <number> is greater it sets the sign flag off.

* cmpm,<memlocation> --- Same as cmp. It just compares the value stored in memory cell no <memlocation>.

* jz,<lineno> --- If the zero flag in on then jump to line number <lineno> in the program.

* jnz,<lineno> --- If the zero flag in off then jump to line number <lineno> in the program.

* ja,<lineno> --- If the zero flag in off and sign flag is also off, jump to line number <lineno> in the program. (JA means jump if above)

* jb,<lineno> --- If the zero flag in off and sign flag is on, jump to line number <lineno> in the program. (JB means jump if below)

* pri,<value> --- Print a character on the screen whose ASCII value is <value>. Example, pri,76 will print “L” on the screen.

* prim,<memlocation> --- Same as pri. It just takes the value from memory location specified.

* nw --- It prints the new line on the screen.

* prn,<string> --- It just displays the <string> on the screen.

* rem,<remarks> --- You can provide remarks or comments through this opcode. Interpreter ignores this.

* str,<string> --- It takes the string and saves it in the memory. The value  in the accumulator serves as memory location. It actually stores the string in its ASCII format terminated with a null character. For example, if the value stored in the accumulator is 0. Then, [str,ALang am good.] will store The ASCII value of “A” in 0th location, ASCII value of “L” in 1st location and so on terminating the string with null character.

* pstr,<memlocation> --- It prints the string made up of characters stored in memory from <memlocation> until null character is encountered. It’s generally used along with ‘str’. 
Example:
[lod,0
str,ALang is good.
pstr,0]
This whole program will print ALang is good on the screen.

* sys,<callno> --- It is the most important opcode. It executes a system job (such as inputting or outputting) corresponding to <callno>.

* eop --- It is essential to put this opcode at the end of the program to tell the interpreter to stop further execution.

System Calls:-

Currently only two system calls are supported 1 and 2.

* System callno 1 --- It inputs a number from the user and stores it in the accumulator.

* System callno 2 --- It prints the current number stored in the accumulator  on the screen.


Example programs:-

1. Adding two numbers

prn,Enter a number: 
sys,1
stor,0
prn,Enter another number: 
sys,1
addm,0
prn,The sum is : 
sys,2 
rem,Example ALang program to add two numbers.
rem,By Paras Chopra - paraschopra@lycos.com
eop

Description:
1. Prints “Enter a number:”
2. Inputs on number and stores it in the accumulator
3. Stores the value of accumulator
4,5. Enters another number and stores in the accumulator.
6. Adds the value in the accumulator.
7. Shows the sum.

Note: There are two more programs as example programs in the “progs” directory. And if you write programs in ALang please send me those programs so that I can include them as example programs. Also, some volunteer is needed who can write ALang’s documentation.


Planned updates:-
1. Add user interface.
2. Compile ALang programs into executable.
3. Insert error handling.
4. Add more system calls and opcodes.
4. Better documentation and more example programs.


By:

Paras Chopra
CEO, NaramCheez
http://naramcheez.netfirms.com
paraschopra@lycos.com
