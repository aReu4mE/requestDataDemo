//
//  aRquestModel.h
//  MusicGetPro
//
//  Created by aReu on 2016/11/14.
//  Copyright © 2016年 aReu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface aRquestModel : NSObject


//网易云
+(void)requesWangyYunByName:(NSString*)songName
                      Block:(void (^)(NSMutableArray *arr))cb;

@end
