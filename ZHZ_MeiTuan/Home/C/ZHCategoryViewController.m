//
//  ZHCategoryViewController.m
//  ZHZ_MeiTuan
//
//  Created by zhanghangzhen on 16/9/23.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import "ZHCategoryViewController.h"
#import "ZHZHomeDropdown.h"
#import "UIView+Extension.h"
#import "ZHZGategoty.h"
#import "MJExtension.h"
#import "ZHZMetaTool.h"
#import "ZHZConst.h"




@interface ZHCategoryViewController ()<ZHZHomeDropdownDataSource, ZHZHomeDropdownDelegate>


@end

@implementation ZHCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ZHZHomeDropdown *dropdown = [ZHZHomeDropdown homeDropdown];
    dropdown.dataSource = self;
    dropdown.delegate = self;
    [self.view addSubview:dropdown];
    
    // 设置控制器view在popover中的尺寸
    self.preferredContentSize = dropdown.size;}

#pragma mark ----ZYHomeDropdownDataSource
- (NSUInteger)numberOfRowsInMainTable:(ZHZHomeDropdown *)homeDropdown
{
    return [ZHZMetaTool categories].count;
}

- (NSString *)homeDropdown:(ZHZHomeDropdown *)homeDropdown titleForRowInMainTable:(NSUInteger)row
{
    return [[ZHZMetaTool categories][row] name];
}

- (NSArray *)homeDropdown:(ZHZHomeDropdown *)homeDropdown subDataForRowInMainTable:(NSUInteger)row
{
    return [[ZHZMetaTool categories][row] subcategories];
}

- (NSString *)homeDropdown:(ZHZHomeDropdown *)homeDropdown normalIconForRowInMainTable:(NSUInteger)row
{
    return [[ZHZMetaTool categories][row] small_icon];
}

- (NSString *)homeDropdown:(ZHZHomeDropdown *)homeDropdown selectedIconForRowInMainTable:(NSUInteger)row
{
    return [[ZHZMetaTool categories][row] small_highlighted_icon];
}

#pragma mark ----ZYHomeDropdownDelegate
- (void)homeDropdown:(ZHZHomeDropdown *)homeDropdown didSelectedRowInMainTable:(int)row
{
    ZHZGategoty *category = [ZHZMetaTool categories][row];
    if (category.subcategories.count == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ZHZCategoryDidChangeNotification object:nil userInfo:@{ZHZSelectCategory : category}];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)homeDropdown:(ZHZHomeDropdown *)homeDropdown didSelectedRowInSubTable:(int)subRow mainRow:(int)mainRow
{
    ZHZGategoty *category = [ZHZMetaTool categories][mainRow];
    [[NSNotificationCenter defaultCenter] postNotificationName:ZHZCategoryDidChangeNotification object:nil userInfo:@{ZHZSelectCategory : category, ZHZSelectSubcategoryName : category.subcategories[subRow]}];
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
