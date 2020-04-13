//
//  utils.m
//  RSSchool_T4
//
//  Created by Alex K on 4/13/20.
//  Copyright © 2020 iOSLab. All rights reserved.
//

#import <Foundation/Foundation.h>

BOOL isEven(int inp) {
    return inp % 2 == 0;
}

int getLeftChildIndex(int n) {
    return 2 * n + 1;
}

int getRightChildIndex(int n) {
    return 2 * n + 2;
}

int getParentIndex(int n) {
    return (n - 1) / 2;
}

int getNextTreeMaxSize(int n) {
    if (n == 0) {
        return 0;
    }
    if (n == 1) {
        return 1;
    }
    int cap = 1;
    int capFactor = 2;
    while (cap < n) {
        cap = cap + capFactor;
        capFactor *= 2;
    }
    return cap;
}
