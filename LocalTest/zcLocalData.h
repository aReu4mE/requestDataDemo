//
//  zcLocalData.h
//  LocalTest
//
//  Created by aReu on 2017/7/5.
//  Copyright © 2017年 CBswift. All rights reserved.
/*
    1.实现本地模拟数据   完成
    2.实现自定义真实数据加载  完成
    3.增加白名单，黑名单设置   先了解yyModel
    需要在这个星期前完成
 */

#import <Foundation/Foundation.h>

/*
    0.使用本地随机数据
    1.使用自定义真实数据
 */
#define iSUseLocalTureData 0

@interface zcLocalData : NSObject

@property (strong,nonatomic)NSArray *customArr;

+ (void)requestDataWithClass:(Class)className
                    callBack:(void(^)(id obj))callbackData;

@end
