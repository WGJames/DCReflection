//
//  user.h
//  DC_ORM
//
//  Created by James on 16/5/11.
//  Copyright © 2016年 James. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "car.h"
@interface user : NSObject
@property (nonatomic, strong) NSString *user_name;
@property (nonatomic, strong) NSNumber *user_id;
//@property (nonatomic, strong) NSObject *theObject;
//@property (nonatomic, strong) NSArray <NSString *> *the_Array;
//@property (nonatomic, assign) char theChar;
//@property (nonatomic, assign) BOOL theBOOL;
//@property (nonatomic, assign) int theInt;
//@property (nonatomic, assign) double theDouble;
//@property (nonatomic, assign) float theFloat;
//@property (nonatomic, assign) long theLong;
//@property (nonatomic, strong) id theId;
//@property (nonatomic, assign) CGRect theRect;
//@property (nonatomic, assign) NSUInteger theUInterger;
//@property (nonatomic, assign) NSInteger theInterger;
//@property (nonatomic, assign) bool theBool;

@property (nonatomic, strong) car *theCar;
@end
