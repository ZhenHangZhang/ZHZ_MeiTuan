//
//  ZHZSearchViewController.m
//  ZHZ_MeiTuan
//
//  Created by zhanghangzhen on 16/9/23.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import "ZHZSearchViewController.h"


#import "UIBarButtonItem+ZYExtension.h"

#import "MJRefresh.h"


@interface ZHZSearchViewController ()<UISearchBarDelegate>
@property (nonatomic, weak) UISearchBar *searchBar;

@end

@implementation ZHZSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNar];
}
- (void)setupNar
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(didClickLeftBarButtonItem) normalImage:@"icon_back" highImage:@"icon_back_highlighted"];
    
    
    //    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 35)];
    //    searchView.backgroundColor = [UIColor clearColor];
    //    searchView.backgroundColor = [UIColor redColor];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 0, 280, 35)];
    searchBar.placeholder = @"请输入关键词";
    searchBar.delegate = self;
    
    //如果不想让searchBar随着拉升，可以将它添加到UIView里面，再将UIView放到titleView里面
    //    [searchView addSubview:searchBar];
    self.navigationItem.titleView = searchBar;
    self.searchBar = searchBar;
}

- (void)setParams:(NSMutableDictionary *)params
{
    params[@"city"] = self.cityName;
    params[@"keyword"] = self.searchBar.text;
}

#pragma mark ----click事件
- (void)didClickLeftBarButtonItem
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ----UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.collectionView.header beginRefreshing];
    
    [self.searchBar resignFirstResponder];
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
