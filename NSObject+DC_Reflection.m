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
            __autoreleasing id value = [dictionary objectForKey:key];
            if ([value isEqual:[NSNull null]]) {
                value = nil;
            }
            [self dc_tryValidateAndSetValue:value forKey:key className:className];
        }];
    }
    return object;
}

- (void)dc_tryValidateAndSetValue:(id)value forKey:(NSString *)key className:(NSString *)className
{
    __autoreleasing id validateValue = value;
    NSError *error = nil;
    @try {
        if ([self validateValue:&validateValue forKey:key error:&error]) {
            [self dc_setValue:validateValue forKey:key];
        } else {
            NSLog(@"the error is %@",error);
        }
    } @catch (NSException *exception) {
        NSLog(@"----catch the exception is %@",exception);
    }
}

- (void)dc_setValue:(id)value forKey:(NSString *)key
{
    NSString *className = [[[self class] dc_propertiesDetailDictionary] objectForKey:key];
    Class targetClass = NSClassFromString(className);
    if ([value isKindOfClass:targetClass]) {
        [self setValue:value forKey:key];
    } else {
        [self dc_autoMappingWithValue:value targetClassName:className forKey:key];
    }
}

- (void)dc_autoMappingWithValue:(id)value targetClassName:(NSString *)targetClassName forKey:(NSString *)key
{
    __autoreleasing id targetValue;
    if ([targetClassName isEqualToString:@"NSString"]) {
        SEL stringSelector = NSSelectorFromString(@"stringValue");
        if ([value respondsToSelector:stringSelector]) {
            targetValue = [value performSelector:stringSelector];
        }
    } else if ([targetClassName isEqualToString:@"NSNumber"]) {
        
    } else if ([[self class] dc_validateClassIsBasicType:targetClassName]) {
        if ([value isKindOfClass:[NSNumber class]]) {
            targetValue = value;
        }
    }
    if (targetValue) {
        [self setValue:targetValue forKey:key];
    }
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

