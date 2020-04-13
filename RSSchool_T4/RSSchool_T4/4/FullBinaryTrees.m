#import "FullBinaryTrees.h"
#import "../utils.h"
#import "Node.h"

@implementation FullBinaryTrees
- (NSString *)stringForNodeCount:(NSInteger)count {
    if (isEven(count)) {
        return @"[]";
    }
    
    if (count == 1) {
        return @"[0]";
    }
    NSMutableArray *res = [self getPossibleTrees:count];
    NSString *resultLine = [res componentsJoinedByString:@","];
    return resultLine;
 }

- (NSMutableArray*) getPossibleTrees:(int) count {
    NSMutableArray *res = [[NSMutableArray alloc] init];
    
    int counter = 2;
    while (counter < count + 1) {
        NSMutableArray *leftSubTree = [self getPossibleTrees:counter - 1];
        NSMutableArray *rightSubTree = [self getPossibleTrees:count - counter];
        int counterLeft = 0;
        
        for (counterLeft = 0; counterLeft < [leftSubTree count]; counterLeft++) {
            Node *left = [leftSubTree objectAtIndex:counterLeft];
            for (int counterRight = 0; counterRight < [rightSubTree count]; counterRight++) {
                Node *right = [rightSubTree objectAtIndex:counterRight];
                Node *tree = [[Node alloc] initWithLeft:nil right:nil value:@0];
             
                tree.left = (counterRight + 1) < [rightSubTree count] ? [left clone] : left;
                tree.right = (counterLeft + 1) < [leftSubTree count] ? [right clone] : right;
                
                [res addObject:tree];
                
            }
        }
        counter += 2;
    }
    return res;
}

@end


