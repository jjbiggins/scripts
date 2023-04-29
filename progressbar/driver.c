#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <time.h>
#include <sys/ioctl.h>
#include <progressbar.h>


#define ROUNDS 150
#define STRINGS_COUNT 10


static const char *strings[] = {
    "Lorem ipsum dolor sit amet",
    "Consectetur adipiscing elit",
    "Vivamus faucibus sagittis dui, tincidunt rhoncus mi",
    "Fringilla sollicitudin. Donec eget sagittis",
    "Quam, vitae fringilla nisl",
    "Donec dolor justo, hendrerit sed accumsan id, sodales",
    "Eu odio",
    "Nunc vehicula hendrerit risus, vel condimentum dui rutrum sed.",
    "Quisque metus enim, pellentesque nec nibh sit amet.",
    "Commodo molestie diam."
};


int main ( int argc, char **argv ) {
    
    int r;

    progressbar_start();
    srand(time(NULL));

    for ( int i = 0; i <= ROUNDS; i++ ) {
	r = rand() % STRINGS_COUNT;
	fprintf(stdout, "%s...\n", strings[r]);
	progressbar_step(((float)(i / ROUNDS)) * 100);
        usleep(50 * 1000);
    }

    sleep(1);
    progressbar_stop();

    return EXIT_SUCCESS;
}




