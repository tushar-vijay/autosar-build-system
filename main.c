#include<stdio.h>
#include "main.h"
#include "asw/asw_dummy.h"
#include "bsw/bsw_dummy.h"
#include "mcal/mcal_dummy.h"
#include "cdd/cdd_dummy.h"

int main(void) {
    asw_dummy_function();
    bsw_dummy_function();
    mcal_dummy_function();
    cdd_dummy_function();

    printf("Sample Build Successful\n");
    return 0;
}
