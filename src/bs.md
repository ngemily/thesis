# Binary Synthesis

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
