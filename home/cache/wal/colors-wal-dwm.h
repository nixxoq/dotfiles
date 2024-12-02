static const char norm_fg[] = "#bec5c9";
static const char norm_bg[] = "#0a0a0c";
static const char norm_border[] = "#85898c";

static const char sel_fg[] = "#bec5c9";
static const char sel_bg[] = "#8B755C";
static const char sel_border[] = "#bec5c9";

static const char urg_fg[] = "#bec5c9";
static const char urg_bg[] = "#576061";
static const char urg_border[] = "#576061";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
