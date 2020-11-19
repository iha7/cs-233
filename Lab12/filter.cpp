// #include <stdio.h>
// #include <stdlib.h>
// #include "filter.h"

// void filter(pixel_t **image1, pixel_t **image2) {
//     for (int i = 1; i < SIZE - 1; i ++) {
//         filter1(image1, image2, i);
//     }

//     for (int i = 2; i < SIZE - 2; i ++) {
//         filter2(image1, image2, i);
//     }

//     for (int i = 1; i < SIZE - 5; i ++) {
//         filter3(image2, i);
//     }
// }

#include "filter.h"
int min(int, int);

void filter(pixel_t **image1, pixel_t **image2) {
    for (int i = 1; i < SIZE; i ++) {
        __builtin_prefetch(&image1[i + 20]->r);

        __builtin_prefetch(&image1[i + 20]->x);

        __builtin_prefetch(&image2[i + 20]->x);

        __builtin_prefetch(&image2[i + 20]->r);




        if(i < SIZE - 1){
            
            filter1(image1, image2, i);

        }
        if( i < SIZE - 2 && i > 1 ){

            filter2(image1, image2, i);

        }
        if(i > 5){

            filter3(image2, i - 5);

        }
    }

}