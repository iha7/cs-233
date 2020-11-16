// #include "transpose.h"
// int min(int, int);

// // modify this function to add tiling
// void transpose_tiled(int **A, int **B) {
//     for (int i = 0; i < SIZE; i ++) {
//         for (int j = 0; j < SIZE; j ++) {
//             B[i][j] = A[j][i];
//         }
//     }
// }



#include "transpose.h"
int min(int, int);
void transpose_tiled(int **A, int **B) {
    int newSize = 32;
    for (int i = 0; i < SIZE; i+= newSize) {
        for (int j = 0; j < SIZE; j=+ newSize) {
            for (int k = i; k < min(i + newSize, SIZE); k++) {
                for (int l = j; l < min (j + newSize, SIZE); l++) {
                    A[k][l] = B[l][k];
                }
            }
        }
    }
}
