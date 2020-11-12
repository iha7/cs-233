// #include "utils.h"

// uint32_t extract_tag(uint32_t address, const CacheConfig& cache_config) {
//   // TODO
//   return 0;
// }

// uint32_t extract_index(uint32_t address, const CacheConfig& cache_config) {
//   // TODO
//   return 0;
// }

// uint32_t extract_block_offset(uint32_t address, const CacheConfig& cache_config) {
//   // TODO
//   return 0;
// }

#include "utils.h"
#include <iostream>
#include <string>
using namespace std;

uint32_t extract_tag(uint32_t address, const CacheConfig& cache_config) {
    // TODO
    uint32_t offset_bits = cache_config.get_num_block_offset_bits();

    uint32_t index_bits = cache_config.get_num_index_bits();

    uint32_t tag_bits = cache_config.get_num_tag_bits();


    if(tag_bits > 31){
       return address;
    }
    return (address >> (offset_bits + index_bits));
}

uint32_t extract_index(uint32_t address, const CacheConfig& cache_config) {
    // TODO
    uint32_t offset_bits = cache_config.get_num_block_offset_bits();

    uint32_t tag_bits = cache_config.get_num_tag_bits();

    if(tag_bits > 31) {
      return 0;
    }

    return ((address << tag_bits) >> (tag_bits + offset_bits));
}

uint32_t extract_block_offset(uint32_t address, const CacheConfig& cache_config) {
    // TODO

    uint32_t index_bits = cache_config.get_num_index_bits();

    uint32_t tag_bits = cache_config.get_num_tag_bits();

    if(tag_bits > 31) return 0;

    uint32_t tag_ind = tag_bits + index_bits; return ((address << tag_ind) >> tag_ind);
}