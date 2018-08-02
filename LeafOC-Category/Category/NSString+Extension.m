//
//  NSString+Extension.m
//  大嘴鱼
//
//  Created by DianZhi on 15/8/13.
//  Copyright (c) 2015年 DianZhi. All rights reserved.
//

#import "NSString+Extension.h"
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonCrypto.h>
#import<CommonCrypto/CommonDigest.h>

@implementation NSString (Extension)

- (CGSize)sizeWithFont:(UIFont *)font {

    CGSize maxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    
    
    
    return [self sizeWithFont:font maxSize:maxSize];
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
 
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+ (NSString *)capNumberStr {
    NSUInteger random = arc4random() % 8999 + 1000;
    
    return [NSString stringWithFormat:@"%lu",(unsigned long)random];
}

- (BOOL)isPhoneNumber {

    NSString *regex = @"^[1][345789][0-9]{9}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:self];
    
    return isMatch;
}
- (BOOL)isNumberAndAlphabet{
    NSString *regex = @"^([0-9]|[a-z]|[A-Z]){13,18}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:self];
    
    return isMatch;
}
- (BOOL)isNumber {
    NSString *regex = @"^\\d+$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

- (BOOL)isFloatNumber {
    NSString *regex = @"^\\d+(\\.\\d+)?$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
    
}

- (BOOL)isEmail {
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    BOOL isMatch = [pred evaluateWithObject:self];
    
    return isMatch;
}

- (BOOL)isPostCode {
    NSString *regex = @"^[43][0-9]{4}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:self];
    
    return isMatch;
}

- (NSString *)deleteTailZero {
    if ([self hasSuffix:@".00"]) {
        return [self substringToIndex:self.length - 3];
    }
    
    if ([self hasSuffix:@"0"]&&[self containsString:@"."]) {
        return [self substringToIndex:self.length - 1];
    }
    
    return self;
}

-(BOOL)compareVerionWithOnLineVersion:(NSString*)version{
    NSArray * v1Array = [self componentsSeparatedByString:@"."];
    NSArray * v2Array = [version componentsSeparatedByString:@"."];
    for (int i = 0; i < v1Array.count && i < v2Array.count; i++) {
        NSString * str1 = v1Array[i];
        NSString * str2 = v2Array[i];
        NSInteger num1 = [str1 intValue];
        NSInteger num2 = [str2 intValue];
        if(num1 < num2){
            return YES;
        }
        if(num1 > num2){
            return NO;
        }
    }
    return NO;
}
//
///**
// *  MD5加密
// */
//- (NSString *)md5
//{
//    const char *cStr = [self UTF8String];
//    unsigned char result[16];
//
//    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
//    return [NSString stringWithFormat:
//            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
//            result[0], result[1], result[2], result[3],
//            result[4], result[5], result[6], result[7],
//            result[8], result[9], result[10], result[11],
//            result[12], result[13], result[14], result[15]
//            ];
//}

/**
 *  MD5加密
 */
- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, strlen(cStr), result);
    
    NSMutableString *resultString = [NSMutableString string];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [resultString appendFormat:@"%02X",result[i]];
    }
    return resultString;
    
}


- (NSString *)timeStrWithFormart:(NSString *)formart
{
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = formart;
    NSString *confromTimespStr = [fmt stringFromDate:timeDate];
   
    return confromTimespStr;
}

//- (NSString *)timeStrWithFormart:(NSString *)formart {
//    NSTimeInterval time = [self doubleValue];
//    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:time];
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    fmt.dateFormat = formart;
//    
//    return [fmt stringFromDate:timeDate];
//}

- (NSString *)leftTimeScinceNow {
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval endTime = [self doubleValue];
    long long delta =  (long long)(endTime - now);
    if (delta < 0) {
        return nil;
    }
    NSInteger hour = (NSInteger)delta / 3600;
    NSInteger min = (delta % 3600) / 60;
    NSInteger sec = delta % 60;
    
    return [NSString stringWithFormat:@"%zd:%02zd:%02zd",hour,min,sec];
}

- (NSString *)leftDays{
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval timeTamp = [self longLongValue];
    NSInteger delta = timeTamp - now;
    if (delta < 0) {
        NSString *timeLimt = @"已截止";
        return timeLimt;
        
    }
    NSUInteger day = delta / (3600 *24);
    NSUInteger h = (delta % (3600 * 24)) / 3600 ;
    NSUInteger min = (delta % 3600) / 60;
    NSUInteger second = delta % 60;
    
    if (day) {
        NSString *timeLimit = [NSString stringWithFormat:@"还剩%zd天%02zd小时%02zd分%02zd秒",day,h,min,second];
        return timeLimit;
    }
    
    NSString *timeLimit = [NSString stringWithFormat:@"还剩%02zd小时%02zd分%02zd秒",h,min,second];
    return timeLimit;
}

