\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{umalayathesis}[umalayathesis.cls v2.0]

\p@=1bp
\LoadClass[12pt,a4paper,oneside]{memoir}
\RequirePackage{etoolbox}
\RequirePackage{calc}
\RequirePackage{enumitem}
\RequirePackage{quoting}

\def\theauthor{\textbf{!INSERT AUTHOR!}}
\def\thetitle{\textbf{!INSERT TITLE!}}
\def\@field{\textbf{!INSERT FIELD!}}
\def\@identification{\textbf{!INSERT IC NO!}}
\def\@matric{\textbf{!INSERT MATRIC NO!}}
\def\thetajuk{}
\def\@faculty{\textbf{!INSERT FACULTY!}}
\def\@department{\textbf{!INSERT DEPARTMENT!}}
\def\@uni{Universiti Malaya}
\def\@submissionyear{\textbf{!INSERT YEAR!}}
\def\@degree{\textbf{!INSERT DEGREE!}}

\newcommand{\fieldofstudy}[1]{\def\@field{#1}}
\newcommand{\identification}[1]{\def\@identification{#1}}
\newcommand{\matric}[1]{\def\@matric{#1}}
\newcommand{\university}[1]{\def\@uni{#1}}
\newcommand{\faculty}[1]{\def\@faculty{#1}}
\newcommand{\submissionyear}[1]{\def\@submissionyear{#1}}
\newcommand{\department}[1]{\def\@department{#1}}
\newcommand{\degree}[1]{\def\@degree{#1}}
\newcommand{\tajuk}[1]{\def\thetajuk{#1}}

\def\mastercoursework{1}
\def\mastermixedmode{2}
\def\masterresearch{3}
\def\doctoralresearch{4}
\def\doctoralmixedmode{5}
\def\doctoralcoursework{6}

%%%%%
% Page Layout
%%%%%
\settrimmedsize{297mm}{210mm}{*}
\setlrmarginsandblock{40mm}{20mm}{*}
\setulmarginsandblock{20mm}{20mm+1.25ex}{*}
\setheadfoot{\baselineskip}{10mm}
\addtolength\footskip{1.25ex}
\makeoddfoot{plain}{}{}{\footnotesize\thepage}
\makeevenfoot{plain}{}{}{\footnotesize\thepage}
\pagestyle{plain}
\checkandfixthelayout

%%%%%
% Simulate MS Windows Fonts
%%%%%
\RequirePackage[T1]{fontenc}
\RequirePackage[scaled]{helvet}
\RequirePackage{newtxtext,newtxmath}
\RequirePackage{inconsolata}
\RequirePackage{bm}

\AddToHook{begindocument/before}{%
    \RequirePackage[breaklinks,pdfborder={0 0 0},bookmarksdepth=3,hypertexnames=false,pdfpagelabels=false]{hyperref}
    \RequirePackage[depth=3]{bookmark}
}

%%%%% 
% Line and Paragraph Spacing
%%%%%
\DisemulatePackage{setspace}
\RequirePackage{setspace}
\setstretch{2.0}
\setlength\parindent{0.5cm}

%%%%%
% Footnotes
%%%%%
\renewcommand{\foottextfont}{\tiny}
\setlength\footnotesep{\onelineskip}
\setlength\footmarkwidth{0pt}
\setlength{\footmarksep}{0pt}
\footmarkstyle{\makebox[1em][l]{\textsuperscript{#1}}}

%%%%%
% Back Matter
%%%%%
\patchcommand{\backmatter}{}{\footnotesize}

%%%%%
% Cover and Title Page
%%%%%
\newcommand{\makecoverandtitlepage}[1]{%
    \let\thesis@type=#1
    \ignorespaces
    \changepage{-60mm+1.25ex}{-20mm}{20mm}{0pt}{0pt}{30mm}{0pt}{0pt}{0pt}
    \hypersetup{pageanchor=false}
    \begin{titlingpage}%
        \setSingleSpace{1.15}\SingleSpacing%
        \centering%
        \fontfamily{qhvc}\fontseries{b}\fontsize{16\p@}{18\p@}\selectfont%
        \MakeTextUppercase{\thetitle}\par%
        \vfill%
        \MakeTextUppercase{\theauthor}\par%
        \vfill%
        \MakeTextUppercase{\@faculty}\\%
        \MakeTextUppercase{\@uni}\\%
        KUALA LUMPUR\par%
        \bigskip%
        \@submissionyear\par%
    \end{titlingpage}%
    \hypersetup{pageanchor=true}
        {\setSingleSpace{1.15}\SingleSpacing%
        \centering\thispagestyle{empty}\setcounter{page}{1}%
        \fontsize{14\p@}{16\p@}\selectfont\bfseries%
        \MakeTextUppercase{\thetitle}\par%
        \vfill%
        {\MakeTextUppercase{\theauthor}\par}%
        \vfill%
        \ifcase\thesis@type
        \or % 1 -- mastercoursework
        \statement@mastercoursework%
        \or % 2 -- mastermixedmode
        \statement@mastermixedmode%
        \or % 3 -- masterresearch
        \statement@masterresearch%
        \or % 4 -- doctoralresearch
        \statement@doctoralresearch
        \or % 5 -- doctoralmixedmode
        \statement@doctoralmixedmode
        \or % 6 -- doctoralcoursework
        \statement@doctoralcoursework
        \fi%
        \vfill%
        \@submissionyear%
        \par\clearpage%
    }
    \changepage{60mm-1.25ex}{20mm}{-20mm}{0pt}{0pt}{-30mm}{0pt}{0pt}{0pt}
}

\newcommand\statement@mastercoursework{%
    RESEARCH PROJECT SUBMITTED TO THE\\\MakeTextUppercase{\@faculty}\\%
    \MakeTextUppercase{\@uni}, IN PARTIAL FULFILMENT OF THE REQUIREMENTS FOR THE DEGREE OF \MakeTextUppercase{\@degree}%
}

\newcommand\statement@mastermixedmode{%
    DISSERTATION SUBMITTED IN PARTIAL FULFILMENT OF THE REQUIREMENTS FOR THE DEGREE OF \MakeTextUppercase{\@degree}%
    \vfill\faculty@block%
}

\newcommand\statement@masterresearch{%
    DISSERTATION SUBMITTED IN FULFILMENT OF THE REQUIREMENTS FOR THE DEGREE OF \MakeTextUppercase{\@degree}%
    \vfill\faculty@block%
}

\newcommand\statement@doctoralresearch{%
    THESIS SUBMITTED IN FULFILMENT OF THE REQUIREMENTS FOR THE DEGREE OF \MakeTextUppercase{\@degree}%
    \vfill\faculty@block%
}

\newcommand\statement@doctoralmixedmode{%
    THESIS SUBMITTED IN PARTIAL FULFILMENT OF THE REQUIREMENTS FOR THE DEGREE OF \MakeTextUppercase{\@degree}%
    \vfill\faculty@block%
}

\newcommand\statement@doctoralcoursework{%
    DISSERTATION SUBMITTED IN PARTIAL FULFILMENT OF THE REQUIREMENTS FOR THE DEGREE OF \MakeTextUppercase{\@degree}%
    \vfill\faculty@block%
}

\newcommand\faculty@block{%
    \MakeTextUppercase{\@department}\\
    \MakeTextUppercase{\@faculty}\\
    \MakeTextUppercase{\@uni}\\
    KUALA LUMPUR%
}

%%%%%
% Declaration Page
%%%%%
\newcommand{\declarationpage}{%
    \chapter*{\@uni\vskip1em Original Literary Work Declaration}
    {%
        \noindent Name of Candidate: \textbf{\MakeTextUppercase{\theauthor}}\par
        \noindent I.C./Passport No.: \textbf{\@identification}\par
        \noindent Registration/Matric No.: \textbf{\@matric}\par
        \noindent Name of Degree: \textbf{\MakeTextUppercase{\@degree}}\par
        \noindent Title of Project Paper/Research Report/Dissertation/Thesis (``this Work''):\par
        \noindent \textbf{\MakeTextUppercase{\thetitle}}\par
        \noindent Field of Study: \textbf{\MakeTextUppercase{\@field}}\par
    
        {\SingleSpacing\setSingleSpace{1.15}
        I do solemnly and sincerely declare that:
    
        \begin{enumerate}[noitemsep,label=(\arabic*)]
        \item I am the sole author/writer of this Work;
        \item This work is original;
        \item Any use of any work in which copyright exists was done by way of fair dealing and for permitted purposes and any excerpt or extract from, or reference to or reproduction of any copyright work has been disclosed expressly and sufficiently and the title of the Work and its authorship have been acknowledged in this Work;
        \item I do not have any actual knowledge nor do I ought reasonably to know that the making of this work constitutes an infringement of any copyright work;
        \item I hereby assign all and every rights in the copyright to this Work to \@uni\ (``UM''), who henceforth shall be owner of the copyright in this Work and that any
        reproduction or use in any form or by any means whatsoever is prohibited without the
        written consent of UM having been first had and obtained;
        \item I am fully aware that if in the course of making this Work I have infringed any copyright
        whether intentionally or otherwise, I may be subject to legal action or any other action
        as may be determined by UM.
        \end{enumerate}
        }
        
        \vfill
        \hspace{1.1em} Candidate's Signature \hfill Date:\hspace{6em}
        \vfill
        \noindent Subscribed and solemnly declared before,
        \vfill
        \hspace{1.1em} Witness's Signature \hfill Date:\hspace{6em}
        
        {\SingleSpacing\small
        \noindent Name:\par
        \noindent Designation:\par}
    }
\clearpage}

%%%%%
% Abstract
%%%%%
\renewcommand*\absnamepos{center}
\setlength\abstitleskip{0pt}
\renewcommand\abstractnamefont{\normalsize\bfseries}
\renewcommand\abstracttextfont{\normalsize}
\setlength\absleftindent{0pt}
\setlength\absrightindent{0pt}

\let\tempabstract\abstract
\let\endtempabstract\endabstract
\renewcommand\abstract{
    \clearpage%
    \renewcommand*\abstractname{\MakeTextUppercase{\thetitle}\par ABSTRACT}
    \phantomsection\addcontentsline{toc}{chapter}{Abstract}
    \tempabstract\setlength{\parindent}{0pt}\noindent\ignorespaces
}
\def\endabstract{
    \endtempabstract
}
\newcommand\abstrak{
    \clearpage%
    \ifdefempty{\thetajuk}
        {\renewcommand*\abstractname{ABSTRAK}}
        {\renewcommand*\abstractname{\MakeTextUppercase{\thetajuk}\par ABSTRAK}}
    \phantomsection\addcontentsline{toc}{chapter}{Abstrak}
    \tempabstract\setlength{\parindent}{0pt}\noindent\ignorespaces
}
\def\endabstrak{
    \endtempabstract
}

%%%%%
% Acknowledgements
%%%%%
\newcommand{\acknowledgements}[1]{\chapter{Acknowledgements}#1}

%%%%%
% Chapter Headings
%%%%%
\renewcommand\chapterheadstart{\bgroup\SingleSpacing\normalsize\vskip\beforechapskip}
\appto{\afterchaptertitle}{\egroup}
\setlength\beforechapskip{0pt}
\setlength\midchapskip{2\onelineskip}
\setlength\afterchapskip{\onelineskip}
\renewcommand*\chapnamefont{\normalsize\bfseries}
\renewcommand*\chapnumfont{\normalsize\bfseries\centering}
\renewcommand*\chaptitlefont{\normalsize\bfseries\boldmath\centering}
\renewcommand*{\afterchapternum}{: }
\renewcommand{\printchaptername}{{\chapnamefont\MakeTextUppercase{\chaptername}}}
\renewcommand*{\printchaptertitle}[1]{{\chaptitlefont\MakeTextUppercase{#1}\par}}

%%%%%
% Appendices
%%%%%
\newlistof{listofappendices}{apx}{List of Appendices}
\addtodef\appendix{}{\renewcommand\chaptername{\appendixname}}
\def\app@chapter[#1]#2{%
  \m@mpn@new@chaptrue%
  \m@mpn@new@schapfalse%
  \def\f@rbdy{#2}%
  \ifx\ch@pt@c\@empty
    \def\f@rtoc{#2}%
    \def\f@rhdr{#2}%
  \else
    \let\f@rtoc\ch@pt@c
    \ifx\@empty#1\@empty
      \let\f@rhdr\ch@pt@c
    \else
      \def\f@rhdr{#1}%
    \fi
  \fi
  \m@m@Andfalse
  \ifnum \c@secnumdepth >\m@ne
    \if@mainmatter
      \m@m@Andtrue
    \fi
  \fi
  \ifm@m@And
    \refstepcounter{chapter}%
  \fi
  \ifartopt
    \@makechapterhead{#2}%
    \@afterheading
    \chaptermark{\f@rhdr}%
  \else
    \chaptermark{\f@rhdr}
    \insertchapterspace
    \@makechapterhead{#2}%
    \@afterheading
  \fi
  \ifm@m@And
    \ifanappendix
      \addcontentsline{apx}{appendix}{%
        \protect\chapternumberline{\thechapter}\f@rtoc}%
      \memappchapinfo{\thechapter}{\f@rtoc}{\f@rhdr}{#2}%
    \else
      \addcontentsline{apx}{chapter}{%
        \protect\chapternumberline{\thechapter}\f@rtoc}%
      \memchapinfo{\thechapter}{\f@rtoc}{\f@rhdr}{#2}%
    \fi
  \else
    \addcontentsline{apx}{chapter}{\f@rtoc}%
    \ifanappendix
      \memappchapinfo{}{\f@rtoc}{\f@rhdr}{#2}%
    \else
      \memchapinfo{}{\f@rtoc}{\f@rhdr}{#2}%
    \fi
  \fi
  \ifheadnameref\M@gettitle{\f@rhdr}\else\M@gettitle{\f@rtoc}\fi}

\newcommand*{\startapps}{%
  \cftinserthook{apx}{AppendixToCLines}
  \clearpage\appendix%
  \phantomsection\addcontentsline{toc}{chapter}{\appendixtocname}
  \let\@chapter\app@chapter
  \settocdepth{chapter}%
  \renewcommand{\insertchapterspace}{\oldinsertchapterspace}
}
\newcommand*{\finishapps}{%
  \settocdepth{subsubsection}%
}

\appto{\appendices}{\startapps\let\startapps\relax}
\preto{\endappendices}{\finishapps\let\finishapps\relax}
\cftinsertcode{AppendixToCLines}{%
  \renewcommand*\cftchapteraftersnum{:\space}%
  \setlength\cftchapternumwidth{2em}%
  \renewcommand*\cftchapterfont{\normalfont\mdseries\upshape}%
  \renewcommand*\cftchapterpagefont{\normalfont\mdseries\upshape}%
}

%%%%%
% Sectional Headings
%%%%%
\RequirePackage{titlesec}
\indentafterchapter
\setsecnumdepth{paragraph}
\renewcommand{\theparagraph}{(\alph{paragraph})}
\titleformat{\section}[hang]{\SingleSpacing\normalsize\bfseries}
    {\makebox[4em][l]{\thesection}}{0pt}{}
\titlespacing{\section}{0pt}{2.5ex plus 1ex minus .2ex}{0.1ex plus .2ex}
\titleformat{\subsection}[hang]{\SingleSpacing\normalsize\bfseries}
    {\makebox[4em][l]{\thesubsection}}{0pt}{}
\titlespacing{\subsection}{0pt}{2.5ex plus 1ex minus .2ex}{0.1ex plus .2ex}
\titleformat{\subsubsection}[hang]{\SingleSpacing\normalsize\bfseries}
    {\makebox[4em][l]{\thesubsubsection}}{0pt}{}
\titlespacing{\subsubsection}{0pt}{2.5ex plus 1ex minus .2ex}{0.1ex plus .2ex}
\titleformat{\paragraph}[hang]{\SingleSpacing\normalsize\mdseries}
    {\theparagraph}{1em}{\itshape\bfseries}
\titlespacing{\paragraph}{0pt}{2.5ex plus 1ex minus .2ex}{0.1ex plus .2ex}

%%%%%
% Subfloats and Captions
%%%%%
\newsubfloat{figure}
\newsubfloat{table}
\setcounter{lofdepth}{2}
\setcounter{lotdepth}{2}
\captionnamefont{\bfseries\normalsize}
\captiontitlefont{\bfseries\normalsize}

%%%%%
% Symbols and Abbreviations
%%%%%
\RequirePackage{longtable}
\newenvironment{listofacronyms}%
    {\chapter{List of Symbols and Abbreviations}
    \centering
    \begin{longtable}[l]{l @{\hspace{1.5em}:\hspace{1.5em}} p{25em}}}
    {\end{longtable}}

%%%%%
% Quotes
%%%%%
\quotingsetup{leftmargin=0.5in,indentfirst=false}
\let\quote\quoting
\let\endquote\endquoting
\let\quotation\quoting
\let\endquotation\endquotation

%%%%%
% List Indent
%%%%%
\setlist{noitemsep}
\setlist[1]{leftmargin=2.5em,labelwidth=*}

%%%%%
% Table of Contents
%%%%%
\settocdepth{subsubsection}
\renewcommand\cftdotsep{0}
\renewcommand{\cftchapterleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftfigureleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cfttableleader}{\cftdotfill{\cftdotsep}}
\setrmarg{3.55em plus 1fil}
\renewcommand*{\cftchaptername}{\MakeTextUppercase{\chaptername}\space}
\renewcommand*{\cftchapteraftersnum}{:\space}
\renewcommand*{\cftappendixname}{\appendixname\space}
\setlength\cftsectionindent{0pt}

\patchcmd{\l@chapapp}%
    {\cftchapterfont {#1}}%
    {\cftchapterfont \texorpdfstring{%
      \uppercase{#1}}{{#1}} }%
    {}{}%

\patchcmd{\l@chapapp}{\advance\memRTLleftskip\@tempdima}{}{}{}

\setlength{\cftbeforechapterskip}{0pt}
\setlength\cftsubsectionindent{\cftsectionnumwidth}
\setlength\cftbeforesectionskip{0pt}
\setlength\cftbeforesubsectionskip{0pt}
\setlength\cftsubsubsectionindent{\cftsubsectionnumwidth}
\addtolength{\cftsubsubsectionindent}{\cftsubsectionindent}
\setlength\cftbeforesubsubsectionskip{0pt}

\renewcommand*\cftfigurename{\figurename\space}
\renewcommand*\cfttablename{\tablename\space}
\renewcommand*\cftfigureaftersnum{:\space}
\renewcommand*\cfttableaftersnum{:\space}
\setlength\cftbeforefigureskip{0pt}
\setlength\cftbeforesubfigureskip{0pt}
\renewcommand*\cftsubfigureaftersnum{\space}
\newlength{\tmplength}
\settowidth{\tmplength}{\normalfont\cftfigurename}
\addtolength{\tmplength}{\cftfigurenumwidth}
\cftsetindents{subfigure}{\tmplength}{1.5em}
\setlength\cftbeforetableskip{0pt}
\setlength\cftbeforesubtableskip{0pt}
\renewcommand*\cftsubtableaftersnum{\space}
\settowidth{\tmplength}{\normalfont\cfttablename}
\addtolength{\tmplength}{\cfttablenumwidth}
\cftsetindents{subtable}{\tmplength}{1.5em}

\let\oldinsertchapterspace\insertchapterspace
\let\olduppercase\uppercase
\cftinsertcode{MainChapTocLines}{%
    \renewcommand*\cftchapterfont{\normalfont\bfseries\boldmath\upshape}%
    \renewcommand*\cftchapterpagefont{\normalfont\bfseries\upshape}%
}
\cftinsertcode{PlainChapTocLines}{%
    \renewcommand*\cftchapterfont{\normalfont\mdseries\upshape}%
    \renewcommand*\cftchapterpagefont{\normalfont\mdseries\upshape}%
}
\cftinsertcode{disableuppercase}{%
    \let\uppercase\relax
}
\cftinsertcode{enableuppercase}{%
    \let\uppercase\olduppercase
}

\cftinserthook{apx}{disableuppercase}

\apptocmd{\mainmatter}{
    \addtodef{\insertchapterspace}{}%
{\addtocontents{toc}{\protect\vspace*{\baselineskip}}}%
    \cftinserthook{toc}{MainChapTocLines}%
}{}{}

\setlength\cftbeforechapterskip{\onelineskip}
\setlength\cftbeforesectionskip{\onelineskip}
\setlength\cftbeforesubsectionskip{\onelineskip}
\setlength\cftbeforesubsubsectionskip{\onelineskip}
\setlength\cftbeforetableskip{\onelineskip}
\setlength\cftbeforesubtableskip{\onelineskip}
\setlength\cftbeforefigureskip{\onelineskip}
\setlength\cftbeforesubfigureskip{\onelineskip}
\preto{\tocheadstart}{\SingleSpacing}
\preto{\lotheadstart}{\SingleSpacing}
\preto{\lofheadstart}{\SingleSpacing}
\preto{\apxheadstart}{\SingleSpacing}

\renewcommand*\abstractname{Abstract}
\renewcommand*\contentsname{Table of Contents}
\renewcommand*\listtablename{List of Tables}
\renewcommand*\listfigurename{List of Figures}
\renewcommand*\appendixname{Appendix}
\renewcommand\appendixtocname{Appendices}
\renewcommand*\indexname{Index}

%%%%%
% Bibliography
%%%%%
\RequirePackage[
    style=apa6,
    sortcites=false,
]{biblatex}

\setlength\bibitemsep{2\onelineskip}
\renewcommand{\bibfont}{\SingleSpacing}
\setlength{\leftmargin}{0.5in}
\setlength{\itemindent}{-0.5in}

\renewcommand*{\mkbibnamegiven}[1]{%
  \ifitemannotation{highlight}
    {\textbf{#1}}
    {#1}}
\renewcommand*{\mkbibnamefamily}[1]{%
  \ifitemannotation{highlight}
    {\textbf{#1}}
    {#1}}

\def\references{%
    \printbibliography[
        title=References, 
        notkeyword=own
    ]
}

\defbibenvironment{ownbibliography}
    {\enumerate[
        itemsep=2\onelineskip,
        label=\theenumi.,
        left=0em,
        labelsep=1.5em-\labelsep,
        align=left
    ]}
    {\endenumerate}
    {\item}
    
\def\ownreferences{%
    \printbibheading[title=List of Publications and Papers Presented]
    \nobibintoc
    \printbibliography[
        heading=subbibliography, 
        env=ownbibliography, 
        title=Journal Articles, 
        keyword=own, notkeyword=conf
    ]
    \printbibliography[
        heading=subbibliography,
        env=ownbibliography,
        title=Conference Proceedings,
        keyword=own, keyword=conf
    ]
}