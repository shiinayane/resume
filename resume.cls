\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2022/08/21 A CV template based on the Curriculum Vitae of Alex Chi Zhang]
\LoadClass[10pt]{article} % based on article class

%
\RequirePackage[
    a4paper,
    left=0.8in,
    right=0.8in,
    top=0.5in,
    bottom=0.8in,
    nohead
]{geometry}

\RequirePackage{fancyhdr}

% For font setting
\RequirePackage{fontspec}        % explicit: font selection for XeLaTeX/LuaLaTeX
\RequirePackage{titlesec}

% Single source of truth for the bundled fonts directory.
% Note: this path is resolved relative to the current working directory,
% so compile from the project root (or override \resumefontdir).
\newcommand{\resumefontdir}{./fonts/}

% Require XCharter font
\RequirePackage{XCharter}
\setmainfont{XCharter}

% For color
\RequirePackage{xcolor}

% For smarter command definition
% (xparse is part of the LaTeX kernel since 2020, no need to load it)
\RequirePackage{xifthen}

% For hyperlink customization
\RequirePackage[hidelinks]{hyperref}
\IfFileExists{fontawesome5.sty}{
    \RequirePackage{fontawesome5} % icons
}{}
\providecommand{\faEnvelope}{}
\providecommand{\faPhone}{}
\providecommand{\faLinkedinIn}{}
\providecommand{\faLinkedin}{}
\providecommand{\faGithub}{}
\providecommand{\faGlobe}{}
\providecommand{\faLink}{}
\providecommand{\faGraduationCap}{}
\providecommand{\faUsers}{}
\providecommand{\faCogs}{}
\providecommand{\faInfo}{}
\providecommand{\faLocationArrow}{}

% For list environment customizations
\RequirePackage{enumitem}

% For customizing underline
\RequirePackage[normalem]{ulem}
\RequirePackage{contour}

\RequirePackage{setspace}

%% ----------------- END OF PACKAGES ----------------- %%

% Footer
%%% Only add "updated" footer to last page
\pagestyle{fancy}
\fancypagestyle{default}{
    \fancyhf{}
    \RenewDocumentCommand{\headrulewidth}{}{0pt}
}
\fancypagestyle{lastpage}{
    \fancyhf{}
    \RenewDocumentCommand{\headrulewidth}{}{0pt}
    \rfoot{\color{gray}Updated on \today}
}

% Spacings
\setlength{\footskip}{12pt}
\setlength{\parindent}{0pt}
\setlength{\leftskip}{0pt}
\setlist[itemize]{
    leftmargin=36pt,
    itemsep=-\parsep,
    topsep=-\partopsep-\parskip,
    after=\vspace{2pt}
}

% Font size macros
\newcommand{\HUGE}{\@setfontsize\HUGE{24pt}{18}}
\renewcommand\Huge{\@setfontsize\Huge{22pt}{18}}
\renewcommand\huge{\@setfontsize\huge{20pt}{18}}
\renewcommand\LARGE{\@setfontsize\LARGE{18pt}{18}}
\renewcommand\Large{\@setfontsize\Large{12pt}{18}}
\renewcommand\large{\@setfontsize\large{11pt}{18}}

% heading font: Avenir Next
\IfFontExistsTF{Avenir Next LT Pro}{
    \newfontfamily{\headingfont}{Avenir Next LT Pro}
}{
    % use local font in ./fonts folder (system "Avenir Next" .ttc is
    % reported by \IfFontExistsTF but fails to load via \newfontfamily)
    \newfontfamily{\headingfont}{AvenirNextLTPro}[
        Path = \resumefontdir,
        Extension = .otf,
        UprightFont = *-Regular,
        BoldFont = *-Bold,
        ItalicFont = *-Italic,
    ]
}

% heading font: Source Han Serif (local fonts)
\newfontfamily{\hanfont}{SourceHanSerifCN-Regular}[
    Path = \resumefontdir,
    Extension = .otf,
    BoldFont = SourceHanSerifCN-Bold,
    ItalicFont = SourceHanSerifCN-Regular,
    BoldItalicFont = SourceHanSerifCN-Bold,
]

% add CJK fonts and use zh line break
% usage: \useChinese{<normal font weight>}{<bold font weight>}
\newcommand{\useChinese}[2]{
    \RequirePackage{xeCJK}
    \setCJKmainfont{SourceHanSerifCN-#1}[
        Path = \resumefontdir,
        Extension = .otf,
        BoldFont = SourceHanSerifCN-#2,
        ItalicFont = SourceHanSerifCN-#1,
        BoldItalicFont = SourceHanSerifCN-#2,
    ]
    % also define CJK sans/mono families to avoid xeCJK falling back
    % to an undefined family (\CJKttdefault warning)
    \setCJKsansfont{SourceHanSerifCN-#1}[
        Path = \resumefontdir,
        Extension = .otf,
        BoldFont = SourceHanSerifCN-#2,
    ]
    \setCJKmonofont{SourceHanSerifCN-#1}[
        Path = \resumefontdir,
        Extension = .otf,
        BoldFont = SourceHanSerifCN-#2,
    ]
    \XeTeXlinebreaklocale "zh"
    \XeTeXlinebreakskip = 0pt plus 1pt
}

