// #include "simplecache.h"

// int SimpleCache::find(int index, int tag, int block_offset) {
//   // read handout for implementation details
//   return 0xdeadbeef;
// }

// void SimpleCache::insert(int index, int tag, char data[]) {
//   // read handout for implementation details
//   // keep in mind what happens when you assign (see "C++ Rule of Three")
// }



#include "simplecache.h"

int SimpleCache::find(int index, int tag, int block_offset) {
  // read handout for implementation details
  int smolBoi = 0xdeadbeef;
  for (unsigned i = 0; i < _cache[index].size(); i++) {
    if (_cache[index][i].tag() == tag && _cache[index][i].valid()) {

      smolBoi = _cache[index][i].get_byte(block_offset);
      break;
    }
  }
  return smolBoi;
}



void SimpleCache::insert(int index, int tag, char data[]) {
	// read handout for implementation details
	auto searchFor = _cache.find(index);
	for (int i = 0; i < _associativity; i++) {
		auto & peek = searchFor->second[i];
		if(peek.valid() == false){
			peek.replace(tag, data);
			return;

		}
	}

	auto & peekAgain = searchFor->second[0];
	peekAgain.replace(tag, data);
}
