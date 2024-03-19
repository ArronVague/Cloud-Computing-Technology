%orginally designed by Zonaldo
\ProvidesClass{expreport}
\LoadClass[12pt]{ctexart}
\RequirePackage{xeCJK}
\RequirePackage{CJKnumb}
\RequirePackage{graphicx}
\RequirePackage{geometry}
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage{enumitem}
\RequirePackage{listings}
\RequirePackage{xcolor}
\RequirePackage{array}
\RequirePackage{mathtools}
\RequirePackage{float}
\RequirePackage{indentfirst}
\RequirePackage{zhnumber}
\RequirePackage{booktabs}


\linespread{1.2}
\geometry{top=1in,bottom=1in,left=1in,right=1in}
\setcounter{secnumdepth}{3}
\renewcommand\thesection{\CJKnumber{\arabic{section}}、\hspace{0pt}}
\renewcommand\thesubsection{\arabic{subsection}.}
\renewcommand\thesubsubsection{\alph{subsubsection})}
\setlist[enumerate,1]{label=(\arabic*)}
\setlist[enumerate,2]{label=\alph*.}

\setCJKmainfont[
    Path = fonts/ ,
    Extension = .ttf ,
    BoldFont = SimHei ,
    ItalicFont = simkai ,
]{SimSun}


\titleformat*{\section}{\zihao{-3}\bfseries}

\titleformat*{\subsection}{\zihao{4}\bfseries}
\titleformat*{\subsubsection}{\zihao{-4}}
\graphicspath{{figures/}{figure/}{pictures/}%
        {picture/}{pic/}{pics/}{image/}{images/}}

\titlespacing{\subsection}{1em}{*4}{*1.5}
\titlespacing{\subsubsection}{1em}{*4}{*1.5}

% 代码格式和颜色定义
\definecolor{dkgreen}{rgb}{0,0.6,0}
\definecolor{gray}{rgb}{0.5,0.5,0.5}
\definecolor{comment}{rgb}{0.56,0.64,0.68}
\lstset{
    frame=tb,
    aboveskip=3mm,
    belowskip=3mm,
    xleftmargin=2em,
    xrightmargin=2em,
    showstringspaces=false,
    columns=flexible,
    framerule=1pt,
    rulecolor=\color{gray!35},
    backgroundcolor=\color{gray!5},
    basicstyle={\small\ttfamily},
    numbers=none,
    numberstyle=\tiny\color{gray},
    keywordstyle=\color{blue},
    commentstyle=\color{comment},
    stringstyle=\color{dkgreen},
    breaklines=true,
    breakatwhitespace=true,
    tabsize=2,
}

% 信息
\newcommand\major[1]{\def\@major{#1}}
\newcommand\course[1]{\def\@course{#1}}
\newcommand\name[1]{\def\@name{#1}}
\newcommand\stuid[1]{\def\@stuid{#1}}
\newcommand\college[1]{\def\@college{#1}}
\renewcommand\date[1]{\def\@date{#1}}
\newcommand\lab[1]{\def\@lab{#1}}
\newcommand\instructor[1]{\def\@instructor{#1}}
\newcommand\grades[1]{\def\@grades{#1}}
\newcommand\expname[1]{\def\@expname{#1}}
\newcommand\exptype[1]{\def\@exptype{#1}}
\newcommand\partner[1]{\def\@partner{#1}}
\newcommand\loc[1]{\def\@loc{#1}}
\newcommand\group[1]{\def\@group{#1}}
\newcommand\ttitle[1]{\def\@ttitle{#1}}
% 页眉
\pagestyle{empty}
% \lhead{实验名称：\@expname}
% \chead{姓名：\@name}
% \rhead{学号：\@stuid}

% 下划线定义
\def\ul[#1]#2{
    \underline{\hbox to #1{\hfil#2\hfil}}}

% 封面
\newcommand{\makecover}{
    \begin{center}
        \begin{center}

        \end{center}

        \bfseries\zihao{2}{\vspace{5cm}中山大学软件工程学院}\\
        \vspace{6.5pt}
        \bfseries\zihao{1}{SSE316云计算技术课程论文}

        \vspace{3cm}

        \begin{center}
            \zihao{3}
            \renewcommand\arraystretch{1.6}
            \vspace{4cm}

            \begin{tabular}{p{8cm}p{8cm}}
                \multicolumn{2}{l}{\textbf{姓名：\ul[200pt]{\@name}}}  \\
                \multicolumn{2}{l}{\textbf{学号：\ul[200pt]{\@stuid}}} \\
                \multicolumn{2}{l}{\textbf{日期：\ul[200pt]{\@date}}}  \\
            \end{tabular}

        \end{center}
        \vspace{2cm}
    \end{center}
    \thispagestyle{empty}
    \newpage
}
