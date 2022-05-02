/* See LICENSE file for copyright and license details. */

#include <X11/XF86keysym.h>

/* appearance */
#define MAINFONT  "Hermit:pixelsize=10:style=Regular"
/* #define MAINFONT  "Terminus:pixelsize=14:style=Regular" */

static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const int startwithgaps[]    = { 1 };	/* 1 means gaps are used by default, this can be customized for each tag */
static const unsigned int gappx[]   = { 10 };   /* default gap between windows in pixels, this can be customized for each tag */
static const unsigned int snap      = 8;       /* snap pixel */
static const int swallowfloating    = 0;        /* 1 means swallow floating windows by default */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int focusonwheel       = 0;
static const char *fonts[]          = { MAINFONT, "FontAwesome:style=Regular:size=10" };
static const char dmenufont[]       = MAINFONT;
static char normbgcolor[]           = "#222222";
static char normbordercolor[]       = "#444444";
static char normfgcolor[]           = "#bbbbbb";
static char selfgcolor[]            = "#eeeeee";
static char selbordercolor[]        = "#005577";
static char selbgcolor[]            = "#005577";
static char *colors[][3] = {
       /*               fg           bg           border   */
       [SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
       [SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class                        instance  title           tags mask  isfloating  isterminal   swallow   monitor */
	{ "Gimp",                       NULL,     NULL,           0,         1,          0,           1,        -1 },
	{ "Firefox",                    NULL,     NULL,           1 << 8,    0,          0,           1,        -1 },
	{ "Picture-in-Picture",         NULL,     NULL,           0,         1,          0,           0,        -1 },
	{ "St",                         NULL,     NULL,           0,         0,          1,           1,        -1 },
	{ NULL,                         NULL,     "Event Tester", 0,         0,          0,           0,        -1 }, /* xev */
	{ "Display",                    NULL,     NULL,	          0,         1,          0,           0,        -1 },
	{ "Trayer",                     NULL,     NULL,	          0,         1,          0,           0,        -1 },
	{ "Sxiv",                       NULL,     NULL,           0,         0,          0,           1,        -1 },
	{ "Zathura",                    NULL,     NULL,           0,         0,          0,           1,        -1 },
	{ "Pcmanfm",                    NULL,     NULL,           0,         0,          0,           1,        -1 },
	{ "mpv",                        NULL,     NULL,           0,         0,          0,           1,        -1 },
	{ "qutebrowser",                NULL,     NULL,           0,         0,          0,           1,        -1 },
};

/* layout(s) */
static const float mfact     = 0.75; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 2;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

/* mouse scroll resize */
static const int scrollsensetivity = 60; /* 1 means resize window by 1 pixel for each scroll event */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "||=",      col },     /* first entry is default */
	{ "[]=",      tile },
	{ "><>",      NULL },    /* no layout function means floating behavior */
  { "###",      gaplessgrid },
  { "LLL",      tstack },
	{ "TTT",      bstack },
	{ "===",      bstackhoriz },
	{ "[M]",      monocle },
	{ "[]D",      deck },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *termcmd[]  = { "st", NULL };
static const char *layoutmenu_cmd = "dwm-layoutmenu.sh";
static const char *webcmd[]   = { "qutebrowser", NULL };
static const char *tabcreatecmd[]   = { "tabwin.sh", "create", NULL };
static const char *tabaddcmd[]   = { "tabwin.sh", "add", NULL };
static const char *filescmd[] = { "pcmanfm", NULL };
static const char *dmenucmd[] = { "menu.sh",  "-m", dmenumon, "-fn", dmenufont,
    "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor,
    "-nhb", normbgcolor, "-nhf", selbgcolor, "-shb", selbgcolor, "-shf", normbgcolor,
    NULL };
static const char *clipmenucmd[] = { "clipmenu",  "-m", dmenumon, "-fn", dmenufont,
    "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor,
    "-nhb", normbgcolor, "-nhf", selbgcolor, "-shb", selbgcolor, "-shf", normbgcolor,
    NULL };

static Key keys[] = {
	/* modifier                     key        	    function        argument */
	{ MODKEY,                       XK_space,  	    spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, 	    spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_w,  	   	    spawn,          {.v = webcmd } },
	{ MODKEY,                       XK_b,      	    togglebar,      {0} },
	{ MODKEY,                       XK_n,      	    setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_o,      	    setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_e,      	    focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_i,      	    focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_n,      	    incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_o,      	    incnmaster,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_i,      	    layoutscroll,   {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_e,      	    layoutscroll,   {.i = +1 } },
  { MODKEY,             		      XK_r,      	    resetlayout,    {0} },
	{ MODKEY,                       XK_Return, 	    zoom,           {0} },
	{ MODKEY|ControlMask,           XK_Return, 	    focusmaster,    {0} },
	{ MODKEY,                       XK_Tab,    	    view,           {0} },
	{ MODKEY,                       XK_Escape, 	    spawn,          SHCMD("slock") },
	{ MODKEY,                       XK_BackSpace, 	spawn,          SHCMD("dunstctl close") },
	{ MODKEY|ShiftMask,             XK_BackSpace, 	spawn,          SHCMD("dunstctl close-all") },
	{ MODKEY|ControlMask,           XK_x, 	        spawn,          SHCMD("xkill") },
	{ MODKEY|ShiftMask,             XK_Tab, 	      spawn,          {.v = tabcreatecmd } },
	{ MODKEY|ControlMask,           XK_Tab, 	      spawn,          {.v = tabaddcmd } },
	{ MODKEY,                       XK_v, 	        spawn,          {.v = clipmenucmd } },
	{ MODKEY,             		      XK_q,      	    killclient,     {0} },
	{ MODKEY,                       XK_t,      	    setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      	    setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_m,      	    setlayout,      {.v = &layouts[5]} },
	{ MODKEY|ShiftMask,             XK_f,  	   	    togglefloating, {0} },
	{ MODKEY,                       XK_0,      	    view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      	    tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_g,           winview,        {0} },
  { MODKEY,                       XK_u,           focusurgent,    {0} },
	{ MODKEY,                       XK_comma,  	    focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, 	    focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  	    tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, 	    tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_F1, 		      spawn,          SHCMD("playerctl previous") },
	{ MODKEY,                       XK_F2, 		      spawn,          SHCMD("playerctl play-pause") },
	{ MODKEY,                       XK_F3, 		      spawn,          SHCMD("playerctl next") },
	{ MODKEY,                       XK_F5,     	    xrdb,           {.v = NULL } },
	{ MODKEY,             		      XK_F11,      	  togglefullscr,  {0} },
	{ MODKEY,                       XK_minus,  	    setgaps,        {.i = -5 } },
	{ MODKEY,                       XK_plus,   	    setgaps,        {.i = +5 } },
	{ MODKEY|ShiftMask,             XK_minus,  	    setgaps,        {.i = GAP_RESET } },
	{ MODKEY|ShiftMask,             XK_plus,   	    setgaps,        {.i = GAP_TOGGLE} },
  { 0, XF86XK_AudioMute,                          spawn,          SHCMD("amixer -q set Master Playback Volume toggle") },
  { 0, XF86XK_AudioRaiseVolume,                   spawn,          SHCMD("amixer -q set Master Playback Volume 5%+") },
  { 0, XF86XK_AudioLowerVolume,                   spawn,          SHCMD("amixer -q set Master Playback Volume 5%-") },
  { 0, XF86XK_AudioMicMute,                       spawn,          SHCMD("amixer -q set Capture Volume toggle") },
  { 0, XF86XK_MonBrightnessUp,	                  spawn,		      SHCMD("sudo light -A 5") },
	{ 0, XF86XK_MonBrightnessDown,	                spawn,		      SHCMD("sudo light -U 5") },
  { 0, XF86XK_WLAN,                               spawn,          SHCMD("rfkill toggle all") },
	TAGKEYS(                        XK_1,                      	    0)
	TAGKEYS(                        XK_2,                      	    1)
	TAGKEYS(                        XK_3,                      	    2)
	TAGKEYS(                        XK_4,                      	    3)
	TAGKEYS(                        XK_5,                      	    4)
	TAGKEYS(                        XK_6,                      	    5)
	TAGKEYS(                        XK_7,                      	    6)
	TAGKEYS(                        XK_8,                      	    7)
	TAGKEYS(                        XK_9,                      	    8)
	{ MODKEY|ShiftMask,             XK_q,      	    quit,           {0} },
};

/* resizemousescroll direction argument list */
static const int scrollargs[][2] = {
	/* width change         height change */
	{ +scrollsensetivity,	0 },
	{ -scrollsensetivity,	0 },
	{ 0, 				  	+scrollsensetivity },
	{ 0, 					-scrollsensetivity },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        layoutmenu,     {0} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkRootWin,           0,              Button3,        spawn,          SHCMD("xmenu.sh") },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkClientWin,         MODKEY,         Button4,        resizemousescroll, {.v = &scrollargs[0]} },
	{ ClkClientWin,         MODKEY,         Button5,        resizemousescroll, {.v = &scrollargs[1]} },
	{ ClkClientWin,         MODKEY,         Button6,        resizemousescroll, {.v = &scrollargs[2]} },
	{ ClkClientWin,         MODKEY,         Button7,        resizemousescroll, {.v = &scrollargs[3]} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

