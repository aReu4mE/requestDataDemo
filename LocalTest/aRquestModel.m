//
//  aRquestModel.m
//  MusicGetPro
//
//  Created by aReu on 2016/11/14.
//  Copyright © 2016年 aReu. All rights reserved.
//

#import "aRquestModel.h"
#import "NeteaseMusicAPI.h"

@implementation aRquestModel

+ (NSDictionary *)dictionaryWithJsonString:(NSData *)data {
    if (data == nil) return nil;
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+(void)requesWangyYunByName:(NSString*)songName
                 Block:(void (^)(NSMutableArray *arr))cb
{
    NeteaseMusicAPICompletionHandler handler = ^(NSData *data, NSURLResponse *response, NSError *error) {
        NSMutableArray *newArr = @[].mutableCopy;
        if (data) {
            NSDictionary *dic = [self dictionaryWithJsonString:data];
            NSArray *arr = dic[@"result"][@"songs"];
            for (NSDictionary *temDic in arr) {
//                aRModel *temModel = [aRModel new];
//                temModel.pic = temDic[@"album"][@"picUrl"];
//                temModel.fMian = temDic[@"album"][@"blurPicUrl"];
//                temModel.title = temDic[@"name"];
//                temModel.author = temDic[@"artists"][0][@"name"];
//                temModel.url = temDic[@"mp3Url"];
//                [newArr addObject:temModel];
            }
        }
        cb(newArr);
    };
    [NeteaseMusicAPI searchWithQuery:songName type:NMSearch_Music offset:0 limit:15 completionHandler:handler];
}

@end
