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
- (instancetype)dc_initObjectFromDictionary:(NSDictionary *)dictionary error:(NSError **)error
{
    NSObject *object = [self init];
    if (object) {
        [[self class] dc_enumerateKeysAndClassNameUsingBlock:^(NSString *key, NSString *className, BOOL *stop) {
            id value = [dictionary objectForKey:key];
            [self dc_tryValidateAndSetValue:value forKey:key className:className];
        }];
    }
    return object;
}

- (void)dc_tryValidateAndSetValue:(id)value forKey:(NSString *)key className:(NSString *)className
{
    @try {
        [self setValue:value forKey:key];
    } @catch (NSException *exception) {
        NSLog(@"the key is %@, the value is %@",key,value);
    } @finally {
        
    }
}

- (BOOL)dc_validateValue:(id)value forKey:(NSString *)key Error:(NSError **)error
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

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@",[self dc_convertToDictionaryFromModel]];
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
