# CSE125-Final-Project

This project implements a tapped delay line TDC, a simple TDC.
There is also encoder and UART files, but this was not successfully implemented. 

The motivation for this project is that I was interested in learning more about TDCs (Time-to-Digital Converters), and being able to implement them. 

The project directory structure is as below:

```
code/
├── src/
│   ├── tdc/
│   │   ├── Makefile
│   │   ├── tb_tdc.sv
│   │   └── tdc.sv
│   ├── encoder/
│   │   ├── Makefile
│   │   └── encoder.sv
│   └── delay-tdc/
│       ├── Makefile
│       ├── tb_tdc.sv
│       ├── tdc.sv
│       └── top.sv
├── uart/
│   ├── uart_baud_tick_gen.v
│   ├── uart_rx.v
│   └── uart_tx.v
├── icebreaker.pcd
├── LICENSE
└── README.md
```

## Build Process

1. Clone the repository using Git:  
`` git clone git@github.com:nancyjlau/CSE125-Final-Project.git``

2. Install the necessary tools:

The following tools are required to build and run the TDC and Delay-TDC designs:

    Yosys (for synthesis)
    Nextpnr-ice40 (for place-and-route)
    Project IceStorm (for programming the FPGA)
    Verilator (for compiling the testbenches)
    Icarus Verilog (for running the testbenches)
    CMake (for building purposes)

This guide assumes the user has CMake installed.

3. To install this on:
    - Linux  
       - Run:   ```sudo apt-get install yosys nextpnr-ice40 project-icestorm verilator iverilog```
    - MacOS
      - Have [Hombrew](https://brew.sh/) installed
      - Run: ``brew install icarus-verilog verilator``
      - Run: ``brew tap ktemkin/oss-fpga``
      - Run: ``brew install --HEAD icestorm yosys nextpnr-ice40``
    - Windows
      - Download tools from [OSS-CAD-Suite](https://github.com/YosysHQ/oss-cad-suite-build#installation)
4. ``cd`` into either `tdc` or `delay-tdc`, and then run make test to see the working simulations
## Tapped Delay Line TDC
A tapped delay line TDC (Time-to-Digital Converter) is a digital circuit that measures the time difference between two events. The tapped delay line TDC is made up of 5 delay elements. There are 5 taps at the output of each delay element, and each signal at each tap represents the input signalat different delay times.When the input signal propagates through the delay line, the flip-flops capture the signal state at different times. The outputs of the flip-flops can then be compared to determine the position of the input signal in the delay line.

## Simple TDC
The simple TDC is composed of a counter that tracks clock cycles while an input signal is high. 
As the input signal goes high, the counter starts incrementing, and when the signal transitions to low, 
the counter stops, capturing the elapsed clock cycles. The stored count reflects the duration the input 
signal was high, and this information can be utilized for analyzing time-based events.

## Encoder

 The encoder was intended to convert the TDC output into a format suitable for transmission over UART, allowing for easier communication and analysis of the TDC results.

## UART

The Universal Asynchronous Receiver/Transmitter (UART) module is designed to facilitate serial communication between the TDC and other devices. The UART module consists of a transmitter (uart_tx.v), a receiver (uart_rx.v), and a baud rate tick generator (uart_baud_tick_gen.v). 

A significant amount of efforts were made to try to create a working solution for the UART, including trying to first create the UART RX and TX modules, and trying to get a working baud rate. 

In the end, I decided to scrap all of that and use already made working UART modules from the [icebreaker-fpga/icebreaker-verilog-examples](https://github.com/icebreaker-fpga/icebreaker-verilog-examples) repository, specifically the [pll_uart](https://github.com/icebreaker-fpga/icebreaker-verilog-examples/tree/main/icebreaker/pll_uart) files. Though, there was not enough time left to get UART actually working.


## Future Work
Despite the challenges faced during the implementation, the process provided a lot of insight  Future work on this project could include revisiting the encoder design and getting UART to work. Additionally, I explored PLL (phase loop locked) TDCs, but due to time constraints, a working implementation could not be created. 

