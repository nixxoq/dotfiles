const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0a0a0c", /* black   */
  [1] = "#576061", /* red     */
  [2] = "#8B755C", /* green   */
  [3] = "#487089", /* yellow  */
  [4] = "#598EA7", /* blue    */
  [5] = "#70B5CB", /* magenta */
  [6] = "#7EC0D4", /* cyan    */
  [7] = "#bec5c9", /* white   */

  /* 8 bright colors */
  [8]  = "#85898c",  /* black   */
  [9]  = "#576061",  /* red     */
  [10] = "#8B755C", /* green   */
  [11] = "#487089", /* yellow  */
  [12] = "#598EA7", /* blue    */
  [13] = "#70B5CB", /* magenta */
  [14] = "#7EC0D4", /* cyan    */
  [15] = "#bec5c9", /* white   */

  /* special colors */
  [256] = "#0a0a0c", /* background */
  [257] = "#bec5c9", /* foreground */
  [258] = "#bec5c9",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
