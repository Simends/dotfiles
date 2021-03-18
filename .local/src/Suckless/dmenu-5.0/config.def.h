/*
   ____
  |  _ \ _ __ ___   ___ _ __  _   _
  | | | | '_ ` _ \ / _ \ '_ \| | | |
  | |_| | | | | | |  __/ | | | |_| |
  |____/|_| |_| |_|\___|_| |_|\__,_|

 See LICENSE file for copyright and license details. */

/* Default settings; can be overriden by command line. */
static int instant = 1;
static int topbar = 0;                      /* -b  option; if 0, dmenu appears at bottom     */
static int fuzzy = 1;                       /* -F option; if 0, dmenu dosen't use fuzzy matching */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"SourceCodePro-Regular:size=12"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
/*                     fg         bg       */
	[SchemeNorm] = { "#f1faee", "#1d3557" },
	[SchemeSel] = { "#a8dadc", "#1d3557" },
	[SchemeOut] = { "#1d3557", "#f1faee" },
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 0;
/* -h option; minimum height of a menu line */
static unsigned int lineheight = 40;
static unsigned int min_lineheight = 40;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";
