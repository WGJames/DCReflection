//
//  NSObject+DC_Reflection.m
//  DC_ORM
//
//  Created by James on 16/5/15.
//  Copyright © 2016年 James. All rights reserved.
//

#import "NSObject+DC_Reflection.h"
#import "NSObject+DC_Properties.h"
@implementation NSObject (DC_Reflection)
- (instancetype)dc_convertToModelFromDictionary:(NSDictionary *)dictionary error:(NSError **)error
{
    NSObject *object = [self init];
    if (object) {
        [[self class] dc_enumerateKeysAndClassNameUsingBlock:^(NSString *key,NSString *className ,BOOL *stop) {
            id value = [dictionary objectForKey:key];
            BOOL isSuccess = [self dc_validateValueForKey:key Value:value Error:error];
            if (isSuccess) {
                NSLog(@"can convert to");
            }
        }];
    }
    return object;
}

- (BOOL)dc_validateValueForKey:(NSString *)key Value:(id)value Error:(NSError **)error
{
    if ([value isEqual:[NSNull null]]) {
        return NO;
    }
    return [self validateValue:&value forKey:key error:error];
}

- (NSDictionary *)dc_convertToDictionaryFromModel
{
    NSDictionary *propertyDictionary = [[self class] dc_propertiesDetailDictionary];
    NSArray *keysList = [propertyDictionary allKeys];
    return [self dictionaryWithValuesForKeys:keysList];
}

+ (void)dc_setClassReflectIngoredList:(NSArray *)ingoredList
{
    
}

+ (void)dc_setClassReflectAllowedList:(NSArray *)allowrdList
{
    
}

- (void)dc_setObjectReflectIngoredList:(NSArray *)ingoredList
{
    
}

- (void)dc_setObjectReflectAllowedList:(NSArray *)allowedList
{
    
}

@end
