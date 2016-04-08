Binary Synthesis
================

<!--

* shift from compiler passes investigation to decompiler flow
    - because no clear trends identified
* aim is to get decompiler flow working
    - then measure and compare source code vs from decompiler
    - possibly compiler pass work will help in (1) interpreting results and (2)
      improving performance by manipulating IR

Initial results on comparing compiler passes in software and hardware were
inconclusive, so the focus will be shifted to the decompilation flow.  The aim
will be to successfully run decompilation and high level synthesis on a small
set of benchmarks.  The purpose is to demonstrate the concept of binary
synthesis on binaries and compare the results with high level synthesis on the
source code.  An initial investigation into open source decompilation projects
indicate that decompilation is feasible for simple programs using existing
projects, but will not work for some of the more complex chstone benchmarks.

-->

Binary synthesis was performed on a small example program, matrix multiply.  The
initial results indicate that performance of HLS tools can vary widely depending
on the way the C code is written, even if it results in functionally equivalent
programs.

The source program used is available in Appendix \ref{app:c}.

Decompilation
-------------

Retargetable decompiler \cite{retdec} was used to decompile the source program.
The resulting code is available in Appendix \ref{app:c}.  For the remainder of
the thesis, the term **recovered code** will be used to refer to decompiled C
code and **source code** will stictly be used to refer to the original
hand-written C code.

### Comparison of source and recovered code

The overall structure of the code was preserved in the decompilation process.
The core of the source code is shown in listing \ref{lst:src_main}.  The inner
loop of the covered code is show in listing \ref{lst:rec_inner}.

\begin{lstlisting}[caption={Matrix multiply source code.},label={lst:src_main},language=C]
for (i = 0; i < n; i++) {
    for (j = 0; j < n; j++) {
        row_dot_col = 0;
loop:   for (k = 0; k < n; k++) {
            row_dot_col += A[i * n + k] * B[k * n + j];
        }
        sum += row_dot_col;
        C[i * n + j] = row_dot_col;
    }
}
\end{lstlisting}

\begin{lstlisting}[caption={Inner loop of recovered code.},label={lst:rec_inner},language=C]
while (v15 < n) {
    // 0x8048520
    v11 = v15;
    v12 = *(int32_t *)(4 * (v11 + v10) + (int32_t)A);
    v13 = *(int32_t *)(4 * (v11 * n + v7) + (int32_t)B);
    v14 += v13 * v12;
    v15 = v11 + 1;
    // continue -> 0x8048520
}
\end{lstlisting}

#### Variable naming

Some variable names are preserved.  The variables `A`, `B`, `C`, and `n` are
function parameters, so it is likely that the function declaration is the source
of the symbols.  The local variables `i`, `j`, and `k` however are not seen in
the recovered code.  All the local variables in the recovered code are named
generically.

#### Style of memory access

The style of memory access differs.  This specifically refers to the syntax
used, not to be confused with the patterns of the addresses accessed.  The
source code uses the square bracket syntax to access array elements (e.g.
`A[i]`) where as the recovered code does a very strange casting and
dereferencing.  The recovered code casts the pointer to integer, advances it
arithmetically to point to the desired element, casts it back to pointer, and
finally uses `*p` notation to dereference the new pointer.


Results
-------

+---------------------+--------+------------+-----+-----+--------------+
|                     | cycles | FMax (MHz) | ALM | REG | Latency (us) |
+=====================+========+============+=====+=====+==============+
| recovered           | 42854  | 201.01     | 151 | 320 | 213.19       |
+---------------------+--------+------------+-----+-----+--------------+
| source              | 50464  | 183.05     | 144 | 280 | 275.68       |
+---------------------+--------+------------+-----+-----+--------------+

: Source and recovered code run through high level synthesis.

+---------------------+--------+------------+-----+-----+--------------+
|                     | cycles | FMax (MHz) | ALM | REG | Latency (us) |
+=====================+========+============+=====+=====+==============+
| recovered           | 42854  | 201.01     | 151 | 320 | 213.19       |
+---------------------+--------+------------+-----+-----+--------------+
| source              | 50464  | 183.05     | 144 | 280 | 275.68       |
+---------------------+--------+------------+-----+-----+--------------+
| loop extract single | 51260  | 199.48     | 155 | 289 | 256.97       |
+---------------------+--------+------------+-----+-----+--------------+
| `*p` memory access  | 51260  | 201.98     | 166 | 290 | 253.79       |
+---------------------+--------+------------+-----+-----+--------------+
| `inttoptr`          | 51260  | 208.07     | 168 | 321 | 246.36       |
+---------------------+--------+------------+-----+-----+--------------+

: Attempts to mimic results seen in recovered code by making small changes to
source code.
