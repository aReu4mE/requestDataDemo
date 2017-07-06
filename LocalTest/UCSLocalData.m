//
//  UCSLocalData.m
//  HJShipper
//
//  Created by xiexy on 2017/6/12.
//  Copyright © 2017年 UCSMY. All rights reserved.
//

#import "UCSLocalData.h"
#import <YYModel.h>
#import "NSDate+UCSDate.h"

@interface UCSLocalData ()

@end

@implementation UCSLocalData
#define force_inline __inline__ __attribute__((always_inline))

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


+ (void)testWithobject:(id)object
{
    Class className = [object class];
    if([NSStringFromClass(className) isEqualToString:NSStringFromClass([NSObject class])])
    {
        return;
    }
    if(object == nil) return;
    
    [self setValueWithClassName:[object class] forObj:object];
    
//    YYClassInfo *curClassInfo =  [YYClassInfo classInfoWithClass:className];
//    while (curClassInfo && curClassInfo.superCls != nil) { // recursive parse super class, but ignore root class (NSObject/NSProxy)
//        
//        [self setValueWithClassName:curClassInfo.superCls forObj:object];
//        curClassInfo = curClassInfo.superClassInfo;
//    }
}

+ (void)setValueWithClassName:(Class)className forObj:(id)object
{
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(className, &propertyCount);
    if (properties) {
        for (unsigned int i = 0; i < propertyCount; i++) {
            YYClassPropertyInfo *info = [[YYClassPropertyInfo alloc] initWithProperty:properties[i]];
            YYEncodingNSType type = YYClassGetNSType(info.cls);
            if(info.cls != nil &&type == YYEncodingTypeNSUnknown)
            {
                id _id = nil;
                if([info.cls isSubclassOfClass:[NSObject class]])
                {
                    _id = [info.cls new];
                }
                
                if(_id)
                {
                    if([object respondsToSelector:info.setter])
                    {
                        [object performSelector:info.setter withObject:_id];
                        [self setValueWithClassName:info.cls forObj:_id];
                    }
                }
                continue;
            }
            if (info.name )
            {
                if(![self blackP:info.name])
                {
                    if([object respondsToSelector:info.setter])
                    {
                        const char * cName = sel_getName(info.setter);
                        NSString *selName = [NSString stringWithUTF8String:cName];
                        if([selName isEqualToString:@"setCode:"])
                        {
                            [object performSelector:info.setter withObject:@"100"];
                        }else if([selName isEqualToString:@"setMessage:"])
                        {
                            [object performSelector:info.setter withObject:@"本地挡板数据..."];
                        }else if([selName isEqualToString:@"setLastIndex:"])
                        {
                            [object performSelector:info.setter withObject:@"10"];
                        }
                        else{
                            if([NSStringFromClass(info.cls) isEqualToString:NSStringFromClass([NSString class])])
                            {
                                [object performSelector:info.setter withObject:[self getValueWithPropertyInfo:info]];
                            }else if([NSStringFromClass(info.cls) isEqualToString:NSStringFromClass([NSArray class])])
                            {
                                //UCSInvestProjectInfoModel
                                if ([className respondsToSelector:@selector(modelContainerPropertyGenericClass)]) {
                                    NSDictionary *genericMapper = [(id<YYModel>)className modelContainerPropertyGenericClass];
                                    
                                    
                                    [genericMapper enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                                        
                                        if([info.name isEqualToString:key])
                                        {
                                            NSMutableArray *arrM = [NSMutableArray array];
                                            for (int i = 0 ; i< 10; i++) {
                                                id _item = [obj new];
                                                [arrM addObject:_item];
                                                [self testWithobject:_item];
                                            }
                                            [object performSelector:info.setter withObject:arrM];
                                        }
                                        
                                    }];
                                    
                                }else
                                {
                                    NSMutableArray *arrM = [NSMutableArray array];
                                    for (int i = 0 ; i< 10; i++) {
                                        [arrM addObject:[self getValueWithPropertyInfo:info]];
                                    }
                                    [object performSelector:info.setter withObject:arrM];
                                }
                            }else
                            {
                                // NSAssert(info.cls, @"此处添加对应的代码.自动生成赋值");
                                //  UCSLog(@"%@ ===========> 没有赋值成功,请检查",info.name);
                            }
                        }
                        
                    }
                }
            }
        }
        free(properties);
    }
}

/**
 请根据具体问题.具体添加白名单
 
 @param info YYClassPropertyInfo
 @return 返回本地挡板数据
 */
+ (NSString *)getValueWithPropertyInfo:(YYClassPropertyInfo *)info
{
    
    NSString *selName = info.name;
    NSString *selName_low = selName.lowercaseString;
    if([selName_low containsString:@"time"] || [selName_low containsString:@"date"] || [selName_low containsString:@"expire"])
    {
        return [NSDate formatWithDate:[NSDate date] toFormart:@"yyyy-MM-dd-HH:mm:ss"];
    }
    if([selName_low hasSuffix:@"id"])
    {
        static int i = 0;
        i++;
        return [NSString stringWithFormat:@"%@",@(i)];
    }
    if([selName_low hasSuffix:@"type"] || [selName_low hasSuffix:@"state"] || [selName_low hasPrefix:@"is"] ||  [selName_low containsString:@"hasdispute"] ||  [selName_low containsString:@"needmidport"] || [selName_low containsString:@"paycondition"])
    {
        uint32_t i = arc4random_uniform(4);
        return  [NSString stringWithFormat:@"%@",@(i)];
    }
    if([selName_low containsString:@"height"] || [selName_low containsString:@"width"])
    {
        uint32_t i = arc4random_uniform(100);
        return  [NSString stringWithFormat:@"%@",@(i)];
    }
    if([selName_low containsString:@"amount"] || [selName_low containsString:@"total"] || [selName_low containsString:@"shipcallsign"] || [selName_low containsString:@"fueling"] || [selName_low containsString:@"capacity"] || [selName_low containsString:@"weight"] || [selName_low containsString:@"goodsremain"] || [selName_low containsString:@"mybalance"])
    {
        uint32_t i = arc4random_uniform(12000);
        return  [NSString stringWithFormat:@"%@",@(i)];
    }
    
    if([selName_low containsString:@"mobile"])
    {
        return @"13800138000";
    }
    
    if ([selName_low containsString:@"bankname"]) {
        return @"中国人民很行";
    }
    
    if ([selName_low containsString:@"banklogourl"]) {
        return @"http:\/\/yaodu.ucsmy.com\/\/Content\/images\/bankLogo\/bank_icon_icbc.png";
    }
    
    if ([selName_low containsString:@"cardNumber"]) {
        return @"621133334444555510";
    }
    
    
    return @"ssssssssssssssssssssssssssss";
}

+ (BOOL)blackP:(NSString *)pname
{
    NSArray *arr = @[
                     @"hash",
                     @"description",
                     @"superclass",
                     @"debugDescription",
                     ];
    return [arr containsObject:pname];
}

+ (void)localDataWithClass:(__unsafe_unretained Class)className callBack:(void(^)(id _id))callBack
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(arc4random_uniform(5)+1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        id _id = nil;
//        if([NSStringFromClass(className) isEqualToString:@"UCSMainProvinceListModel"])
//        {
//           _id = [self makeUCSMainProvinceListModel];
//        }
        if(!_id) _id = [className new];
        [self testWithobject:_id];
        !callBack? : callBack(_id);
        
    });
}



//+ (id)makeUCSMainProvinceListModel
//{
//    //UCSMainProvinceListModel
//    return nil;
//}


@end
