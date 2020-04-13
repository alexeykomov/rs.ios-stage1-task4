#import "ArrayCalculator.h"
#import "KLargest.h"
#import "../utils.h"

int min(int a, int b) {
    if (a < b) {
        return a;
    }
    return b;
}

@implementation ArrayCalculator
+ (NSInteger)maxProductOf:(NSInteger)numberOfItems itemsFromArray:(NSArray *)array {
    
    int counter = 0;
    NSMutableArray *preparedInput = [[NSMutableArray alloc] init];
    for (counter = 0; counter < [array count]; counter++) {
        NSLog(@"Class of input member: %@", [[[array objectAtIndex:counter] class] description]);
        NSLog(@"Class of input member: %@", [[array objectAtIndex:counter] class]);
        NSLog(@"Is kind of NSString: %d", [[[array objectAtIndex:counter] class]
        isKindOfClass:[NSString class]]);
        NSString *description = [[[array objectAtIndex:counter] class] description];
        if (![description isEqualToString:@"__NSCFConstantString"]) {
            [preparedInput addObject:[array objectAtIndex:counter]];
        }
    }
    // First heap ignores sign, but only when number of negative multipliers is
    // even.
    KLargest *heap = [[KLargest alloc] initWithElements:preparedInput
                                             ignoreSign:YES];
    
    if ([heap.heap count] == 0) {
        return 0;
    }
    
    counter = 0;
    int counterOfNegative = 0;
    int product = 1;
    int limit = min(numberOfItems, [heap.heap count]);
    while (counter < limit) {
        int nextMax = [heap extractMax];
        if (nextMax < 0) {
            counterOfNegative++;
        }
        product = product * nextMax;
        counter++;
    }
    if (isEven(counterOfNegative)) {
        return product;
    }
    
    // Second heaps uses sign of numbers to sort them.
    heap = [[KLargest alloc] initWithElements:preparedInput ignoreSign:NO];
    counter = 0;
    product = 1;
    limit = min(numberOfItems, [heap.heap count]);
    while (counter < limit) {
        int nextMax = [heap extractMax];
        product = product * nextMax;
        counter++;
    }
    
    return product;
}
@end
