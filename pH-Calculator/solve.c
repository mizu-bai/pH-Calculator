//
//  solve.c
//  pH-Calculator
//
//  Created by 李俊宏 on 2021/3/2.
//
//

#include "solve.h"

#define ESP 1.0E-05

double solve(double x0, double (*p0)(double), double (*p1)(double)) {
    /**
     * Using Newton Method to solve equations.
     * * x0:  initial value
     * * *p0: primitive function
     * * *p1: derivative function
     */
    double x;
    do {
        x = x0 - (*p0)(x0) / (*p1)(x0);
        x0 = x;
    } while (fabs((*p0)(x)) > ESP);
    return x;
}

