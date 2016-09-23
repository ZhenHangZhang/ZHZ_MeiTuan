//
//  ZHZConst.h
//  ZHZ_MeiTuan
//
//  Created by zhanghangzhen on 16/9/23.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#define ZHZLog(...) NSLog(__VA_ARGS__)
#else
#define ZHZLog(...)
#endif

#define ZHZColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define ZHZGlobalBg ZHZColor(230, 230, 230)

extern NSString *const ZHZCityDidChangeNotification;
extern NSString *const ZHZSelectedCityName;

extern NSString *const ZHZSortDidChangeNotification;
extern NSString *const ZHZSelectSort;

extern NSString *const ZHZCategoryDidChangeNotification;
extern NSString *const ZHZSelectCategory;
extern NSString *const ZHZSelectSubcategoryName;

extern NSString *const ZHZRegionDidChangeNotification;
extern NSString *const ZHZSelectRegion;
extern NSString *const ZHZSelectSubregionName;

extern NSString *const ZHZCollectStateDidChangeNotification;
extern NSString *const ZHZIsCollectKey;
extern NSString *const ZHZCollectDealKey;
