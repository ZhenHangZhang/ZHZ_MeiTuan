//
//  ZHZGategoty.h
//  ZHZ_MeiTuan
//
//  Created by zhanghangzhen on 16/9/23.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHZGategoty : NSObject
/** 类别的名称 */
@property (nonatomic, copy) NSString *name;

/** 子类别:字符串(子类别的名称) */
@property (nonatomic, strong) NSArray *subcategories;

/** 显示在下拉菜单的小图标 */
@property (nonatomic, copy) NSString *small_highlighted_icon;
@property (nonatomic, copy) NSString *small_icon;

/** 显示在导航栏顶部的大图标 */
@property (nonatomic, copy) NSString *highlighted_icon;
@property (nonatomic, copy) NSString *icon;

/** 显示在地图上的图标 */
@property (nonatomic, copy) NSString *map_icon;
@end
