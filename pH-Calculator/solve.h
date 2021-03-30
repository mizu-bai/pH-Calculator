//
//  solve.h
//  pH-Calculator
//
//  Created by 李俊宏 on 2021/3/2.
//
//

#ifndef solve_h
#define solve_h

#include <stdio.h>
#include <math.h>

double solve(double x0, double (*p0)(double), double (*p1)(double));

#endif /* solve_h */
