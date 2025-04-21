local fig = s(
	{ trig = "fig", snippetType = "snippet", dscr = "A basic figure environment" },
	fmta(
		[[
        \begin{figure}
        \centering
        \includegraphics[width=<>\textwidth]{<>}
        \caption{
            \textbf{<>}
            <>
            }
        \label{fig:<>}
        \end{figure}

        ]],
		{ i(1, "scaling"), i(2, "filename"), i(3, "captionBold"), i(4, "captionText"), i(5, "figureLabel") }
	)
)
local sfig4 = s(
	{ trig = "sfig4", snippetType = "snippet", dscr = "A basic subfigure environment" },
	fmta(
		[[
		\begin{figure}[H]
			\centering
			\begin{subfigure}{0.5\textwidth}
				\includegraphics[width=\textwidth]{<>}
				\caption{<>}
				\label{sfig:<>}
			\end{subfigure}%
			~
			\begin{subfigure}{0.5\textwidth}
				\includegraphics[width=\textwidth]{<>}
				\caption{<>}
				\label{sfig:<>}
			\end{subfigure}\\
			\begin{subfigure}{0.5\textwidth}
				\includegraphics[width=\textwidth]{<>}
				\caption{<>}
				\label{sfig:<>}
			\end{subfigure}%
			~
			\begin{subfigure}{0.5\textwidth}
				\includegraphics[width=\textwidth]{<>}
				\caption{<>}
				\label{sfig:<>}
			\end{subfigure}
			\caption{\textbf{<>}
				<>
			}
			\label{fig:<>}
		\end{figure}
                ]],
		{
			i(1, "filename1"),
			i(2, "subcaption1"),
			i(3, "sublabel1"),
			i(4, "filename2"),
			i(5, "subcaption2"),
			i(6, "sublabel2"),
			i(7, "filename3"),
			i(8, "subcaption3"),
			i(9, "sublabel3"),
			i(10, "filename4"),
			i(11, "subcaption4"),
			i(12, "sublabel4"),
			i(13, "captionBold"),
			i(14, "captionText"),
			i(15, "figureLabel"),
		}
	)
)
local sfig = s(
	{ trig = "sfig", snippetType = "snippet", dscr = "A basic subfigure environment" },
	fmta(
		[[
		\begin{figure}[H]
			\centering
			\begin{subfigure}{0.5\textwidth}
				\includegraphics[width=\textwidth]{<>}
				\caption{<>}
				\label{sfig:<>}
			\end{subfigure}%
			~
			\begin{subfigure}{0.5\textwidth}
				\includegraphics[width=\textwidth]{<>}
				\caption{<>}
				\label{sfig:<>}
			\end{subfigure}
			\caption{\textbf{<>}
				<>
				}
			\label{fig:<>}
		\end{figure}
                ]],
		{
			i(1, "filename1"),
			i(2, "subcaption1"),
			i(3, "sublabel1"),
			i(4, "filename2"),
			i(5, "subcaption2"),
			i(6, "sublabel2"),
			i(7, "captionBold"),
			i(8, "captionText"),
			i(9, "figureLabel"),
		}
	)
)

return {
	fig,
	sfig,
	sfig4,
}
