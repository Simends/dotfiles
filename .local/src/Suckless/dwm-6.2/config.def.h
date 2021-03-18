/*
   ______        ____  __
  |  _ \ \      / /  \/  |
  | | | \ \ /\ / /| |\/| |
  | |_| |\ V  V / | |  | |
  |____/  \_/\_/  |_|  |_|

 See LICENSE file for copyright and license details. */

/* appearance */
static unsigned int borderpx = 10; /* border pixel of windows */
static unsigned int snap     = 32;    /* snap pixel */
static const int swallowfloating   = 0; /* 1 means swallow floating windows by default */
static const unsigned int gappih   = 20; /* horiz inner gap between windows */
static const unsigned int gappiv   = 20; /* vert inner gap between windows */
static const unsigned int gappoh   = 20; /* horiz outer gap between windows and screen edge */
static const unsigned int gappov   = 20; /* vert outer gap between windows and screen edge */
static int smartgaps               = 0; /* 1 means no outer gap when there is only one window */
static int showbar           = 1;  /* 0 means no bar */
static int topbar            = 0;   /* 0 means bottom bar */
static const int user_bh           = 40; /* 0 means dwm will calculate bar height */
static const int vertpad           = 20; /* vertical padding of bar */
static const int sidepad           = 20;  /* horizontal padding of bar */
static const char *fonts[]         = {"SourceCodePro-Regular:size=12", "fontawesome:size=11"};
static char background[]      = "#1d3557";
static char foreground[]      = "#f1faee";
static char selbackground[]      = "#f1faee";
static char selforeground[]      = "#f1faee";
static char color6[]       = "#a8dadc"; /* Cyan */
static char color5[]     = "#4e657e"; /* Magenta */
static char color4[]     = "#4e657e"; /* Blue */
static char color3[]     = "#4e657e"; /* Yellow */
static char color2[]     = "#4e657e"; /* Green */
static char color1[]        = "#e63946"; /* Red */
static char *colors[][3]     = {
    /*               fg          bg          border     */
    [SchemeNorm] = {foreground, background, background},
    [SchemeSel] = {selforeground, selbackground, selforeground},
    [SchemeUpd] = {color4, background, background},
    [SchemeMem] = {color3, background, background},
    [SchemeDte] = {color5, background, background},
    [SchemeTmp] = {color1, background, background},
    [SchemeCna] = {color2, background, background},
};

/* staticstatus */
static const int statmonval = 0;

/* tagging, icons: https://fontawesome.com/v4.7.0/cheatsheet/ */
/*static const char *tags[] = { "", "", "", "", "", "", "", "", "" };*/
static const char *tags[] = {"", "", "", "", "", "", "", "", ""};
static const char *tagsalt[] = {"1", "2", "3", "4", "5", "6", "7", "8", "9"};

static const Rule rules[] = {
    /* xprop(1):
     *	WM_CLASS(STRING) = instance, class
     *	WM_NAME(STRING) = title
     */
    /* class         instance  title           tags mask  isfloating  isterminal
       noswallow  monitor */
    {"Gimp", NULL, NULL, 0, 1, 0, 0, -1},
    {"Firefox", NULL, NULL, 1 << 8, 0, 0, -1, -1},
    {"St", NULL, NULL, 0, 0, 1, 0, -1},
    {"kitty", NULL, NULL, 0, 0, 1, 0, -1},
    {"lxsession", NULL, NULL, 0, 1, 0, -1, -1},
    {NULL, NULL, "Event Tester", 0, 0, 0, 1, -1}, /* xev */
};

/* layout(s) */
static float mfact = 0.6; /* factor of master area size [0.05..0.95] */
static int nmaster = 1;   /* number of clients in master area */
static int resizehints = 1; /* 1 means respect size hints in tiled resizals */

#define FORCE_VSPLIT                                                           \
  1 /* nrowgrid layout: force two clients to always split vertically */
#include "vanitygaps.c"

static const Layout layouts[] = {
    /* symbol     arrange function */
    {"[]=", tile}, /* first entry is default */
    {"[M]", monocle},
    {"[@]", spiral},
    {"[\\]", dwindle},
    {"H[]", deck},
    {"TTT", bstack},
    {"===", bstackhoriz},
    {"HHH", grid},
    {"###", nrowgrid},
    {"---", horizgrid},
    {":::", gaplessgrid},
    {"|M|", centeredmaster},
    {">M>", centeredfloatingmaster},
    {"><>", NULL}, /* no layout function means floating behavior */
    {NULL, NULL},
};

