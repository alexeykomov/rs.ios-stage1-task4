//
//  KLargest.m
//  RSSchool_T4
//
//  Created by Alex K on 4/11/20.
//  Copyright © 2020 iOSLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLargest.h"

id getLeftChild(NSArray *nodes, int n) {
    return [nodes objectAtIndex:2 * n + 1];
}

id getRightChild(NSArray *nodes, int n) {
    return [nodes objectAtIndex:2 * n + 2];
}

id getParent(NSArray *nodes, int n) {
    return [nodes objectAtIndex:(n - 1) / 2];
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

int compare(int a, int b, BOOL ignoreSign) {
    if (ignoreSign) {
        return abs(a) > abs(b) ? 1 : abs(a) < abs(b) ? -1 : 0;
    }
    return a > b ? 1 : a < b ? -1 : 0;
}

void swap(NSMutableArray *nodes, int indexA, int indexB) {
    id temp = [nodes objectAtIndex:indexB];
    [nodes setObject:[nodes objectAtIndex:indexA] atIndexedSubscript:indexB];
    [nodes setObject:temp atIndexedSubscript:indexA];
}

@implementation KLargest:NSObject

- (id)initWithElements:(NSArray *) elements ignoreSign:(BOOL) ignoreSign
{
    self = [super init];
    if (self) {
        self.ignoreSign = ignoreSign;
        self.size = 0;
        self.heap = [[NSMutableArray alloc] init];
        [self buildHeap:elements];
    }
    return self;
}

- (void) siftDown:(int) index {
    if ([self.heap count] == 0) {
        return;
    }
    
    int indexHigh = index;
    int indexLow1 = getLeftChildIndex(indexHigh);
    int indexLow2 = getRightChildIndex(indexHigh);
    int leftChild = indexLow1 < [self.heap count] ?
        [(NSNumber*) getLeftChild(self.heap, indexHigh) intValue] :
        INT_MIN;
    int rightChild = indexLow2 < [self.heap count] ?
        [(NSNumber*) getRightChild(self.heap, indexHigh) intValue] :
    INT_MIN;
    int current = [(NSNumber*) [self.heap objectAtIndex:indexHigh] intValue];
    
    while (compare(current, leftChild, self.ignoreSign) == -1 ||
           compare(current, rightChild, self.ignoreSign) == -1) {
        int indexLow = compare(leftChild, rightChild, self.ignoreSign) >= 0 ?
            indexLow1 : indexLow2;
        swap(self.heap, indexHigh, indexLow);
        
        indexHigh = indexLow;
        indexLow1 = getLeftChildIndex(indexHigh);
        indexLow2 = getRightChildIndex(indexHigh);
        leftChild = indexLow1 < [self.heap count] ?
            [(NSNumber*) getLeftChild(self.heap, indexHigh) intValue] :
            INT_MIN;
        rightChild = indexLow2 < [self.heap count] ?
            [(NSNumber*) getRightChild(self.heap, indexHigh) intValue] :
            INT_MIN;
        current = [(NSNumber*) [self.heap objectAtIndex:indexHigh] intValue];
    }
}

- (void) siftUp:(int) index {
    if ([self.heap count] == 0) {
        return;
    }
    
    int indexLow = index;
    int indexHigh = getParentIndex(indexLow);
    int parent = [(NSNumber*) getParent(self.heap, indexLow) intValue];
    int current = [(NSNumber*) [self.heap objectAtIndex:indexLow] intValue];
    while (compare(current, parent, self.ignoreSign) > 0) {
        swap(self.heap, indexLow, indexHigh);
        
        indexLow = indexHigh;
        indexHigh = getParentIndex(indexLow);
        parent = [(NSNumber*) getParent(self.heap, indexLow) intValue];
        current = [(NSNumber*) [self.heap objectAtIndex:indexLow] intValue];
    }
}

- (int) extractMax {
    int max = [(NSNumber*) [self.heap objectAtIndex:0]intValue];
    swap(self.heap, 0, [self.heap count] - 1);
    [self.heap removeObjectAtIndex:[self.heap count] -  1];
    [self siftDown:0];
    return max;
}

- (int) getMax {
    return [(NSNumber*)[self.heap objectAtIndex:0] intValue];
}

- (void) insert:(int) element {
    [self.heap addObject:@(element)];
    [self siftUp:[self.heap count] - 1];
}

- (void) buildHeap:(NSArray*) input {
    int counter = 0;
    while (counter < [input count]) {
        [self insert:[(NSNumber*) [input objectAtIndex:counter] intValue]];
        counter++;
    }
}

@end
