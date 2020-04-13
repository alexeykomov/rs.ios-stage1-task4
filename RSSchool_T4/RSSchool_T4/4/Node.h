//
//  Node.h
//  RSSchool_T4
//
//  Created by Alex K on 4/13/20.
//  Copyright © 2020 iOSLab. All rights reserved.
//

#ifndef Node_h
#define Node_h


#endif /* Node_h */

@interface Node : NSObject

@property (nonatomic, assign) Node* left;
@property (nonatomic, assign) Node* right;
@property (nonatomic, assign) NSNumber* value;
@property (nonatomic, assign) int maxSize;

- initWithLeft:(Node*) left right:(Node*) right value: (NSNumber*) value maxSize:(int) maxSize;
- (Node*) clone;
- (int) calcSize;
- (NSString*) serialize;
@end