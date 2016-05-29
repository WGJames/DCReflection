//
//  NSObject+DC_Properties.h
//  DC_ORM
//
//  Created by James on 16/5/11.
//  Copyright © 2016年 James. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DC_Properties)

+ (NSDictionary *)dc_propertiesDetailDictionary;

+ (void)dc_enumerateKeysAndClassNameUsingBlock:(void (^)(NSString *key, NSString *className, BOOL *stop))keyBlock;

+ (BOOL)dc_validateClassIsBasicType:(NSString *)className;

@end
