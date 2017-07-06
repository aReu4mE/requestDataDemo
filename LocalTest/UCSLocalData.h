//
//  UCSLocalData.h
//  HJShipper
//
//  Created by xiexy on 2017/6/12.
//  Copyright © 2017年 UCSMY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UCSLocalData : NSObject
+ (void)localDataWithClass:(__unsafe_unretained Class)className callBack:(void(^)(id _id))callBack;
+ (void)testWithobject:(id)object;
@end
