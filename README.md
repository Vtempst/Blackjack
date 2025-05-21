# Blackjack in Verilog on Digilent Nexys A7

A from-scratch Verilog implementation of the classic Blackjack card game, synthesized and deployed on a Digilent Nexys A7 FPGA. The design uses a finite-state machine to manage game flow, Fisher–Yates to shuffle the deck, and an HD44780-compatible LCD plus onboard push-buttons for user interaction.

## 🚀 Features
- **FSM-driven game logic**: Handles deal, hit, stand, bust, and win/lose conditions.  
- **Fisher–Yates shuffle**: Uniformly randomizes a 52-card deck every new game.  
- **LCD output**: Displays player hand, dealer hand (partial), totals, and prompts.  
- **Push-button controls**:  
  - Hit  
  - Stand  
  - New Game  
- **FPGA-ready**: Includes Vivado constraints for the Nexys A7 (Artix-7) board.