/*
 * Xresources preferences to load at startup
 */
ResourcePref resources[] = {
		{ "background",        STRING,  &background },
		{ "foreground",    STRING,  &foreground },
		{ "selbackground",    STRING,  &selbackground },
		{ "selforeground",    STRING,  &selforeground },
		{ "color1",        STRING,  &color1 },
		{ "color2",         STRING,  &color2 },
		{ "color3",     STRING,  &color3 },
		{ "color4",         STRING,  &color4 },
		{ "color5",         STRING,  &color5 },
		{ "color6",         STRING,  &color6 },
		{ "borderpx",          	INTEGER, &borderpx },
		{ "snap",          		INTEGER, &snap },
		{ "showbar",          	INTEGER, &showbar },
		{ "topbar",          	INTEGER, &topbar },
		{ "nmaster",          	INTEGER, &nmaster },
		{ "resizehints",       	INTEGER, &resizehints },
		{ "mfact",      	 	FLOAT,   &mfact },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY, TAG)                                                      \
  {MODKEY, KEY, view, {.ui = 1 << TAG}},                                       \
      {MODKEY | ControlMask, KEY, toggleview, {.ui = 1 << TAG}},               \
      {MODKEY | ShiftMask, KEY, tag, {.ui = 1 << TAG}},                        \
      {MODKEY | ControlMask | ShiftMask, KEY, toggletag, {.ui = 1 << TAG}},

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd)                                                             \
  {                                                                            \
    .v = (const char *[]) { "/bin/sh", "-c", cmd, NULL }                       \
  }

/* commands */
static char dmenumon[2] =
    "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = {"dmenu_run", "-m", dmenumon, NULL};
static const char *termcmd[] = {"st", NULL};
static const char *browser[] = {"firefox", NULL};
static const char *lock[] = {"slock", NULL};
static const char *layoutmenu_cmd = "layoutmenu.sh";

