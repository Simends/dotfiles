/*
   ______        ____  __
  |  _ \ \      / /  \/  |
  | | | \ \ /\ / /| |\/| |
  | |_| |\ V  V / | |  | |
  |____/  \_/\_/  |_|  |_|

 See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int gappx     = 20;       /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 0;        /* 0 means bottom bar */
static const int swallowfloating    = 0;        /* 1 means swallow floating windows by default */
static const int user_bh            = 40;       /* 0 means that dwm will calculate bar height, >= 1 means dwm will user_bh as bar height */
static const int vertpad            = 20;       /* vertical padding of bar */
static const int sidepad            = 20;       /* horizontal padding of bar */
static const char *fonts[]          = { "SourceCodePro-Regular:size=12" };
static const char dmenufont[]       = "monospace:size=12";
static const char col_gray1[]       = "#3b4252";
static const char col_gray2[]       = "#d8dee9";
static const char col_cyan[]        = "#5e81ac";
static const char col_yellow[]      = "#ebcb8b";
static const char col_green[]       = "#a3be8c";
static const char col_purple[]      = "#b48ead";
static const char col_red[]         = "#bf616a";
static const char *colors[][3]      = {
	/*               fg          bg          border     */
	[SchemeNorm] = { col_gray2,  col_gray1,  col_gray1  },
	[SchemeSel]  = { col_cyan,   col_gray1,  col_gray1  },
	[SchemeUpd]  = { col_yellow, col_gray1,  col_gray1  },
	[SchemeMem]  = { col_green,  col_gray1,  col_gray1  },
	[SchemeDte]  = { col_purple, col_gray1,  col_gray1  },
	[SchemeTmp]  = { col_red,    col_gray1,  col_gray1  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
    /* class     instance  title           tags mask  isfloating  isterminal  noswallow  monitor */
	{ "Gimp",    NULL,     NULL,           0,         1,          0,           0,        -1 },
	{ "Firefox", NULL,     NULL,           1 << 8,    0,          0,          -1,        -1 },
	{ "St",      NULL,     NULL,           0,         0,          1,           0,        -1 },
	{ NULL,      NULL,     "Event Tester", 0,         0,          0,           1,        -1 }, /* xev */
};

/* layout(s) */
static const float mfact     = 0.6; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

#include "fibonacci.c"
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "|||",      col },
	{ "[@]",      spiral },
	{ "[\\]",     dwindle },
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
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, NULL };
static const char *termcmd[]  = { "st", NULL };
static const char *browser[]  = { "firefox", NULL };
static const char *explorer[] = { "nemo", NULL };
static const char *lock[]     = { "/home/simen/.local/bin/lock.sh", NULL };
static const char *menu[]     = { "/home/simen/.local/src/xmenu/xmenu.sh", NULL };
static const char *clipboard[]= { "clipmenu", NULL };
static const char *editor[]   = { "emacs", NULL };

#include "movestack.c"
#include <X11/XF86keysym.h>
static Key keys[] = {
	/* modifier                     key                 function        argument */
	{ MODKEY,                       XK_r,               spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_w,               spawn,          {.v = browser } },
	{ MODKEY,                       XK_e,               spawn,          {.v = explorer } },
	{ MODKEY|ShiftMask,             XK_e,               spawn,          {.v = editor } },
	{ MODKEY,                       XK_o,               spawn,          {.v = lock } },
	{ MODKEY|ShiftMask,             XK_Return,          spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,               spawn,          {.v = clipboard } },
	{ MODKEY,                       XK_p,               spawn,          SHCMD("/home/simen/.local/bin/lpassmenu.sh") },
	{ MODKEY,                       XK_x,               spawn,          SHCMD("xkill") },
	{ MODKEY,                       XK_z,               spawn,          SHCMD("/home/simen/.local/bin/powermenu.sh") },
	{ 0,                            XK_Print,           spawn,          SHCMD("scrot -m -e 'mv $f /home/simen/Multimedia/Pictures/Screenshots/'") },
	{ MODKEY,                       XK_Print,           spawn,          SHCMD("/home/simen/.local/bin/screenshot.sh") },
	{ 0,                            XF86XK_AudioPlay,   spawn,          SHCMD("playerctl play-pause") },
	{ 0,                            XF86XK_AudioStop,   spawn,          SHCMD("playerctl stop") },
	{ 0,                            XF86XK_AudioPrev,   spawn,          SHCMD("playerctl previous") },
	{ 0,                            XF86XK_AudioNext,   spawn,          SHCMD("playerctl next") },
	{ MODKEY|ShiftMask,             XK_b,               togglebar,      {0} },
	{ MODKEY,                       XK_j,               focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,               focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,               incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,               incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,               setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,               setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_j,               movestack,      {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,               movestack,      {.i = -1 } },
	{ MODKEY,                       XK_Return,          zoom,           {0} },
	{ MODKEY,                       XK_Tab,             view,           {0} },
	{ MODKEY,             		    XK_q,               killclient,     {0} },
	{ MODKEY,                       XK_t,               setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,               setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,               setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_c,               setlayout,      {.v = &layouts[3]} },
	{ MODKEY,                       XK_n,               setlayout,      {.v = &layouts[4]} },
	{ MODKEY|ShiftMask,             XK_n,               setlayout,      {.v = &layouts[5]} },
	{ MODKEY,                       XK_space,           setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,           togglefloating, {0} },
	{ MODKEY,                       XK_0,               view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,               tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,           focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period,          focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,           tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period,          tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_minus,           setgaps,        {.i = -1 } },
	{ MODKEY,                       XK_plus,            setgaps,        {.i = +1 } },
	{ MODKEY,                       XK_equal,           setgaps,        {.i = 0  } },
	TAGKEYS(                        XK_1,                               0)
	TAGKEYS(                        XK_2,                               1)
	TAGKEYS(                        XK_3,                               2)
	TAGKEYS(                        XK_4,                               3)
	TAGKEYS(                        XK_5,                               4)
	TAGKEYS(                        XK_6,                               5)
	TAGKEYS(                        XK_7,                               6)
	TAGKEYS(                        XK_8,                               7)
	TAGKEYS(                        XK_9,                               8)
	{ MODKEY|ShiftMask,             XK_q,               quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkRootWin,           0,              Button3,        spawn,          {.v = menu } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

