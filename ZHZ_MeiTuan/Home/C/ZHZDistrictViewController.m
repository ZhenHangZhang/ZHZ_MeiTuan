//
//  ZHZDistrictViewController.m
//  ZHZ_MeiTuan
//
//  Created by zhanghangzhen on 16/9/23.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import "ZHZDistrictViewController.h"
#import "ZHZCityViewController.h"
#import "UIBarButtonItem+ZYExtension.h"
#import "ZHZHomeDropdown.h"
#import "ZHZConst.h"
#import "ZHZMetaTool.h"
#import "UIView+Extension.h"
#import "ZHZRegion.h"






@interface ZHZDistrictViewController ()<ZHZHomeDropdownDataSource, ZHZHomeDropdownDelegate>


@end

@implementation ZHZDistrictViewController
- (IBAction)changeCity:(id)sender {
    
    
    /**
     *  注意，应当先让它自己注销掉，再从主窗口presentViewController，一个窗口，只能present一个ViewController
     */
    [self dismissViewControllerAnimated:YES completion:nil];
    ZHZCityViewController *cityVc = [[ZHZCityViewController alloc] initWithNibName:@"ZHZCityViewController" bundle:nil];
    UINavigationController *nVc = [[UINavigationController alloc] initWithRootViewController:cityVc];
    nVc.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nVc animated:YES completion:nil];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ZHZHomeDropdown *dropdown = [ZHZHomeDropdown homeDropdown];
    dropdown.dataSource = self;
    dropdown.delegate = self;
    [self.view addSubview:dropdown];
    dropdown.frame = CGRectMake(0, 44, 400, 380);
    NSLog(@"%@",NSStringFromCGRect(dropdown.frame));
    self.preferredContentSize = CGSizeMake(dropdown.width, CGRectGetMaxY(dropdown.frame));
}
#pragma mark ----ZYHomeDropdownDataSource
- (NSUInteger)numberOfRowsInMainTable:(ZHZHomeDropdown *)homeDropdown
{
    return self.regions.count;
}

- (NSString *)homeDropdown:(ZHZHomeDropdown *)homeDropdown titleForRowInMainTable:(NSUInteger)row
{
    return [self.regions[row] name];
}

- (NSArray *)homeDropdown:(ZHZHomeDropdown *)homeDropdown subDataForRowInMainTable:(NSUInteger)row
{
    return [self.regions[row] subregions];
}

#pragma mark ----ZYHomeDropdownDelegate
- (void)homeDropdown:(ZHZHomeDropdown *)homeDropdown didSelectedRowInMainTable:(int)row
{
    ZHZRegion *region = self.regions[row];
    if (region.subregions == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ZHZRegionDidChangeNotification object:nil userInfo:@{ZHZSelectCategory : region}];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)homeDropdown:(ZHZHomeDropdown *)homeDropdown didSelectedRowInSubTable:(int)subRow mainRow:(int)mainRow
{
    ZHZRegion *region = self.regions[mainRow];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ZHZRegionDidChangeNotification object:nil userInfo:@{ZHZSelectRegion : region, ZHZSelectSubregionName : region.subregions[subRow]}];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
