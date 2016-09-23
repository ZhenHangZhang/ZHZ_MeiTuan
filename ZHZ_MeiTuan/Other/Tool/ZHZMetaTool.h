//
//  ZHZMetaTool.h
//  ZHZ_MeiTuan
//
//  Created by zhanghangzhen on 16/9/23.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import <Foundation/Foundation.h>


@class ZHZGategoty,ZHZDeal;

@interface ZHZMetaTool : NSObject
/**
 *  返回城市
 */
+ (NSArray *)cities;

/**
 *  返回所有的分类数据
 */
+ (NSArray *)categories;

/**
 *  返回所有的排序数据
 */
+ (NSArray *)sorts;



+(ZHZGategoty*)categoryWithDeal:(ZHZDeal*)deal;

@end
