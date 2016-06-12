//
//  car.m
//  DC_ORM
//
//  Created by James on 16/6/11.
//  Copyright © 2016年 James. All rights reserved.
//

#import "car.h"

@implementation car
- (BOOL)validateValue:(inout id  _Nullable __autoreleasing *)ioValue forKey:(NSString *)inKey error:(out NSError * _Nullable __autoreleasing *)outError
{
    return [super validateValue:ioValue forKey:inKey error:outError];
}
@end
