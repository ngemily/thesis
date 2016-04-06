---
title: 'Final Report'
date: April 8, 2016
author: Emily Ng
filter: pandoc-eqnos
toc: on
header-includes:
    - \usepackage{fullpage}
    - \usepackage{sty/myTitle}
    - \linespread{1.5}
    - \usepackage{caption}
    - \usepackage{subcaption}
    - \usepackage[section]{placeins}
    - \usepackage[backend=biber]{biblatex}
    - \addbibresource{bib/report.bib}
---

\newpage

# Introduction

FPGAs have the hardware resources to accelerate compute intensive tasks.  While
FPGAs have been traditionally used to implement digital logic designs, there is
increasing interest in using FPGAs to accelerate software programs written to
target CPUs.  This has lead to the development of both commerical and academic
high-level synthesis tools such as LegUp \cite{legup} that synthesize C code to RTL
code that can then be compiled through CAD tools to target FPGAs.  One
limitation to such an approach is that it requires the source code for the
program to be accelerated.  This somewhat narrows the scope of the use of FPGAs
to offload work from CPUs.

An interesting question that arises is whether or not it is feasible to
accelerate programs starting from the binaries and then whether or not the
results are comparable to synthesizing from source code.  Work has been done on
decompilation techniques and synthesizing binaries to advanced memory structures
by Vahid and Stitt of the University of California \cite{decompilation_techniques}.
They further investigate performing the reverse of traditional optimizing
compiler passes to recover higher level control flow.

![\label{fig:decompile} LegUp flow from source code and flow from
binary.](imgs/binary_synthesis.png)

There are a number of stages where the program is being transformed from one
format to another, as shown in Figure \ref{fig:decompile}.  Each transformation
can be done with various levels of optimization, which will affect the final
results.

# Background

## FPGAs

<!--

* Background
    - CPU
    - ASIC
    - FPGA

* Current relevance
    - Intel acquisition
    - Low power (data centres)
    - Neural nets and similar, HW accelerator

-->

The traditional computation device is the CPU.  A CPU is comprised of generic
hardware that can execute a set of instructions.  People can use CPUs to execute
software programs to perform arbitrary computations.  This makes CPUs very
versatile, but inefficient at any given repetitive task.

If the task to be performed is known beforehand, one can build dedicated
hardware to perform the computations.  Such devices are known as Application
Specific Integrated Circuits (ASICs).  It is very expensive to carry out the
design and manufacture of ASICs and once manufactured, it cannot be altered.
ASICs are most effective when the desired functionality is not likely to change
and the per-unit cost is to be minimized.

FPGAs are made of a programmable logic and can be made to implement digital
logic.  FPGAs are like flexible ASICs in that they can be re-used for different
circuits when desired.

FPGAs have been steadily gaining popularity as hardware accelerators.  In 2015
Intel began the process of acquiring Altera, with stated interest in hybrid
CPU-FPGA projects.  Microsoft has conducted research and are currently using
FPGAs for the acceleration of convolutional neural network
computations\cite{microsoft_cnn}.  Such applications originated in software, and are
more readily expressed in code rather than hardware.  The goal of high level
synthesis is to alleviate this gap between programs that people would like to
write in software, but have run on FPGAs.

## High Level Synthesis (HLS)

<!--

* analogy C vs assembly, role of compiler
* fewer hardware engineers than software engineers
* proprietary and academic (open source)

-->

To use an FPGA, a design is written in a Hardware Description Language (HDL) and
often a system is designed with IP (Intellectual Property) blocks.  The design
is then synthesized, mapped, and programmed onto the FPGA using CAD (Computer
Aided Design) tools.  This requires hardware design skills.  In contrast, to
program a CPU, one writes software.  The tools required to write and deploy
software are widely available and there are far more software engineers than
hardware engineers.