#include <X11/XF86keysym.h>
static Key keys[] = {
    /* modifier                     key                  function             argument */
    {MODKEY,                        XK_r,                spawn,               {.v = dmenucmd}},
    {Mod1Mask,                      XK_space,            spawn,               {.v = dmenucmd}},
    {MODKEY,                        XK_w,                spawn,               {.v = browser}},
    {MODKEY|ShiftMask,              XK_w,                spawn,               SHCMD("searchmenu.sh")},
    {MODKEY,                        XK_e,                spawn,               SHCMD("nautilus")},
    {MODKEY | ShiftMask,            XK_e,                spawn,               SHCMD("emacsclient -c")},
    {MODKEY,                        XK_o,                spawn,               {.v = lock}},
    {MODKEY | ShiftMask,            XK_Return,           spawn,               {.v = termcmd}},
    {MODKEY,                        XK_v,                spawn,               SHCMD("clipmenu")},
    {MODKEY | ShiftMask,            XK_c,                spawn,               SHCMD("guicalc.sh")},
    {MODKEY,                        XK_p,                spawn,               SHCMD("passmenu -l 20")},
    {MODKEY,                        XK_x,                spawn,               SHCMD("xkill")},
    {MODKEY,                        XK_z,                spawn,               SHCMD("powermenu.sh")},
    {0,                             XK_Print,            spawn,               SHCMD("scrot -m -e 'mv $f /home/simen/Multimedia/Pictures/Screenshots/' && notify-send 'Screenshot taken' 'Saved in ~/Multimedia/Pictures/Screenshots'")},
    {MODKEY,                        XK_Print,            spawn,               SHCMD("screenshot.sh")},
    {0,                             XF86XK_AudioPlay,    spawn,               SHCMD("playerctl play-pause || mocp -O MOCDir=/home/sig/moc --toggle-pause")},
    {0,                             XF86XK_AudioStop,    spawn,               SHCMD("playerctl stop || mocp -O MOCDir=/home/simen/.config/moc -x")},
    {0,                             XF86XK_AudioPrev,    spawn,               SHCMD("playerctl previous || mocp -O MOCDir=/home/simen/.config/moc --previous")},
    {0,                             XF86XK_AudioNext,    spawn,               SHCMD("playerctl next || mocp -O MOCDir=/home/simen/.config/moc --next")},
    {0,                             XF86XK_AudioMute,    spawn,               SHCMD("pulsemixer --toggle-mute && notify-send Mute 'Toggled mute'")},
    {MODKEY,                        XK_F1,               spawn,               SHCMD("playerctl play-pause || mocp -O MOCDir=/home/simen/.config/moc --toggle-pause")},
    {MODKEY,                        XK_F2,               spawn,               SHCMD("playerctl stop || mocp -O MOCDir=/home/simen/.config/moc -x")},
    {MODKEY,                        XK_F3,               spawn,               SHCMD("playerctl previous || mocp -O MOCDir=/home/simen/.config/moc --previous")},
    {MODKEY,                        XK_F4,               spawn,               SHCMD("playerctl next || mocp -O MOCDir=/home/simen/.config/moc --next")},
    {0,                             XF86XK_Calculator,   spawn,               SHCMD("gnome-calculator")},
    {MODKEY,                        XK_b,                togglebar,           {0}},
    {MODKEY | ShiftMask,            XK_j,                rotatestack,         {.i = +1}},
    {MODKEY | ShiftMask,            XK_k,                rotatestack,         {.i = -1}},
    {MODKEY,                        XK_j,                focusstack,          {.i = +1}},
    {MODKEY,                        XK_k,                focusstack,          {.i = -1}},
    {MODKEY,                        XK_i,                incnmaster,          {.i = +1}},
    {MODKEY,                        XK_d,                incnmaster,          {.i = -1}},
    {MODKEY,                        XK_h,                setmfact,            {.f = -0.05}},
    {MODKEY,                        XK_l,                setmfact,            {.f = +0.05}},
    {MODKEY | ShiftMask,            XK_h,                setcfact,            {.f = +0.25}},
    {MODKEY | ShiftMask,            XK_l,                setcfact,            {.f = -0.25}},
    {MODKEY | ShiftMask,            XK_o,                setcfact,            {.f = 0.00}},
    {MODKEY,                        XK_Return,           zoom,                {0}},
    {MODKEY,                        XK_y,                incrgaps,            {.i = +5}},
    {MODKEY,                        XK_u,                incrgaps,            {.i = -5}},
    {MODKEY | ShiftMask,            XK_y,                incrigaps,           {.i = +5}},
    {MODKEY | ShiftMask,            XK_u,                incrigaps,           {.i = -5}},
    {MODKEY | ShiftMask,            XK_i,                incrogaps,           {.i = +5}},
    {MODKEY | ShiftMask,            XK_t,                incrogaps,           {.i = -5}},
    {MODKEY | Mod1Mask,             XK_y,                incrihgaps,          {.i = +5}},
    {MODKEY | Mod1Mask,             XK_u,                incrihgaps,          {.i = -5}},
    {MODKEY | ControlMask,          XK_y,                incrivgaps,          {.i = +5}},
    {MODKEY | ControlMask,          XK_u,                incrivgaps,          {.i = -5}},
    {MODKEY | Mod1Mask,             XK_i,                incrohgaps,          {.i = +5}},
    {MODKEY | Mod1Mask,             XK_t,                incrohgaps,          {.i = -5}},
    {MODKEY | ControlMask,          XK_i,                incrovgaps,          {.i = +5}},
    {MODKEY | ControlMask,          XK_t,                incrovgaps,          {.i = -5}},
    {MODKEY,                        XK_m,                togglegaps,          {0}},
    {MODKEY,                        XK_n,                defaultgaps,         {0}},
    {MODKEY,                        XK_Tab,              view,                {0}},
    {MODKEY,                        XK_q,                killclient,          {0}},
    {MODKEY,                        XK_t,                setlayout,           {.v = &layouts[0]}},
    {MODKEY,                        XK_f,                setlayout,           {.v = &layouts[13]}},
    {MODKEY,                        XK_space,            setlayout,           {0}},
    {MODKEY | ShiftMask,            XK_space,            togglefloating,      {0}},
    {MODKEY,                        XK_0,                view,                {.ui = ~0}},
    {MODKEY | ShiftMask,            XK_0,                tag,                 {.ui = ~0}},
    {MODKEY,                        XK_comma,            focusmon,            {.i = -1}},
    {MODKEY,                        XK_period,           focusmon,            {.i = +1}},
    {MODKEY | ControlMask,          XK_comma,            cyclelayout,         {.i = -1}},
    {MODKEY | ControlMask,          XK_period,           cyclelayout,         {.i = +1}},
    {MODKEY | ShiftMask,            XK_comma,            tagmon,              {.i = -1}},
    {MODKEY | ShiftMask,            XK_period,           tagmon,              {.i = +1}},
    {MODKEY,                        XK_a,                togglealttag,        {0}},
    {MODKEY | ShiftMask,            XK_plus,             spawn,               SHCMD("zathura -P 1 /home/simen/.local/src/keybindings/keybindings.pdf")},
	{ MODKEY,                       XK_Down,             moveresize,          {.v = "0x 25y 0w 0h" } },
	{ MODKEY,                       XK_Up,               moveresize,          {.v = "0x -25y 0w 0h" } },
	{ MODKEY,                       XK_Right,            moveresize,          {.v = "25x 0y 0w 0h" } },
	{ MODKEY,                       XK_Left,             moveresize,          {.v = "-25x 0y 0w 0h" } },
	{ MODKEY|ShiftMask,             XK_Down,             moveresize,          {.v = "0x 0y 0w 25h" } },
	{ MODKEY|ShiftMask,             XK_Up,               moveresize,          {.v = "0x 0y 0w -25h" } },
	{ MODKEY|ShiftMask,             XK_Right,            moveresize,          {.v = "0x 0y 25w 0h" } },
	{ MODKEY|ShiftMask,             XK_Left,             moveresize,          {.v = "0x 0y -25w 0h" } },
	{ MODKEY|ControlMask,           XK_Up,               moveresizeedge,      {.v = "t"} },
	{ MODKEY|ControlMask,           XK_Down,             moveresizeedge,      {.v = "b"} },
	{ MODKEY|ControlMask,           XK_Left,             moveresizeedge,      {.v = "l"} },
	{ MODKEY|ControlMask,           XK_Right,            moveresizeedge,      {.v = "r"} },
	{ MODKEY|ControlMask|ShiftMask, XK_Up,               moveresizeedge,      {.v = "T"} },
	{ MODKEY|ControlMask|ShiftMask, XK_Down,             moveresizeedge,      {.v = "B"} },
	{ MODKEY|ControlMask|ShiftMask, XK_Left,             moveresizeedge,      {.v = "L"} },
	{ MODKEY|ControlMask|ShiftMask, XK_Right,            moveresizeedge,      {.v = "R"} },
    TAGKEYS(XK_1, 0)
    TAGKEYS(XK_2, 1)
    TAGKEYS(XK_3, 2)
    TAGKEYS(XK_4, 3)
    TAGKEYS(XK_5, 4)
    TAGKEYS(XK_6, 5)
    TAGKEYS(XK_7, 6)
    TAGKEYS(XK_8, 7)
    TAGKEYS(XK_9, 8)
    {MODKEY | ShiftMask,            XK_q,                quit,                {0}},
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle,
 * ClkClientWin, or ClkRootWin */
static Button buttons[] = {
    /* click                event mask      button          function argument
     */
    {ClkLtSymbol, 0, Button1, setlayout, {0}},
    {ClkLtSymbol, 0, Button3, layoutmenu, {0}},
    {ClkWinTitle, 0, Button2, zoom, {0}},
    {ClkStatusText, 0, Button1, spawn, SHCMD("statuscmd.sh")},
    {ClkStatusText, 0, Button3, spawn, SHCMD("statusmenu.sh")},
    {ClkRootWin, 0, Button3, spawn, SHCMD("xmenu.sh")},
    {ClkClientWin, MODKEY, Button1, movemouse, {0}},
    {ClkClientWin, MODKEY, Button2, togglefloating, {0}},
    {ClkClientWin, MODKEY, Button3, resizemouse, {0}},
    {ClkTagBar, 0, Button1, view, {0}},
    {ClkTagBar, 0, Button3, toggleview, {0}},
    {ClkTagBar, MODKEY, Button1, tag, {0}},
    {ClkTagBar, MODKEY, Button3, toggletag, {0}},
};
