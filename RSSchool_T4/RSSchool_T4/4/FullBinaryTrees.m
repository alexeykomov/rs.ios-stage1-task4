#import "FullBinaryTrees.h"
#import "../utils.h"
#import "Node.h"

@implementation FullBinaryTrees
- (NSString *)stringForNodeCount:(NSInteger)count {
    if (isEven(count)) {
        return @"[]";
    }
    
    Node *root = [[Node alloc] initWithLeft:nil right:nil value:@0];
    NSMutableSet *possibilities = [[NSMutableSet alloc] init];
    NSMutableDictionary *nodes = [[NSMutableDictionary alloc] init];
    [self spawnSubTree:possibilities tree:root
                    uuidsOfChildToFind:@[root.uuid]
                    reserve:count - 1];
  
    return possibilities;
 }
     
- (void) spawnSubTree:(NSMutableSet*) possibilities
                    tree:(Node*) tree
                    uuidsOfChildToFind:(NSArray<NSString*>*) uuids
                    reserve:(int) reserve {
//    NSLog(@"Tree serialization: %@", [tree serialize]);
//    NSLog(@"Tree size: %d", [tree calcSize]);
    if (reserve == 0) {
        NSLog(@"Tree serialization before answer: %@", [tree serialize]);
        [possibilities addObject:[tree serialize]];
        return;
    }
    if (reserve == 1 || reserve < 0) {
        return;
    }
    
    for (int counter = 0; counter < [uuids count]; counter++) {
        NSString *uuid = [uuids objectAtIndex:counter];
        Node *clone1 = [tree clone];
        Node *clone2 = [tree clone];
        Node *clone3 = [tree clone];
        
    //    NSLog(@"Serialized clone1: %@", [clone1 serialize]);
    //    NSLog(@"Size of clone1: %d", [clone1 calcSize]);
        Node *clone1Child = [clone1 findChildByUUID:uuid];
        clone1Child.left = [[Node alloc] initWithLeft:nil right:nil value:@0];
        Node *clone2Child = [clone2 findChildByUUID:uuid];
        clone2Child.right = [[Node alloc] initWithLeft:nil right:nil value:@0];
        Node *clone3Child = [clone3 findChildByUUID:uuid];
        clone3Child.left = [[Node alloc] initWithLeft:nil right:nil value:@0];
        clone3Child.right = [[Node alloc] initWithLeft:nil right:nil value:@0];
        
        [self spawnSubTree:possibilities tree:clone1
                    uuidsOfChildToFind:@[clone1Child.left.uuid] reserve:reserve - 1];
        [self spawnSubTree:possibilities tree:clone2
                    uuidsOfChildToFind:@[clone2Child.right.uuid] reserve:reserve - 1];
        [self spawnSubTree:possibilities tree:clone3
                    uuidsOfChildToFind:@[clone3Child.left.uuid, clone3Child.right.uuid]
                    reserve:reserve - 2];
    }
}

@end


