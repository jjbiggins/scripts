#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <signal.h>
#include <sys/ioctl.h>

#include <progressbar.h>

static struct winsize w;
static int initialized = 0;


static void progressbar_set_window_height(int height)
{
    fprintf(stdout, "\n\0337"	    // save cursor
			"\033[0;%dr"	    // set scroll region (this will place the cursor in the top left)
			"\0338\033[1A\033[J"	// restore cursor but ensure its inside the scrolling area
			, height);
    fflush(stdout);
}


static void progressbar_init()
{
    ioctl(STDOUT_FILENO, TIOCGWINSZ, &w);
    progressbar_set_window_height(w.ws_row - 1);
}


static void progressbar_abort()
{
    progressbar_stop();
    exit(0);
}


void progressbar_start()
{
    signal(SIGWINCH, progressbar_init);
    signal(SIGINT, progressbar_abort);
    progressbar_init();
    initialized = 1;
    progressbar_step(0);
}


void progressbar_step(float progress)
{
    if (initialized == 0) {
	fprintf(stderr, "error: progressbar_step() called before progressbar_start().\n");
	exit(1);
    }
    char *bar = malloc(w.ws_col);

    if (progress < 0) {
	progress = 0;
    } else if (progress > 100) {
	progress = 100;
    }

    int width = (w.ws_col - 20);
    memset(bar, '.', width);
    memset(bar, '#', (int)(width * (progress / 100)));
    bar[width] = 0;

    fprintf(stdout, "\e[s\e[%d;0H\e[42;30mProgress: [%3d%%]\e[0m [%s]\e[u", w.ws_row + 1, (int) progress, bar);
    fflush(stdout);

    free(bar);
}


void progressbar_stop()
{
    progressbar_set_window_height(w.ws_row);
}

