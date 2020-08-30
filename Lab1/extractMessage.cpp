/**
 * @file
 * Contains an implementation of the extractMessage function.
 */

#include <iostream> // might be useful for debugging
#include <assert.h>
#include "extractMessage.h"

using namespace std;

unsigned char *extractMessage(const unsigned char *message_in, int length) {
    // length must be a multiple of 8
    assert((length % 8) == 0);

    // allocate an array for the output
    unsigned char *message_out = new unsigned char[length];
    for (int i = 0; i < length; i++) {
        message_out[i] = 0;
    }

    // TODO: write your code here

    for (int group = 0; group < length; group = group + 8) {
       for (int index = 0; index < 8; index++) {
            for (int set = 0; set < 8; set++) {
               message_out[group + index] = 
               message_out[group + index] |
               (((message_in[group + set] >> index) & 0x1) << set);
            }
        }
    }
    return message_out;
}
