#import "FullBinaryTrees.h"
#import "../utils.h"
#import "Node.h"

@implementation FullBinaryTrees
- (NSString *)stringForNodeCount:(NSInteger)count {
    if (isEven(count)) {
        return @"[]";
    }
    
    Node *root = [[Node alloc] initWithLeft:nil right:nil value:@0 maxSize:count];
    NSMutableSet *possibilities = [[NSMutableSet alloc] init];
    [self spawnSubTree:possibilities tree:root reserve:count - 1];
  
    return possibilities;
 }
     
- (void) spawnSubTree:(NSMutableSet*) possibilities
                 tree:(Node*) tree reserve:(int) reserve {
    if (reserve == 0) {
        [possibilities addObject:[tree serialize]];
        return;
    }
    if (reserve == 1 || reserve < 0) {
        return;
    }
    
    Node *clone1 = [tree clone];
    Node *clone2 = [tree clone];
    Node *clone3 = [tree clone];
    
    NSLog(@"Serialized tree: %@", [tree serialize]);
    
    clone1.left = [[Node alloc] initWithLeft:nil right:nil value:@0 maxSize:tree.maxSize];
    
    clone2.right = [[Node alloc] initWithLeft:nil right:nil value:@0 maxSize:tree.maxSize];
    
    clone3.left = [[Node alloc] initWithLeft:nil right:nil value:@0 maxSize:tree.maxSize];
    clone3.right = [[Node alloc] initWithLeft:nil right:nil value:@0 maxSize:tree.maxSize];
    
    [self spawnSubTree:possibilities tree:clone1 reserve:reserve - 1];
    
    [self spawnSubTree:possibilities tree:clone2 reserve:reserve - 1];
    
    [self spawnSubTree:possibilities tree:clone3 reserve:reserve - 2];
    [self spawnSubTree:possibilities tree:clone3 reserve:reserve - 2];
}

@end


