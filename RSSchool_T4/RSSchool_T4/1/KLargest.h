//
//  KLargest.h
//  RSSchool_T4
//
//  Created by Alex K on 4/11/20.
//  Copyright © 2020 iOSLab. All rights reserved.
//

#ifndef KLargest_h
#define KLargest_h


#endif /* KLargest_h */


@interface KLargest : NSObject

@property (nonatomic, strong) NSMutableArray *heap;
@property (nonatomic) int size;
@property (nonatomic) BOOL ignoreSign;

- initWithElements:(NSArray *) elements ignoreSign:(BOOL) ignoreSign;
- (int) extractMax;
- (void) insert:(int) element; 

@end
