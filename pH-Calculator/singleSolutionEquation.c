//
//  singleSolutionEquation.c
//  pH-Calculator
//
//  Created by 李俊宏 on 2021/3/2.
//
//

#include "singleSolutionEquation.h"

double f1(double c, int n, double *K, double cx) {
    /**
     * 1. c: c(HA) or c(B-)
     * 2. n: number of protons
     * 3. *K: array of dissociation constant K
     * 4. cx: c(H+) or c(OH-)
     */
    if (n == 1) {
        // monoprotic
        // f1(x) = cx ^ 3 + K * cx ^ 2 - (K * c + Kw) * cx - K * Kw
        return pow(cx, 3.0) + K[0] * pow(cx, 2.0) - (K[0] * c + Kw) * cx - K[0] * Kw;
    } else if (n == 2) {
        // diprotic
        // f1(x) = cx ^ 4 + K1 * cx ^ 3 + (K1 * K2 - K1 * c - Kw) * cx ^ 2 - (K1 * Kw + 2 * K1 * K2 * c) * cx - K1 * K2 * Kw
        return pow(cx, 4.0) + K[0] * pow(cx, 3.0) + (K[0] * K[1] - K[0] * c - Kw) * pow(cx, 2.0) - (K[0] * Kw + 2 * K[0] * K[1] * c) * cx - K[0] * K[1] * Kw;
    } else if (n >= 3) {
        // triprotic or tetraprotic
        // f1(x) = cx ^ 5 + K1 * cx ^ 4 + (K1 * K2 - K1 * c - Kw) * cx ^ 3 + (K1 * K2 * K3 - 2 * K1 * K2 - K1 * Kw) * cx ^ 2 - (3 * K1 * K2 * K3 + K1 * K2 * Kw) * cx - K1 * K2 * K3 * Kw
        return pow(cx, 5.0) + K[0] * pow(cx, 4) + (K[0] * K[1] - K[0] * c - Kw) * pow(cx, 3.0) + (K[0] * K[1] * K[2] - 2 * K[0] * K[1] - K[0] * Kw) * pow(cx, 2.0) - (3 * K[0] * K[1] * K[2] + K[0] * K[1] * Kw) * cx - K[0] * K[1] * K[2] * Kw;
    } else {
        return 0;
    }
}

double f2(double c, int n, double *K, double cx) {
    /**
      * 1. c: c(HA) or c(B-)
      * 2. n: number of protons
      * 3. *K: array of dissociation constant K
      * 4. cx: c(H+) or c(OH-)
      */
    if (n == 1) {
        // monoprotic
        // f2(x) = 3 * cx + 2 * K * cx - (K * c + Kw)
        return 3 * cx + 2 * K[0] * cx - (K[0] * c + Kw);
    } else if (n == 2) {
        // diprotic
        // f2(x) = 4 * cx ^ 3 + 3 * K1 * cx ^ 2 + 2 * (K1 * K2 - K1 * c - Kw) * cx - (K1 * Kw + 2 * K1 * K2 * c)
        return 4 * pow(cx, 3.0) + 3 * K[0] * pow(cx, 2.0) + 2 * (K[0] * K[1] - K[0] * c - Kw) * cx - (K[0] * Kw + 2 * K[0] * K[1] * c);
    } else if (n >= 3) {
        // triprotic
        // f2(x) = 5 * cx ^ 4 + 4 * K1 * cx ^ 3 + 3 * (K1 * K2 - K1 * c - Kw) * cx ^ 2 + 2 * (K1 * K2 * K3 - 2 * K1 * K2 - K1 * Kw) * cx - (3 * K1 * K2 * K3 + K1 * K2 * Kw)
        return 5 * pow(cx, 4) + 4 * K[0] * pow(cx, 3) + 3 * (K[0] * K[1] - K[0] * c - Kw) * pow(cx, 2) + 2 * (K[0] * K[1] * K[2] - 2 * K[0] * K[1] - K[0] * Kw) * cx - (3 * K[0] * K[1] * K[2] + K[0] * K[1] * Kw);
    } else {
        return 0;
    }
}