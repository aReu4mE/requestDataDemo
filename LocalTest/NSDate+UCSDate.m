//
//  NSDate+UCSDate.m
//  EWallet
//
//  Created by tom on 14-7-14.
//  Copyright (c) 2014年 ucsmy. All rights reserved.
//

#import "NSDate+UCSDate.h"

@implementation NSDate (UCSDate)
/**
 时间戳转换成固定格式
 
 @param timestamp 时间戳
 @param toFrommat 格式化
 @return 返回时间戳转换成固定格式
 */
+ (NSString *)formatWithUnixTimestamp:(NSString *)timestamp toFormart:(NSString*)toFrommat
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp.integerValue * 0.001];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat= toFrommat;
    NSString *str= [formatter stringFromDate:confromTimesp];
    return str;
}
+(NSDateFormatter*)formatter{
    static dispatch_once_t pred;
	static NSDateFormatter *sharedInstance = nil;
	dispatch_once(&pred, ^{
        sharedInstance = [[NSDateFormatter alloc] init];
    });
	return sharedInstance;

}

+(NSString*)formatWithStr:(NSString*)dateStr{
   return [NSDate formatWithDate:[NSDate formatWithDateStr:dateStr]];
}

+(NSString *)currentYearAndMonth{
    [[NSDate formatter] setDateFormat:@"yyyy-MM"];
    NSString *str = [[NSDate formatter] stringFromDate:[NSDate date]];
    return str;
}
+(NSString *)currentTime{
    [[NSDate formatter] setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *str = [[NSDate formatter] stringFromDate:[NSDate date]];
    return str;
}

+(NSString*)formatWithDate:(NSDate*)date{
    return [self formatWithDate:date toFormart:@"yyyy-MM-dd HH:mm:ss"];
}
+ (NSString *)formatWithDate:(NSDate *)date toFormart:(NSString *)toFrommat
{
    [[NSDate formatter] setDateFormat:toFrommat];
    NSString *str = [[NSDate formatter] stringFromDate:date];
    return str;
}

+(NSDate*)formatWithDateStr:(NSString*)str{
    [[NSDate formatter] setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    NSDate *date = [[NSDate formatter] dateFromString:str];
    return date;
}

+(NSDate*)formatWithDateStr:(NSString*)str format:(NSString *)format{
    [[NSDate formatter] setDateFormat:format];
    NSDate *date = [[NSDate formatter] dateFromString:str];
    return date;
}

+(NSString*)formatDate:(NSString*) dateStr fromFormat:(NSString*)fromFormat toFormart:(NSString*)toFrommat{
    [[NSDate formatter] setDateFormat:fromFormat];
    NSDate *date = [[NSDate formatter] dateFromString:dateStr];
    [[NSDate formatter] setDateFormat:toFrommat];
    NSString *str = [[NSDate formatter] stringFromDate:date];
    return str;
}



@end
