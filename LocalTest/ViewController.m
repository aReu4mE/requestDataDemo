//
//  ViewController.m
//  LocalTest
//
//  Created by aReu on 2017/7/5.
//  Copyright © 2017年 CBswift. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "TestModel.h"
#import "zcLocalData.h"
#import "UCSLocalData.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [zcLocalData requestDataWithClass:[TestModel class] callBack:^(id model) {
        
    }];
}






@end



