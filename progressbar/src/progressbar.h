#ifndef __PROGRESSBAR_H
#define __PROGRESSBAR_H

/**
 * Prepares tty screen for progress bar.
 */
void progressbar_start(void);

/**
 * Renders progress bar.
 * @progress: a progress value (0 - 100)
 */
void progressbar_step(float progress);

/**
 * Removes progress bar and restores original tty screen size.
 */
void progressbar_stop(void);

#endif /* __PROGRESSBAR_H */

