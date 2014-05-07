## Prelab
### Description
I would like to implement an artificial neural network in hardware, capable of learning to do basic operations (addition, subtraction, and, or) based solely on being given sample data for each. Since full learning is difficult (I believe that I can achieve it however), my interface will be simple, using the font controller and acting like a simple calculator. This project is fairly cutting edge, with the implementation of the math needed being the topic of multiple papers within the last couple years (Jamal, Khammas, “IMPLEMENTATION OF A SIGMOID ACTIVATION FUNCTION FOR NEURAL NETWORK USING FPGA”, and Rajeswaran,  “VHDL synthesizable hardware architecture design of back propagation neural networks”).

### Functionality Levels
Required – Network has full interface, but preset weights. This would simulate a static network with no learning. However, getting forward propagation to work properly involves some difficult math, especially in hardware. 
B – Network has the fully supporting modules needed for back propagation, notably the modules for creating test cases (needed many thousand for suitable learning).
A – Network is fully capable of back propagation learning (I anticipate the most difficulty here)

### Timeline
Realistically, this may take more time than I have available in class. However, I still believe that I can accomplish it.
A significnat part of my project is understanding the AI construct itself, so I will need to spend multiple lessons on design.

By lesson Number
1-3: Understand back propogation algorithm. Understand the full design of each node, and how to train them
4: Create detailed designed of each part
5-6: Get Basic and B functionality (realistically, this project will need a significant deal of time outside of class. I plan on working the weekend of May 3-4 specifically on this project.
7: A functionality and presentation

### Hardware
No additional hardware beyond the Spartan 6 FPGA.

### Initial Design
Part of the major problem is creating a realistic design structure. 
I plan on having VHDL modules for both the sigmoid and back propogation functions, contained within a larger node module. I will use a microblaze processor for creating training cases, and user interaction. However, the entirety of the actuall processing will be done by the network. 

### Prepared to begin work
I am most of the way through understanding the algorithm. I need a little bit more on back propogation (I have acquired a suitable textbook), but should be good to go.

### Documentation
Two's complement factions - https://stackoverflow.com/questions/9946183/2s-complement-representation-of-fractions
https://en.wikipedia.org/wiki/Fixed-point_arithmetic
http://pages.cs.wisc.edu/~cs354-1/beyond354/int.mult.html