% format for section title
\titleformat{\section}
    {\headingfont\Large}                % shape
    {}                                  % format
    {0em}                               % label
    {\vspace{-2ex}{\color{gray}\hrule}}  % before-code
    []                                  % after-code
\titlespacing{\section}
    {0pt} % left spacing
    {0pt} % before spacing
    {0pt} % after spacing

% format for subseciton title
\titleformat{\subsection}
    {} % shape
    {} % format
    {0em} % label
    {} % beforcode
    [] % aftercode
\titlespacing{\subsection}
    {12pt} % left spacing
    {\parskip} % before spacing
    {\parskip} % after spacing

% custom underline style
\renewcommand{\ULdepth}{3pt}
\contourlength{0.6pt}
\RenewDocumentCommand{\underline}{ m }
{
    \uline{\phantom{#1}}%
    \llap{\contour{white}{#1}}%
}

% ----------------- CUSTOM COMMANDS ----------------- %

\NewDocumentCommand{\cventry}{ m m o o }
{
    \subsection[#1]{\textbf{\Large#1} \hfill #2}
    \IfNoValueTF{#3}
    {}
    {\setlength{\parindent}{12pt}{\par #3 \hfill #4 \par}}
    \vspace{2pt}
}

% \NewDocumentCommand{\datedsubsection}{ m m }{
%   \subsection{
%     \noindent
%     % 创建一个盒子，将右边的#2推到最右侧
%     \makebox[0pt][l]{\hspace{\linewidth}\makebox[0pt][r]{#2}}%
%     % 左边的内容允许自动换行
%     #1
%   }
% }

\NewDocumentCommand{\name}{ m }
{{\headingfont\Huge#1}}

\NewDocumentEnvironment{compactlist}{}
{
    \begin{itemize}[
        label={},
        leftmargin=12pt,
        itemsep=-\parsep,
        topsep=0pt-\partopsep-\parskip,
    ]
}
{
    \end{itemize}
}

\newcounter{infonum}
\NewDocumentCommand{\infomark}{}{}

\NewDocumentEnvironment{basicinfo}{ o }
{%
    \par\vspace{1ex}
    \setcounter{infonum}{0}
    \IfValueTF{#1}{
        \RenewDocumentCommand{\infomark}{}{#1}
    }
    {
    }
}
{%
}

% separator inserted between consecutive \info items.
% This is the SINGLE knob controlling the basic-info line spacing;
% the contact commands below no longer carry per-command \hspace fudge.
\newcommand{\infosep}{\hspace{0.5em}$\mid$\hspace{0.5em}}

\NewDocumentCommand{\info}{ m }{%
    \stepcounter{infonum}%
    \ifthenelse{\theinfonum = 1}{}{\infosep}%
    #1%
}

% defines one's email
% usage: \email{<email>}
\NewDocumentCommand{\email}{ m }{
    \faEnvelope\ \underline{\href{mailto:#1}{#1}}%
}

% defines one's phone
% usage: \phone{<phone>}
\NewDocumentCommand{\phone}{ m }{
    \faPhone\ {#1}%
}

% defines one's location
% usage: \location{<location>}
\NewDocumentCommand{\location}{ m }{
    \faLocationArrow\ {#1}%
}

% defines one's linkedin
% usage: \linkedin{<linkedin>}
\NewDocumentCommand{\linkedin}{ m o }{
    \faLinkedinIn\IfNoValueTF{#2}{
        \underline{\href{#1}{#1}}
    }{
        \underline{\href{#2}{#1}}
    }%
}

\NewDocumentCommand{\linkedinsquare}{ m o }{
    \faLinkedin\IfNoValueTF{#2}{
        \underline{\href{#1}{#1}}
    }{
        \underline{\href{#2}{#1}}
    }%
}

% defines one's GitHub
% usage: \github{<github>}
\NewDocumentCommand{\github}{ m o }{
    \faGithub\IfNoValueTF{#2}{
        \underline{\href{#1}{#1}}
    }{
        \underline{\href{#2}{#1}}
    }%
}

% defines one's homepage
% usage: \homepage{<homepage>}
\NewDocumentCommand{\homepage}{ m o }{
    \faGlobe\IfNoValueTF{#2}{
        \underline{\href{#1}{#1}}
    }{
        \underline{\href{#2}{#1}}
    }%
}

% Customize icon link
% usage: \iconlink[<icon:fontawesome>][<text>]{<url>}
\NewDocumentCommand{\iconlink}{ o o m }{
    \IfNoValueTF{#1}{
        \let\icon\faLink
    }{
        \let\icon#1
    }
    \IfNoValueTF{#2}{
        \hspace{-12pt}\underline{\href{#3}{\icon}}
    }{
        \hspace{-12pt}\underline{\href{#3}{\icon\ #2}}
    }
    \hspace{-8pt}
}

% Set up pagestyle
\pagestyle{default}
\AtEndDocument{\thispagestyle{lastpage}}
