//
//  NSString+Extension.h
//  大嘴鱼
//
//  Created by DianZhi on 15/8/13.
//  Copyright (c) 2015年 DianZhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Extension)

/**
 *  根据字体计算大小
 *
 *  @param font 字体
 *
 *
 */
- (CGSize)sizeWithFont:(UIFont *)font;

/**
 *  根据字体计算大小
 *
 *  @param font 字体
 *  @param maxSize 最大宽高
 *
 *
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 *  判断是否为电话号码
 */
- (BOOL)isPhoneNumber;

/**
 * 判断是否为email
 */
- (BOOL)isEmail;

/**
 *判断是否为邮箱
 */
- (BOOL)isPostCode;
/**
 *  生成验证码
 */
+ (NSString *)capNumberStr;


/**
 * 去除末尾的0
 */
- (NSString *)deleteTailZero;

///**
// *  md5
// *
// *  @return md5的字符串
// */
//- (NSString *)md5;
/**
 * 判断是否为整数
 */
- (BOOL)isNumber;


/**
 判断是否为小数
 */
- (BOOL)isFloatNumber;

/**
 *时间戳转字符串
 */
- (NSString *)timeStrWithFormart:(NSString *)formart;

/**
 *距离现在的时分秒
 */
- (NSString *)leftTimeScinceNow;


/**
 剩余天数
 */
- (NSString *)leftDays;


/**
 电话号码打码 13954875487 -> 139****5487
 */
- (NSString *)addSecWithPhoneNum;

/**
 json字符串转字典
 */
- (NSDictionary *)jsonStringToDic;


//字符串UTF8编码
- (NSString *)encodingWithString;

//判断密码是否合法
-(BOOL)isValidPassWord;
////sha1加密
//- (NSString *)sha1;

//键值对转字典,形如下面的字符串
/*
 *@"app://getHxOrderInfo?id=4560&name=联想(Lenovo)拯救者R720 15.6英寸游戏笔记本电脑(i5-7300HQ 8G 1T+128G SSD GTX&price=1000.0&img=2017/11/17/0fc9757c-e26e-48e8-a6ee-18a23303a0c5.jpg&url=http://192.168.0.254:8080//views/4560"
 */
-(NSDictionary*)tranformStringToDictionary;
//是否包含中文
- (BOOL)includeChinese;

/**
 字符串添加中线
 @return 返回添加后的字符串
 */
- (NSMutableAttributedString*)stringAddMidLine;

/**
 是否是字母加数字的13-18位注册号
 */
- (BOOL)isNumberAndAlphabet;

/**
 *  比较线上版本与本地版本
 *
 *  @param version 线上版本
 *  返回值 是否需要更新
 */
-(BOOL)compareVerionWithOnLineVersion:(NSString*)version;

// 判断身份证是否是真实的
- (BOOL)isValidateIDCardNumber;
@end
