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
        [object dc_enumerateKeysAndPropertyClassesUsingBlock:^(NSString *theKey,NSString *propertyClass ,BOOL *stop) {
            id value = [dictionary objectForKey:theKey];
            BOOL isSuccess = [self dc_validateValueForKey:theKey Value:value Error:error];
            if (isSuccess) {
                NSLog(@"can convert to");
            }
            
        }];
    }
    return object;
}

- (void)dc_enumerateKeysAndPropertyClassesUsingBlock:(void (^)(NSString *theKey,NSString *propertyClass, BOOL *stop))keyBlock
{
    BOOL isStop = NO;
    NSDictionary *propertiesDictionary = [[self class] dc_PropertiesDetailDictionary];
    NSArray *keysList = [propertiesDictionary allKeys];
    for (NSString *theKey in keysList) {
        NSString *propertyClass = [propertiesDictionary objectForKey:theKey];
        if (keyBlock) {
            keyBlock(theKey, propertyClass, &isStop);
        }
        if (isStop) break;
    }
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
    NSDictionary *propertyDictionary = [[self class] dc_PropertiesDetailDictionary];
    NSArray *keysList = [propertyDictionary allKeys];
    return [self dictionaryWithValuesForKeys:keysList];
}
@end
