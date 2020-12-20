#include <stdio.h>

void print(int i) {
    printf("condition: %i\n", i);
    FILE *fp;
    fp = fopen("trace.txt", "a");
    fprintf(fp, "%i, ", i);
    fclose(fp);
}