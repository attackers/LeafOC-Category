//
//  NSDictionary+Category.m
//  Floor
//
//  Created by leaf on 2018/3/21.
//  Copyright © 2018年 leaf. All rights reserved.
//

#import "NSDictionary+Category.h"

@implementation NSDictionary (Category)
- (void)toModel:(id)model {
    NSArray *keys = self.allKeys;
    for (NSString *key in keys) {
      objc_property_t  property =  class_getProperty([model class], [key UTF8String]);
        if (property != nil) {
            NSString *value = [NSString stringWithFormat:@"%@",[self objectForKey:key]];
            [model setValue:value forKey:key];
        }
    }
}
+ (NSMutableDictionary*)modelToDictionary:(id)model {
    unsigned  int outCount = 0;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    objc_property_t *propertyList =  class_copyPropertyList([model class], &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = propertyList[i];
        const char *char_f = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:char_f];
        id objcContent  = [model valueForKey:name];
        if (objcContent) {
            [dic setObject:objcContent forKey:name];
        }
    }
    free(propertyList);
    return  dic;
}
@end
