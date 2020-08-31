/**
 * @file
 * Contains an implementation of the countOnes function.
 */

unsigned countOnes(unsigned input) {
	// // TODO: write your code here

unsigned output = (input & 0x55555555) + ((input & 0xaaaaaaaa) >> 1);

output = (output & 0x33333333) + ((output & 0xcccccccc) >> 2);
output = (output & 0x0f0f0f0f) + ((output & 0xf0f0f0f0) >> 4);
output = (output & 0x00ff00ff) + ((output & 0xff00ff00) >> 8);
output = (output & 0x0000ffff) + ((output & 0xffff0000) >> 16);
return output;
}