- (NSString *)addSecWithPhoneNum {
    if (self.length < 11) {
        return nil;
    }
    return [NSString stringWithFormat:@"%@****%@", [self substringToIndex:3],[self substringFromIndex:8]];
}

/**
 字符串转字典
 */
- (NSDictionary *)jsonStringToDic
{
    NSString *str = [self stringByRemovingPercentEncoding];
    if ([str isEqualToString:@""]) {
        NSLog(@"去Utf8格式化失败");
        return nil;
    }
    else
    {
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        if (!(data.bytes>0)) {
            NSLog(@"字符串转data失败");
            return nil;
        }
        else
        {
            NSError *error;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            if (error != nil) {
                NSLog(@"%@",error);
                NSLog(@"js转字典失败");
            }
            return dic;
        }
    }
}

//字符串UTF8编码
- (NSString *)encodingWithString
{
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
}

//判断密码是否合法
-(BOOL)isValidPassWord
{
    //6-18位数字和字母组成
    if((self.length>=6)&&(self.length<=16)){
        NSString *regex =  @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
        NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        if ([pred evaluateWithObject:self]) {
            return YES ;
        }else
            return NO;
    }else{
        return NO;
    }
}

- (NSString *)sha1
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

-(NSDictionary*)tranformStringToDictionary{
    NSArray *array = [self componentsSeparatedByString:@"?"];
    NSString *dataStr = [array lastObject];
    NSArray *keyValueArr = [dataStr componentsSeparatedByString:@"&"];
    NSMutableDictionary *dic = [NSMutableDictionary new];
    for(NSString *keyValueStr in keyValueArr){
    NSArray *dicArray = [keyValueStr componentsSeparatedByString:@"="];
        if(dicArray.count == 2){
            [dic setObject:dicArray[1] forKey:dicArray[0]];
        }
    }
    return dic;
}
//是否包含中文
- (BOOL)includeChinese
{
    for(int i=0; i< [self length];i++)
    {
        int a =[self characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}

- (NSMutableAttributedString*)stringAddMidLine {
    NSMutableAttributedString *mStg = [[NSMutableAttributedString alloc]initWithString:self];
    NSMutableDictionary *attributesDic = [NSMutableDictionary dictionary];
    [attributesDic setValue:[UIFont systemFontOfSize:13] forKey:NSFontAttributeName];
    [attributesDic setValue:[NSNumber numberWithInteger:NSUnderlineStyleThick] forKey:NSStrikethroughStyleAttributeName];
    [attributesDic setValue:[NSNumber numberWithInteger:NSUnderlineStyleNone] forKey:NSBaselineOffsetAttributeName];

    [attributesDic setValue:[UIColor grayColor] forKey:NSForegroundColorAttributeName];
    [mStg addAttributes:attributesDic range:NSMakeRange(0, self.length)];
    return  mStg;
}

// 判断身份证是否是真实的
- (BOOL)isValidateIDCardNumber
{
    NSString *value = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length = 0;
    
    if (!self) {
        return NO;
    }else {
        length = value.length;
        if (length != 15 && length != 18) {
            return NO;
        }
    }
    
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO;
    
    for (NSString *areaCode in areasArray) {
        
        if ([areaCode isEqualToString:valueStart2]){
            areaFlag = YES;
            break;
        }
    }
    
    if (!areaFlag){
        return NO;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    NSInteger year = 0;
    
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            if(numberofMatch > 0) {
                return YES;
            }else {
                return NO;
            }
            
        case 18:
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
                
            }else {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
                
            }
            
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            if(numberofMatch > 0) {
                
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value  substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value  substringWithRange:NSMakeRange(3,1)].intValue + [value  substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value  substringWithRange:NSMakeRange(4,1)].intValue + [value  substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value  substringWithRange:NSMakeRange(5,1)].intValue + [value  substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value  substringWithRange:NSMakeRange(6,1)].intValue + [value  substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value  substringWithRange:NSMakeRange(7,1)].intValue *1 + [value  substringWithRange:NSMakeRange(8,1)].intValue *6 + [value  substringWithRange:NSMakeRange(9,1)].intValue *3;
                
                int Y = S %11;
                
                NSString *M =@"F";
                
                NSString *JYM =@"10X98765432";
                
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    
                    return YES;// 检测ID的校验位
                    
                }else {
                    return NO;
                }
            }else {
                return NO;
            }
            
        default:
            return NO;
            
    }
}

@end
