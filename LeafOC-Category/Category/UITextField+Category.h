//
//  UITextField+Category.h
//  Floor
//
//  Created by leaf on 2018/3/22.
//  Copyright © 2018年 leaf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Category)

/**
 设置左边显示的view的内容，文字与图片只能显示一种

 @param text 需要显示的内容
 @param img 需要显示图片
 @param rect 左边视图的大小
 */
- (void)textFieldShowLeftview:(NSString*)text  ShowImg:(UIImage*)img LeftviewBound:(CGRect)rect;

/**
 设置右边显示的view的内容，文字与图片只能显示一种

 @param text 需要显示的内容
 @param img 需要显示图片
 @param rect 右边视图的大小
 */
- (void)textFieldShowRightview:(NSString*)text  ShowImg:(UIImage*)img RightviewBound:(CGRect)rect;

/**
 只显示带文字的左边视图

 @param content 文字的内容
 @param rect textfield的Rect,主要用来设置文子展示的高度
 @return 返回要展示的视图
 */
- (UILabel*)textFieldLeftView:(NSString*)content ViewFrame:(CGRect)rect;

/**
 只显示带文字的右边视图，
 @param content 文字的内容
 @param lStg 左边的文字内容，主要用来计算左边的宽度，用以做右边视图的x坐标
 @param bRect textfield的Rect,主要用来设置文子展示的高度
 @return 返回要展示的视图
 */
- (UILabel*)textFieldRightView:(NSString*)content leftContent:(NSString*)lStg baseFrame:(CGRect)bRect;
@end
