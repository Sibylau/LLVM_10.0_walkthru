// #include <stdio.h>
// int main(int argc, const char** argv) {
//     int i = 0;
//     int s = 0;
//     int a[8] = {0};
//     while (i < 4) {
//         a[s] = a[s] + 2;
//         i += 1;
//         s = 2 * i;
//     }
//     return 0;
// }

void loop() {
    int a[8] = {0};
    for (int i = 1; i < 4; i++) {
        int s = 2 * i - 1;
        a[s] = a[s] + 2;
    }
}

// void loop() {
//     int a[8] = {0};
//     int i = 0;
//     while (2*i + 1 < 9) {
//         int s = 2 * i;
//         a[s] = a[s] + 2;
//         i += 2;
//     }
// }

// void loop() {
//     int a[8] = {0};
//     int i = 1;
//     for (i = 1; 2*i + 1 < 10; i+=2) {
//         int s = 2 * i - 1;
//         a[s] = a[s] + 2;
//     }
// }
