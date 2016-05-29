//
//  ViewController.m
//  DC_ORM
//
//  Created by James on 16/5/11.
//  Copyright © 2016年 James. All rights reserved.
//

#import "ViewController.h"
#import "user.h"
#import "NSObject+DC_Reflection.h"
#import "NSObject+DC_Properties.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSLog(@"%@",[user dc_PropertiesDetailDictionary]);
//    [user dc_PropertiesDetailDictionary];
     BOOL theBool = YES;
    NSDictionary *dic = @{
                          @"theBOOL" : @(theBool)
                          };
    NSError *error = nil;
    user *theUser = [[user alloc] dc_convertToModelFromDictionary:dic error:&error];
   
   
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