This leaves FPGAs with a much smaller number of people who can use them than
CPUs.  One effort to alleviate this discrepancy is high level synthesis.  The
aim of high level sythesis is to take a program written in a software language
like C and generate a circuit equivalent to that program in Verilog (or other
HDL).  HLS has garnered the attention of the major FPGA companies Altera and
Xilinx, each with their repsective efforts on a proprietary HLS engine. HLS has
also captured academic interest, notably the LegUp group at the Unversity of
Toronto \cite{legup}.

The movement in hardware design towards HLS has been described as analagous to
the introduction of high level languages such as C to CPU programming during a
time when programs were written in assembly \cite{hls}.  The introduction of higher
level languages facilitated the design of more complex programs and consolidated
many assembly instructions into a single line of code.  High level synthesis is
fundamentally different in that C is an abstraction of assembly, which itself is
an abstraction of machine code whereas C is not an abstraction of Verilog; it
may however be possible to represent the same computation in Verilog.
Nevertheless, high level synthesis is one avenue for broadening the field in
which FPGAs may be used.

## Decompilers

<!--

* used to be motivated by rapidly changing CPU architecture, ISAs

-->

Decompilers perform the opposite function of compilers.  Software compilers
compile text source code that programmers write into binary machine code that
computers can execute.  Decompilers take binary machine code and output source
code that represents an equivalent program.  It is impossible for the decompiler
to perfectly reconstruct the original source code, as much information is lost
in the compilation process.  Further, compilers are often run with optimization
passes that alter the code into functionally equivalent, but hopefully improved
versions.

Decompilers were of particular interest in the 80's when computer architecture
and in particular instruction set architectures (ISAs) were rapidly changing.  A
classic example is the transition from machines that implement VAX, a CISC ISA,
to machines that ran MIPS, a RISC ISA.  The motivation then was that most people
ran software compiled for older architectures and could not run on a  different
architecture.  Even when there was backwards compatibility, it was done by
methods such running programs through interpreters, or running a processor
emulator and made no use of the improved hardware \cite{binary_translation}.  Thus
the interest in decompilers, so that programs could be re-targeted for the new
architecture.

We are now motivated by a similar scenario, where it is desired to port software
that runs on CPUs to a digital design that can be run on an FPGA.

## Compiler passes

<!--

* interested for 2 reasons
    - source to hardware
    - from decompiled vs source
* modular design is how legup works

-->

As mentioned previously, compilers take source code written in human readable
formats and output machine executable code.  Compilers are generally comprised
of a front-end and a back-end.  The front-end parses the text, tokenizing the
strings it reads and generates an intermediate representation of the code as
well as a symbol table to associate objects with their properties.  The back-end
takes the intermediate representation and outputs machine code.  The
intermediate representation is generally in the format of three-address code, or
instructions that have at most two operands and one output.  This property makes
intermediate representations quite similar to assembly instructions and thereby
simplifies the translation between intermediate representation and machine code.
Intermediate representation is however machine independent whereas assembly code
is not.  This property creates an interface between the front-end and back-end,
allowing for example one front-end to be used with multiple back ends.  Figure
\ref{fig:opt_compiler} illustrates the components of an optimizing compiler.

![\label{fig:opt_compiler} View of compiler, showing where optimization passes
may be applied.  Transformations are applied
iteratively.](imgs/compiler_detailed.png)

In between the front and back end, optimizing compilers apply passes that
transform the code for better performance.  Common optimizations include: dead
code elimination, loop invariant code motion, function inlining, loop rotation,
constant propagation, strength reduction.  The reasoning behind why these
transformations improve the performance of software running on a CPU boil down
to three main reasons,  Firstly, improving memory performance by either reducing
the number of memory accesses or improving cache hit rate.  Secondly,  reducing
the number of instructions that need to be executed.  Thirdly, replacing
"costly" or time and resource consuming instructions with instructions that are
performed more quickly by CPU.  What they all have in common is that they are
specific to the nature of computer architecture which differs greatly from FPGA
architecture.

