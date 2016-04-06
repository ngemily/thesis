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

\begin{figure}[htbp]
\centering
    \includegraphics[width=\textwidth]{imgs/binary_synthesis.png}
    \caption{LegUp flow from source code and flow from binary.}
    \label{fig:decompile}
\end{figure}

There are a number of stages where the program is being transformed from one
format to another, as shown in Figure \ref{fig:decompile}.  Each transformation
can be done with various levels of optimization, which will affect the final
results.
