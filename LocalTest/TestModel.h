//
//  TestModel.h
//  LocalDataTest
//
//  Created by aReu on 2017/7/5.
//  Copyright © 2017年 CBswift. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TestInsertModel;
@interface TestModel : NSObject

@property (strong,nonatomic) TestInsertModel *insertModel;

@property (strong,nonatomic) TestInsertModel *updateModel;

@property (copy,nonatomic) NSString *modeState;

@property (copy,nonatomic) NSString *code;

@property (copy,nonatomic) NSString *modelId;
@end
