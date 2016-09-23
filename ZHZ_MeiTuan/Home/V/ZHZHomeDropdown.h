//
//  ZHZHomeDropdown.h
//  ZHZ_MeiTuan
//
//  Created by zhanghangzhen on 16/9/23.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ZHZHomeDropdown;

@protocol ZHZHomeDropdownDataSource <NSObject>
/**
 *  左边表格一共有多少行
 */
- (NSUInteger)numberOfRowsInMainTable:(ZHZHomeDropdown *)homeDropdown;

/**
 *  左边表格每一行的标题
 *
 */
- (NSString *)homeDropdown:(ZHZHomeDropdown *)homeDropdown titleForRowInMainTable:(NSUInteger)row;

/**
 *  左边表格每一行的子数据
 *
 */
- (NSArray *)homeDropdown:(ZHZHomeDropdown *)homeDropdown subDataForRowInMainTable:(NSUInteger)row;

@optional
/**
 *  左边表格每一行的图标
 *
 */
- (NSString *)homeDropdown:(ZHZHomeDropdown *)homeDropdown normalIconForRowInMainTable:(NSUInteger)row;

/**
 *  左边表格每一行的选中图标
 *
 */
- (NSString *)homeDropdown:(ZHZHomeDropdown *)homeDropdown selectedIconForRowInMainTable:(NSUInteger)row;
@end

@protocol ZHZHomeDropdownDelegate <NSObject>
- (void)homeDropdown:(ZHZHomeDropdown *)homeDropdown didSelectedRowInMainTable:(int)row;

- (void)homeDropdown:(ZHZHomeDropdown *)homeDropdown didSelectedRowInSubTable:(int)subRow mainRow:(int)mainRow;
@end






@interface ZHZHomeDropdown : UIView

@property (nonatomic, weak) id<ZHZHomeDropdownDataSource>dataSource;
@property (nonatomic, weak) id<ZHZHomeDropdownDelegate>delegate;

+ (instancetype)homeDropdown;
@end
