//
//  NSDictionary+Category.h
//  Floor
//
//  Created by leaf on 2018/3/21.
//  Copyright © 2018年 leaf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSDictionary (Category)
- (void)toModel:(id)model;
+ (NSMutableDictionary*)modelToDictionary:(id)model;
@end
