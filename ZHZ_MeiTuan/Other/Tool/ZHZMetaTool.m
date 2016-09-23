
//
//  ZHZMetaTool.m
//  ZHZ_MeiTuan
//
//  Created by zhanghangzhen on 16/9/23.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import "ZHZMetaTool.h"
#import "ZHZCity.h"
#import "ZHZGategoty.h"
#import "ZHZSort.h"
#import "ZHZDeal.h"
#import "MJExtension.h"



static NSArray *_cities;
static NSArray *_categories;
static NSArray *_sorts;


@implementation ZHZMetaTool
/**
 *  返回城市
 */
+ (NSArray *)cities
{
    if (_cities == nil) {
        _cities = [ZHZCity objectArrayWithFilename:@"cities.plist"];
    }
    return _cities;
}

/**
 *  返回所有的分类数据
 */
+ (NSArray *)categories
{
    if (_categories == nil) {
        _categories = [ZHZGategoty objectArrayWithFilename:@"categories.plist"];
    }
    return _categories;
}

/**
 *  返回所有的排序数据
 */
+ (NSArray *)sorts
{
    if (_sorts == nil) {
        _sorts = [ZHZSort objectArrayWithFilename:@"sorts.plist"];
    }
    return _sorts;
}
+ (ZHZGategoty *)categoryWithDeal:(ZHZDeal *)deal
{
    NSArray *cs = [self categories];
    NSString *cname = [[deal.categories firstObject] substringToIndex:1];
    //    NSLog(@"----%@",cname);
    for (ZHZGategoty *c in cs) {
        if ([c.name containsString:cname]) return c;
        
        for (NSString *obj in c.subcategories) {
            if ([obj containsString:cname]) {
                return c;
            }
        }
    }
    return nil;
}
@end
