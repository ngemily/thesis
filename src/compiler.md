# Compiler Passes

<!--

* method, SW and HW measurements
* identification of passes that benefit software, but are detrimental to hardware

-->

## Methodology

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


## Results

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

\begin{figure}[htbp]
\centering
    \includegraphics[width=\textwidth]{imgs/results.png}
    \caption{Initial comparison of compiler passes in hardware and software.}
    \label{fig:results}
\end{figure}
