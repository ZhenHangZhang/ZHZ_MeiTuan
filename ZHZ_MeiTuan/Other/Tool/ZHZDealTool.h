//
//  ZHZDealTool.h
//  ZHZ_MeiTuan
//
//  Created by zhanghangzhen on 16/9/23.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZHZDeal;
/**
 处理数据缓存用FMDB
 */
@interface ZHZDealTool : NSObject


+ (void)addCollectionDeal:(ZHZDeal *)deal;
+ (void)removeCollectionDeal:(ZHZDeal *)deal;

+ (NSArray *)collectDeals:(int)page;
+ (int)collectDealsCount;
+ (BOOL)isCollected:(ZHZDeal *)deal;
+ (void)addBrowseDeal:(ZHZDeal *)deal;
+ (void)removeBrowseDeal:(ZHZDeal *)deal;
+ (NSArray *)browseDeals:(int)page;
+ (int)browseDealsCount;
+ (BOOL)isBrowsed:(ZHZDeal *)deal;
@end
