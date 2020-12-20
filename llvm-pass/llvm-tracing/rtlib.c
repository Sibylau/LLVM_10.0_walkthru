#include <stdio.h>

void logout(int i) {
    printf("condition: %i\n", i);
    FILE *fp;
    fp = fopen("trace.txt", "a");
    fprintf(fp, "%i, ", i);
    fclose(fp);
}