#import "TelephoneFinder.h"

@implementation TelephoneFinder

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.keypad = @[
            @[@"1", @"2", @"3"],
            @[@"4", @"5", @"6"],
            @[@"7", @"8", @"9"],
            @[@"", @"0", @""]
        ];
    }
    return self;
}

- (void) addToRes:(NSMutableArray*) res row:(int)row col:(int)col {
    NSString *found = [[self.keypad objectAtIndex:row] objectAtIndex:col];
        if ([found length]) {
            [res addObject:found];
        }
}

- (NSArray*) findAdjacent: (NSString*) input {
    NSMutableArray *res = [[NSMutableArray alloc] init];
    for (int positionRow = 0; positionRow < [self.keypad count]; positionRow++) {
        NSArray *col = [self.keypad objectAtIndex:positionRow];
        int rowLength = [col count];
        for (int positionCol = 0; positionCol < rowLength; positionCol++) {
            NSString *key = [col objectAtIndex:positionCol];
            if ([input isEqualToString:key]) {
                int left = positionCol - 1;
                if (left >= 0) {
                    [self addToRes:res row:positionRow col:left];
                }
                int right = positionCol + 1;
                if (right < rowLength) {
                    [self addToRes:res row:positionRow col:right];
                }
                int down = positionRow + 1;
                if (down < [self.keypad count]) {
                    [self addToRes:res row:down col:positionCol];
                }
                int up = positionRow - 1;
                if (up >= 0) {
                    [self addToRes:res row:up col:positionCol];
                }
            }
        }
    }
    return res;
}

- (NSArray <NSString*>*)findAllNumbersFromGivenNumber:(NSString*)number {
    if ([number intValue] > 0) {
        NSMutableArray *res = [[NSMutableArray alloc] init];
        for (int counter = 0; counter < [number length]; counter++) {
            NSRange r = NSMakeRange(counter, 1);
            NSString *digit = [number substringWithRange:r];
            NSArray *adjacentDigits = [self findAdjacent:digit];
            for (int counterAdjacentDigits = 0;
                 counterAdjacentDigits < [adjacentDigits count];
                 counterAdjacentDigits++) {
                NSMutableString *variant = [[NSMutableString alloc] initWithString:number];
                [variant replaceCharactersInRange:r
                                       withString:[adjacentDigits
                                                   objectAtIndex:counterAdjacentDigits]];
                [res addObject:variant];
            }
        }
        return res;
    }
    return nil;
}
@end
