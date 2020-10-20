//=======================================================================
// Runtime Library 
//=======================================================================
// #include <map>
// #include <iterator>
// #include <stdio.h>
// #include "llvm/Support/raw_ostream.h"

// static std::map<const char*, int> count_list;

// void trackInst(char* opcode_name) {
    // std::map<const char*, int>::iterator it = 
    //                             count_list.find(opcode_name);
    // if(it != count_list.end()) {
    //     count_list[opcode_name] ++;
    // } else {
    //     count_list.insert(std::pair<const char*, int>(opcode_name, 1));
    // }
    // printf("%s\n", opcode_name);
// }

// void printout() {
//     for(std::pair<const char*, int> i : count_list) {
//         // std::cout<<i.first<<"\t"<<i.second<<"\n";
//         printf("%s\t%d\n", i.first, i.second);
//     }
// }

static char** string_list;
static int count_list[];
int count(char* string)
{

}
