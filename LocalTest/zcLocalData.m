//
//  zcLocalData.m
//  LocalTest
//
//  Created by aReu on 2017/7/5.
//  Copyright © 2017年 CBswift. All rights reserved.
//

#import "zcLocalData.h"
#include <objc/runtime.h>
#import <YYModel.h>


@implementation zcLocalData
#define force_inline __inline__ __attribute__((always_inline))
#define is(typeName)  [info.name.lowercaseString containsString:typeName]
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


- (NSArray*)customArr
{
    if (!_customArr) {
    }
    return _customArr;
}

/// Foundation Class Type
typedef NS_ENUM (NSUInteger, YYEncodingNSType) {
    YYEncodingTypeNSUnknown = 0,
    YYEncodingTypeNSString,
    YYEncodingTypeNSMutableString,
    YYEncodingTypeNSValue,
    YYEncodingTypeNSNumber,
    YYEncodingTypeNSDecimalNumber,
    YYEncodingTypeNSData,
    YYEncodingTypeNSMutableData,
    YYEncodingTypeNSDate,
    YYEncodingTypeNSURL,
    YYEncodingTypeNSArray,
    YYEncodingTypeNSMutableArray,
    YYEncodingTypeNSDictionary,
    YYEncodingTypeNSMutableDictionary,
    YYEncodingTypeNSSet,
    YYEncodingTypeNSMutableSet,
};

/// Get the Foundation class type from property info.
static force_inline YYEncodingNSType YYClassGetNSType(Class cls) {
    if (!cls) return YYEncodingTypeNSUnknown;
    if ([cls isSubclassOfClass:[NSMutableString class]]) return YYEncodingTypeNSMutableString;
    if ([cls isSubclassOfClass:[NSString class]]) return YYEncodingTypeNSString;
    if ([cls isSubclassOfClass:[NSDecimalNumber class]]) return YYEncodingTypeNSDecimalNumber;
    if ([cls isSubclassOfClass:[NSNumber class]]) return YYEncodingTypeNSNumber;
    if ([cls isSubclassOfClass:[NSValue class]]) return YYEncodingTypeNSValue;
    if ([cls isSubclassOfClass:[NSMutableData class]]) return YYEncodingTypeNSMutableData;
    if ([cls isSubclassOfClass:[NSData class]]) return YYEncodingTypeNSData;
    if ([cls isSubclassOfClass:[NSDate class]]) return YYEncodingTypeNSDate;
    if ([cls isSubclassOfClass:[NSURL class]]) return YYEncodingTypeNSURL;
    if ([cls isSubclassOfClass:[NSMutableArray class]]) return YYEncodingTypeNSMutableArray;
    if ([cls isSubclassOfClass:[NSArray class]]) return YYEncodingTypeNSArray;
    if ([cls isSubclassOfClass:[NSMutableDictionary class]]) return YYEncodingTypeNSMutableDictionary;
    if ([cls isSubclassOfClass:[NSDictionary class]]) return YYEncodingTypeNSDictionary;
    if ([cls isSubclassOfClass:[NSMutableSet class]]) return YYEncodingTypeNSMutableSet;
    if ([cls isSubclassOfClass:[NSSet class]]) return YYEncodingTypeNSSet;
    return YYEncodingTypeNSUnknown;
}


+ (void)requestDataWithClass:(Class)className
                    callBack:(void(^)(id obj))callbackData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((arc4random()%2 +1) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableArray *dataArr = @[].mutableCopy;
        
        if (iSUseLocalTureData) {
            NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"zcLocalJson" ofType:@"json"]];
            NSError *error;
            id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"当前模拟请求数据：%@",object);
            NSArray *localDataArr = [object objectForKey:@"data"];
            for (NSDictionary *dic in localDataArr) {
                id customObj = [className yy_modelWithDictionary:dic];
                [dataArr addObject:customObj];
            }
        }else{
            for (unsigned int num = 0; num < arc4random()%6 + 1; num++) {
                //转换模型
                id zcObj = [className new];
                [self creatData:className classObj:zcObj];
                NSLog(@"随机模拟请求数据：\n %@",[zcObj yy_modelToJSONString]);
                [dataArr addObject:zcObj];
            }
        }

        if (callbackData) callbackData(dataArr);
    });
}


+ (void)creatData:(Class)className
         classObj:(id)zcObj
{
    unsigned int proCount = 0;
    //TestModel
    objc_property_t *property = class_copyPropertyList(className,&proCount);
    if (property) {
        for (unsigned int i = 0; i < proCount; i++) {
            
            YYClassPropertyInfo *info = [[YYClassPropertyInfo alloc] initWithProperty:property[i]];
            
            //取出  判断是否对象 是：再查看里面的参数变量  否：设置数值
            if (info.cls && YYClassGetNSType(info.cls) == YYEncodingTypeNSUnknown) {
                //digui
                id objPro = [info.cls new];
                SEL setter = info.setter;
                if (setter &&[zcObj respondsToSelector:setter]) {
                    SuppressPerformSelectorLeakWarning([zcObj performSelector:setter withObject:objPro];);
                }
                [zcLocalData creatData:info.cls classObj:objPro];
                
            }else if (info.name){
                //赋予值
                if ([zcObj respondsToSelector:info.setter]) {
                    [zcLocalData setDataInObj:zcObj objProperty:info];
                }
            }
        }
    }
    free(property);
}



/**
 生成数据格式的规范

 @param currentObj 当前对象
 @param info 对象所获取的成员属性info
 */
+ (void)setDataInObj:(id)currentObj
        objProperty:(YYClassPropertyInfo*)info
{
    id type;
    if (is(@"state")) {
        type = [NSString stringWithFormat:@"%u",arc4random()%3 +1];
    }else if (is(@"id")){
        type = @"123456789012345678";
    }else if (is(@"code")){
        type = @"200";
    }else if (is(@"name")){
        type = @"MR.DaChun";
    }else{
        
    }
    if (info.setter) {
        SuppressPerformSelectorLeakWarning([currentObj performSelector:info.setter withObject:type];);
    }
}
/*
 IN common use
 imgUrl2:http://image.baidu.com/search/detail?z=0&ipn=d&word=小图片&step_word=&hs=0&pn=3&spn=0&di=83676835001&pi=&tn=baiduimagedetail&is=0%2C0&istype=2&ie=utf-8&oe=utf-8&cs=2617616091%2C2435857909&os=4263838187%2C39522739&simid=&adpicid=0&lpn=0&fm=&sme=&cg=&bdtype=0&simics=3738427855%2C530326667&oriquery=&objurl=http%3A%2F%2Fpic15.nipic.com%2F20110702%2F7275504_120017049321_2.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Fooo_z%26e3Bgtrtv_z%26e3Bv54AzdH3Ffi5oAzdH3F90bclcb_z%26e3Bip4s&gsm=0&cardserver=1
 
 */



@end
