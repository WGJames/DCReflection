//
//  NSObject+DC_Reflection.h
//  DC_ORM
//
//  Created by James on 16/5/15.
//  Copyright © 2016年 James. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DC_Reflection)

- (instancetype)dc_initObjectFromDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)dc_convertToDictionaryFromModel;

@end
