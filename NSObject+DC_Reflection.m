//
//  NSObject+DC_Reflection.m
//  DC_ORM
//
//  Created by James on 16/5/15.
//  Copyright © 2016年 James. All rights reserved.
//

#import "NSObject+DC_Reflection.h"
#import "NSObject+DC_Properties.h"
#import "DCValueTransformer.h"
#import "DCValueTransformer+Addtional.h"

typedef NS_ENUM(NSInteger, DCORMErrorCode) {
    DCORMValueIsNSNullCode = -11000,
};
@implementation NSObject (DC_Reflection)
+ (void)load
{
    @autoreleasepool {
        [DCValueTransformer dc_registerNSNumberToNSStringValueTransformer];
        [DCValueTransformer dc_registerNSStringToNSNumberValueTransformer];
    }
}

- (instancetype)dc_initObjectFromDictionary:(NSDictionary *)dictionary
{
    NSObject *object = [self init];
    if (object) {
        [[self class] dc_enumerateKeysAndClassNameUsingBlock:^(NSString *key, NSString *className, BOOL *stop) {
            __autoreleasing id value = [dictionary objectForKey:key];
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

- (BOOL)validateValue:(id *)ioValue forKey:(NSString *)inKey error:(NSError **)outError
{
    __autoreleasing id validateValue = *ioValue;
    if ([validateValue isEqual:[NSNull null]]) {
        NSString *description = [NSString stringWithFormat:@"the key is %@ and the value is NSNull",inKey];
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey: description
                                   };
        *outError = [NSError errorWithDomain:@"value is NSNull" code:DCORMValueIsNSNullCode userInfo:userInfo];
        return NO;
    }
    return YES;
}

- (void)dc_setValue:(id)value forKey:(NSString *)key
{
    NSString *className = [[[self class] dc_propertiesDetailDictionary] objectForKey:key];
    Class targetClass = NSClassFromString(className);
    if ([value isKindOfClass:targetClass]) {
        [self setValue:value forKey:key];
    } else if ([value isKindOfClass:[NSDictionary class]]) {
        id objectValue = [[targetClass alloc] dc_initObjectFromDictionary:value];
        [self setValue:objectValue forKey:key];
    } else {
        [self dc_autoMappingWithValue:value targetClassName:className forKey:key];
    }
}

- (void)dc_autoMappingWithValue:(id)value targetClassName:(NSString *)targetClassName forKey:(NSString *)key
{
    NSValueTransformer *valueTransformer = nil;
    if ([value isKindOfClass:[NSString class]] && [targetClassName isEqualToString:@"NSNumber"]) {
        valueTransformer = [NSValueTransformer valueTransformerForName:DCNSStringToNSNumberTransformerName];
    } else if ([value isKindOfClass:[NSNumber class]] && [targetClassName isEqualToString:@"NSString"]) {
        valueTransformer = [NSValueTransformer valueTransformerForName:DCNSNumberToNSStringTransformerName];
    } else {
        NSLog(@"the value class is %@ and the target class is %@", [value class], targetClassName);
    }
    if (valueTransformer != nil) {
        id forwardValue = [valueTransformer transformedValue:value];
        [self setValue:forwardValue forKey:key];
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

@end

