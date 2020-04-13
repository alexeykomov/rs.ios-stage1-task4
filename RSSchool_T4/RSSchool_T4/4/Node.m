//
//  Node.m
//  RSSchool_T4
//
//  Created by Alex K on 4/13/20.
//  Copyright © 2020 iOSLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"
#import "../utils.h"

@implementation Node: NSObject

- (instancetype)initWithLeft:(Node *)left right:(Node *)right
                       value:(NSNumber *) value
                     maxSize:(int) maxSize
{
    self = [super init];
    if (self) {
        self.left = left;
        self.right = right;
        self.value = value;
        self.maxSize = maxSize;
    }
    return self;
}

- (Node *)clone {
    Node *newTree = [[Node alloc] init];
    if (newTree.left) {
        newTree.left = [self.left clone];
    }
    if (newTree.right) {
        newTree.right = [self.right clone];
    }
    newTree.value = self.value;
    newTree.maxSize = self.maxSize;
    return newTree;
}

- (int) calcSize {
    return [self calcSizeSubTree:self];
}

- (int) calcSizeSubTree:(Node*)node{
    int ownSize = 1;
    int leftSize = 0;
    int rightSize = 0;
    if (node.left != nil) {
        leftSize = [self calcSizeSubTree: node.left];
    }
    if (node.right != nil) {
        rightSize = [self calcSizeSubTree: node.right];
    }
    return ownSize + leftSize + rightSize;
}

- (NSString *)serialize {
    NSMutableArray *output = [[NSMutableArray alloc] init];
    int actualSize = [self calcSize];
    int maxSize = getNextTreeMaxSize(actualSize);
    [self serializeSubTree:output node:self index:0 maxSize:maxSize];
    NSMutableString *result = [[NSMutableString alloc] init];
    [result appendString:@"["];
    [result appendString:[output componentsJoinedByString:@","]];
    [result appendString:@"]"];
    return result;
}

- (void) serializeSubTree:(NSMutableArray*) output
                                node:(Node*) node
                                index:(int) index
                                maxSize: (int) maxSize {
    if (index >= maxSize) {
        return;
    }
    
    if (index + 1 > [output count]) {
        int counter = index + 1 - [output count];
        while (counter > 0) {
            [output addObject:@"null"];
            counter--;
        }
    }
    
    if (node.value != nil) {
        [output replaceObjectAtIndex:index withObject:[node.value stringValue]];
        [self serializeSubTree:output node:node.left index:getLeftChildIndex(index) maxSize:maxSize];
        [self serializeSubTree:output node:node.right index:getRightChildIndex(index) maxSize:maxSize];
        
    }
}

@end
