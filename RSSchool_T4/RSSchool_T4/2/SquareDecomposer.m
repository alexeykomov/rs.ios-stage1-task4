#import "SquareDecomposer.h"

@implementation SquareDecomposer
- (NSArray <NSNumber*>*)decomposeNumber:(NSNumber*)number {
    int initialNumber = [(NSNumber*) number intValue];
    int maximalClosestNumber = initialNumber - 1;
    int leftSpace = powl(initialNumber, 2);
    NSMutableArray *res = [[NSMutableArray alloc] init];
    while (maximalClosestNumber > 0) {
        int leftSpaceAfterSubtraction = leftSpace - pow(maximalClosestNumber, 2);
        if (leftSpaceAfterSubtraction >= 0) {
            [res addObject:@(maximalClosestNumber)];
            leftSpace = leftSpaceAfterSubtraction;
        }
        maximalClosestNumber--;
        
    }
    NSLog(@"Result: %@", res);
    NSLog(@"Left space: %d", leftSpace);
    return [[res reverseObjectEnumerator] allObjects];
}

- (NSArray <NSNumber*>*)decomposeNumberRec:(NSNumber*)number
                                 leftSpace:(int) leftSpace{
    int initialNumber = [(NSNumber*) number intValue];
    int maximalClosestNumber = initialNumber - 1;
    NSMutableArray *res = [[NSMutableArray alloc] init];
    while (maximalClosestNumber > 0) {
        int leftSpaceAfterSubtraction = leftSpace - pow(maximalClosestNumber, 2);
        if (leftSpaceAfterSubtraction >= 0) {
            [self decomposeNumberRec:maximalClosestNumber leftSpace:leftSpaceAfterSubtraction];
            
            [res addObject:@(maximalClosestNumber)];
            leftSpace = leftSpaceAfterSubtraction;
        }
        maximalClosestNumber--;
        
    }
    NSLog(@"Result: %@", res);
    NSLog(@"Left space: %d", leftSpace);
    return [[res reverseObjectEnumerator] allObjects];
}

@end
