#import <Foundation/Foundation.h>

@interface TelephoneFinder : NSObject

@property (nonatomic, strong) NSArray* keypad;

- (NSArray <NSString*>*)findAllNumbersFromGivenNumber:(NSString*)number;

@end

