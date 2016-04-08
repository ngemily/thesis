---
title: 'Investigation into Existing Decompilers for Usage with High Level
Synthesis'
date: April 2016
author: Emily Ng
filter: pandoc-eqnos
classoption: oneside
header-includes:
    - \usepackage{fullpage}
    - \usepackage{sty/myTitle}
    - \linespread{1.5}
    - \usepackage{caption}
    - \usepackage{subcaption}
    - \usepackage{longtable}
    - \usepackage{booktabs}
    - \usepackage[section]{placeins}
    - \usepackage[backend=biber]{biblatex}
    - \addbibresource{bib/report.bib}
    - \usepackage{color}
---

\renewcommand{\bibname}{References}
\renewcommand{\chaptername}{Section}

\frontmatter

\include{abstract}
\include{acknowledgements}

\tableofcontents

\listoffigures
\listoftables

\mainmatter

\include{introduction}
\include{background}
\include{compiler}
\include{bs}
\include{conclusion}

\appendix
\include{app_c}
\include{app_ll}

\backmatter
\printbibliography[heading=bibintoc]