The role of compiler passes comes into play in two ways.  Firstly, compiler
passes with affect the hardware generated by LegUp.  Qijing Huang at the LegUp
research group conducted a detailed study into compiler pass recipes (i.e.
combinations of passes) to investigate the resulting hardware generated by LegUp
\cite{compiler_passes}.  Secondly, compiler passes transform code into forms more
suitable for running in CPUs.  Not all of these are suitable for running on
FPGAs.  The reversal of these passes when decompiling software with the
intention of then running high level synthesis has been identified as a point of
interest \cite{decompilation_techniques}.

# Progress to Date

<!--

* method, SW and HW measurements
* identification of passes that benefit software, but are detrimental to hardware

-->

Initially, the focus was on identifying compiler passes that improved
performance in software, but detrimented performance in hardware.  

To do so first required a method for measuring performance.  These experiments
were done on an Altera DE1-SOC, which contains a Cyclone V FPGA and an ARM A9
CPU.  The canonical benchmarks for HLS related experiments and the ones used
here are the chstone benchmarks \cite{chstone}.  LegUp has three main flows:
pure software, pure hardware, and hybrid.  The pure software flow compiles the
benchmark for ARM and runs the program on the ARM processor on the DE1 board.
The pure hardware flow runs high level synthesis on the benchmark, implementing
all of the benchmark on the FPGA fabric.  The hybrid flow synthesizes select
functions (user specified) for running on the FPGA and runs the remainder of the
program in software on the ARM Processor.

To measure software performance, the benchmarks were compiled through LegUp's
software mode and profiled with LegUp code that reports the number of cycles
spent in each function.  Unfortuately, the profiling is not very accurate, with
variations in measurements of up to 20%.  Measurements were averaged over five
runs.  The clock frequency can be taken to be constant, as the processor was not
modified.

To measure hardware performance, the benchmarks were compiled through LegUp's
hardware mode.  Cycle count was obtained through simulation in ModelSim.  The
maximum frequency (fmax) at which the circuit could be run was obtained through
Quartus static timing analysis.  Together, the cycle count and fmax give total
latency, as in Equation {@eq:hw}.

$$
\textrm{latency} = \frac{\mathrm{cycles}}{\mathrm{Fmax}}
$$ {#eq:hw}

Initial results show that the effect of compiler passes are highly dependent
upon the program.  No universal trends present themselves.  In Figure
\ref{fig:results}, four compiler passes are shown, with their percent
improvement for each of the chstone benchmarks in both hardware and software.
These measurements are for the compiler pass applied independently, with all
other optimizations disabled.  The key is to look for instances where the blue
(software) and green (hardware) bars go in opposite directions, meaning that one
is a positive value and the other is a negative value.  For instance, on the
graph for the pass `sink`, and the benchmark `dfadd`, there is a 3% improvement
on hardware and a 7% decline in performance in software.  Again, the aim was to
identify compiler passes where the software was improved and the hardware was
worsened, because they would be of particular interest while investigating
binary synthesis.

![\label{fig:results} Initial comparison of compiler passes in hardware and
software](imgs/results.png)

# Future Work

<!--

* shift from compiler passes investigation to decompiler flow
    - because no clear trends identified
* aim is to get decompiler flow working
    - then measure and compare source code vs from decompiler
    - possibly compiler pass work will help in (1) interpreting results and (2)
      improving performance by manipulating IR

-->

Initial results on comparing compiler passes in software and hardware were
inconclusive, so the focus will be shifted to the decompilation flow.  The aim
will be to successfully run decompilation and high level synthesis on a small
set of benchmarks.  The purpose is to demonstrate the concept of binary
synthesis on binaries and compare the results with high level synthesis on the
source code.  An initial investigation into open source decompilation projects
indicate that decompilation is feasible for simple programs using existing
projects, but will not work for some of the more complex chstone benchmarks.


\newpage
\printbibliography[heading=bibintoc]
