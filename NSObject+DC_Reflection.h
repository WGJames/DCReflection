//
//  NSObject+DC_Reflection.h
//  DC_ORM
//
//  Created by James on 16/5/15.
//  Copyright © 2016年 James. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DC_Reflection)

- (instancetype)dc_initObjectFromDictionary:(NSDictionary *)dictionary error:(NSError **)error;

- (NSDictionary *)dc_convertToDictionaryFromModel;

+ (void)dc_setClassReflectIngoredList:(NSArray *)ingoredList;

+ (void)dc_setClassReflectAllowedList:(NSArray *)allowrdList;

- (void)dc_setObjectReflectIngoredList:(NSArray *)ingoredList;

- (void)dc_setObjectReflectAllowedList:(NSArray *)allowedList;

@end
