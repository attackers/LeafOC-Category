//
//  UITextField+Category.m
//  Floor
//
//  Created by leaf on 2018/3/22.
//  Copyright © 2018年 leaf. All rights reserved.
//

#import "UITextField+Category.h"
@implementation UITextField (Category)

- (void)textFieldShowLeftview:(NSString*)text  ShowImg:(UIImage*)img LeftviewBound:(CGRect)rect{
    if (text != nil && text.length > 0) {
      

    } else {
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:rect];
        imageview.contentMode = UIViewContentModeScaleAspectFit;
        imageview.image = img;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftView = imageview;
    }
}

- (void)textFieldShowRightview:(NSString*)text  ShowImg:(UIImage*)img RightviewBound:(CGRect)rect{
    if (text != nil && text.length > 0) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:rect];
        label.text = text;
        self.rightViewMode = UITextFieldViewModeAlways;
        self.rightView = label;
        
    } else {
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:rect];
        imageview.contentMode = UIViewContentModeScaleAspectFit;
        imageview.image = img;
        self.rightViewMode = UITextFieldViewModeAlways;
        self.rightView = imageview;
    }
}

- (UILabel*)textFieldRightView:(NSString*)content leftContent:(NSString*)lStg baseFrame:(CGRect)bRect{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject: (id)[UIFont systemFontOfSize:15] forKey:NSFontAttributeName];
    
    CGRect leftRect = [lStg boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    CGRect bound = [content boundingRectWithSize:CGSizeMake(CGRectGetWidth(bRect) - CGRectGetWidth(leftRect) - 8, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(bound) + 8, CGRectGetHeight(bound))];
    label.text = content;
    label.font = [UIFont systemFontOfSize:15];
    label.numberOfLines = 99;
    label.textColor = [UIColor grayColor];
    return label;
}
@end
