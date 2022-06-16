#### huffc-simple-auction
- check out [the implementation in solidity on solidity by example](https://docs.soliditylang.org/en/v0.8.14/solidity-by-example.html#simple-open-auction)

- Other Huff examples
- - [ERC20 and ERC721](https://github.com/huff-language/huff-examples)

<img src="https://i.imgur.com/I9IkxuW.png" height="180">

Huff is a low-level programming language, designed for developing highly optimized smart contracts that run on the Ethereum Virtual Machine. Huff does not hide the inner-workings of the EVM, instead, directly exposing its programming stack to the developer for manual manipulation.

Rather than having functions, Huff has macros - individual blocks of bytecode that can be rigorously tested and evaluated using the Huff runtime testing suite.

While Huff can be used by EVM experts to design highly-efficient smart contracts for use in production, it can also serve as a way for beginners to learn more about the Ethereum Virtual Machine, projects built on it, and languages made for it.

## Example

"Hello World" in Huff:

```js
#define macro MAIN() = takes (0) returns (0) {
    0x48656c6c6f2c20776f726c6421 0x00 mstore // Store "Hello, World!" in memory.
    0x1a 0x00 return // Return 26 bytes starting from memory pointer 0.
}
```

# Setup

To run this project, install it using npm

```
npm install -g huffc
```

To compile a contract and output its bytecode, simply run

```
huffc filename.huff --bytecode
```

For a full list of arguments, run

```
huffc --help
```
