#import "ArrayCalculator.h"
#import "KLargest.h"

BOOL isEven(int inp) {
    return inp % 2 == 0;
}

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
    
    KLargest *heap = [[KLargest alloc] initWithElements:preparedInput
                                             ignoreSign:isEven(numberOfItems)];
    
    if ([heap.heap count] == 0) {
        return 0;
    }
    
    counter = 0;
    int product = 1;
    int limit = min(numberOfItems, [heap.heap count]);
    while (counter < limit) {
        product = product * [heap extractMax];
        counter++;
    }
    return product;
}
@end
