//
//  UIView+Extension.h
//  简化viewXY宽高等的设置
//
//  Created by DianZhi on 15/8/7.
//  Copyright (c) 2015年 DianZhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
/** frame的X */
@property (assign, nonatomic) CGFloat x;

/** frame的Y */
@property (assign, nonatomic) CGFloat y;

/** frame的width */
@property (assign, nonatomic) CGFloat width;

/** frame的height */
@property (assign, nonatomic) CGFloat height;

/** 中点的X */
@property (assign, nonatomic) CGFloat centerX;

/** 中点的Y */
@property (assign, nonatomic) CGFloat centerY;

/** frame的origin */
@property (assign, nonatomic) CGPoint origin;

/** frame的size */
@property (assign, nonatomic) CGSize size;

/** frame的MaxX */
@property (assign, nonatomic,readonly) CGFloat maxX;

/** frame的MaxY */
@property (assign, nonatomic,readonly) CGFloat maxY;
@end
