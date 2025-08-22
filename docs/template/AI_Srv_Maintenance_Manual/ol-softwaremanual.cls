\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ol-softwaremanual}[2021/05/17 v1.1 Overleaf Software Manual Template]
% sample software documentation format
% load the base class with default options
\LoadClass[12pt,a4paper]{article}

% set default smaller margins, separated paragraphs, bigger line spacing
% (fullpage used as fallback if geometry package removed from main preamble)
\RequirePackage{fullpage,parskip}  % fullpage: Reduce page margins.  parskip: Add vertical spacing between paragraphs instead of indentation on the first line
\linespread{1.5}  %Set 1.5 times the line spacing

% use Roboto as the main font
\RequirePackage[utf8]{inputenc}           % Set input encoding to UTF-8
\RequirePackage[T1]{fontenc}              % Use T1 font encoding to support better fonts and characters
\RequirePackage[sfdefault]{roboto}        % Set Roboto as default sans serif font
\RequirePackage[scaled=0.95]{roboto-mono} % Load Roboto Mono equal width font and scale to 0.95 times
\RequirePackage{sfmath}                   % Display mathematical formulas using sans serif fonts

% extra front matter commands
\DeclareRobustCommand*{\softwarelogo}[1]{\gdef\@logocmd{#1}}  % Define the \ softwarelogo command to set the document logo, Parameters are stored in the \ @ logocmd macro
\DeclareRobustCommand*{\version}[1]{\gdef\@ver{Version #1}}   % 

% default values
\gdef\@logocmd{\@latex@warning{No logo command specified for title page. Ignoring.}}  % Set \@logocmd default value (warning when logo is not specified)
\gdef\@ver{\@latex@warning{No version number specified for title page. Ignoring.}}

% modify the stock \maketitle command
% Redefine the \ maketitle command to create a custom title page:
\renewcommand\maketitle{
\begin{titlepage}
\centering
\@logocmd\par
{\huge\bfseries\@title\par}
\bigskip
{\Large\@ver\par}
\vfill
{\Large \@author\par}
\@date
\end{titlepage}
}

% Post processing
\AtEndPreamble{%
% set some hyperref options if it's loaded
% leave loading it to the user so they can get the order right
\@ifpackageloaded{hyperref}{%
\RequirePackage{xcolor}
\providecolor{manuallinkcolor}{HTML}{004a0e}  % Dark green
\hypersetup{colorlinks,allcolors=manuallinkcolor}% All links use defined colors
}{}%
% let minted's listing captions use the correct font
% This command is actually fixing the font inheritance issue in the code manifest (caption) in the minted environment.
% Because the mint package relies on the float package to create a floating body environment, and the default listing environment of the float package has its own independent title handling mechanism. This correction ensures that the font settings of the document can be correctly propagated to the titles of the code list, maintaining overall visual consistency.
% Before correction: The title of the code list may use the default Computer Modern serif font
% Revised: The title of the code list will inherit the Roboto sans serif font set by the document class
\@ifpackageloaded{minted}{\let\@float@c@listing\@caption}{}
}