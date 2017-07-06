//
//  NSDate+UCSDate.h
//  EWallet
//
//  Created by tom on 14-7-14.
//  Copyright (c) 2014年 ucsmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (UCSDate)

/**
 时间戳转换成固定格式

 @param timestamp 时间戳
 @param toFrommat 格式化
 @return 返回时间戳转换成固定格式
 */
+ (NSString *)formatWithUnixTimestamp:(NSString *)timestamp toFormart:(NSString*)toFrommat;

/**
 格式化时间

 @param dateStr 时间(string)
 @return 返回:yyyy-MM-dd HH:mm:ss
 */
+(NSString*)formatWithStr:(NSString*)dateStr;

/**
 格式化时间

 @param date 时间(date)
 @return 返回:yyyy-MM-dd HH:mm:ss
 */
+(NSString*)formatWithDate:(NSDate*)date;

/**
 字符串转 date

 @param str 时间(string)
 @return  返回 date:MM/dd/yyyy HH:mm:ss
 */
+(NSDate*)formatWithDateStr:(NSString*)str;

/**
 字符串转 date

 @param str  时间(string)
 @param format 格式化格式
 @return 返回 date;
 */
+(NSDate*)formatWithDateStr:(NSString*)str format:(NSString *)format;

/**
 返回当前年月

 @return 返回当前年月:yyyy-MM
 */
+(NSString*)currentYearAndMonth;

/**
 返回当前时间

 @return 返回当前年月:yyyy/MM/dd HH:mm:ss
 */
+(NSString*)currentTime;

/**
 格式化时间

 @param dateStr 时间(string)
 @param fromFormat  dateStr格式化格式
 @param toFrommat 转为  toFrommat格式
 @return 返回指定格式化时间
 */
+(NSString*)formatDate:(NSString*) dateStr fromFormat:(NSString*)fromFormat toFormart:(NSString*)toFrommat;

/**
 格式化时间

 @param date 指定 date 时间
 @param toFrommat 转为  toFrommat格式
 @return 返回指定格式化时间
 */
+(NSString*)formatWithDate:(NSDate*)date  toFormart:(NSString*)toFrommat;

@end
