#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int main()
{
    uint64_t a = 18446744073709551615ULL;

    printf("Hello, World!\n%llu\n%-50llu\n", a, UINT64_MAX);
    return 1;
}
