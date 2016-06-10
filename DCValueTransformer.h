//
//  DCValueTransformer.h
//  DC_ORM
//
//  Created by James on 16/6/10.
//  Copyright © 2016年 James. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^DCValueTransformerBlock)(id value, BOOL *success, NSError **error);

@interface DCValueTransformer : NSValueTransformer

+ (instancetype)transformerUsingForwardBlock:(DCValueTransformerBlock)forwardBlock;

+ (instancetype)transformerUsingReverseBlock:(DCValueTransformerBlock)reverseBlock;

+ (instancetype)transformerUsingForwardBlock:(DCValueTransformerBlock)forwardBlock ReverseBlock:(DCValueTransformerBlock)reverseBlock;

@end
