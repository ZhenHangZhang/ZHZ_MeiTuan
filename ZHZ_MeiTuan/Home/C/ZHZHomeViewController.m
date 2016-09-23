//
//  ZHZHomeViewController.m
//  ZHZ_MeiTuan
//
//  Created by zhanghangzhen on 16/9/23.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import "ZHZHomeViewController.h"
#import "ZHZConst.h"
#import "UIBarButtonItem+ZYExtension.h"
#import "UIView+Extension.h"
#import "ZHZHomeTopItem.h"
#import "ZHCategoryViewController.h"
#import "ZHZDistrictViewController.h"
#import "ZHZSort.h"
#import "ZHZCity.h"
#import "ZHZMetaTool.h"
#import "ZHZSortViewController.h"
#import "ZHZRegion.h"
#import "ZHZGategoty.h"
#import "ZHZDeal.h"
#import "MJExtension.h"
#import "ZHZDealCollectionViewCell.h"
#import "MJRefresh.h"
#import "MBProgressHUD+MJ.h"
#import "UIView+AutoLayout.h"
#import "ZHZSearchViewController.h"
#import "AwesomeMenu.h"
#import "ZHZCollectViewController.h"
#import "ZHZBrowseViewController.h"
#import "ZHZMaoViewController.h"




@interface ZHZHomeViewController ()<AwesomeMenuDelegate>

@property (nonatomic, weak) UIBarButtonItem *categoryItem;
@property (nonatomic, weak) UIBarButtonItem *districtItem;
@property (nonatomic, weak) UIBarButtonItem *sortItem;

/** 当前选中的城市名字 */
@property (nonatomic, copy) NSString *selectedCityName;
/** 当前选中的分类名字 */
@property (nonatomic, copy) NSString *selectedCategoryName;
/** 当前选中的区域名字 */
@property (nonatomic, copy) NSString *selectedRegionName;
/** 当前选中的排序 */
@property (nonatomic, strong) ZHZSort *selectedSort;
@end

@implementation ZHZHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLeftNar];
    
    [self setupRightNar];
    
    [self setupAwesomeMenu];
    
    [self setupNotification];
    
    [self cityDidChange:nil];
}
- (void)setupLeftNar
{
    UIBarButtonItem *logoItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_meituan_logo"] style:UIBarButtonItemStyleDone target:nil action:nil];
    logoItem.enabled = NO;
    
    ZHZHomeTopItem *categoryTopItem = [ZHZHomeTopItem homeTopItem];
    [categoryTopItem addTarget:self action:@selector(didClickCategoryTopItem)];
    UIBarButtonItem *categoryItem = [[UIBarButtonItem alloc] initWithCustomView:categoryTopItem];
    self.categoryItem = categoryItem;
    
    ZHZHomeTopItem *districtTopItem = [ZHZHomeTopItem homeTopItem];
    [districtTopItem addTarget:self action:@selector(didClickDistrictTopItem)];
    UIBarButtonItem *districtItem = [[UIBarButtonItem alloc] initWithCustomView:districtTopItem];
    self.districtItem = districtItem;
    
    ZHZHomeTopItem *sortTopItem = [ZHZHomeTopItem homeTopItem];
    [sortTopItem setTitle:@"排序"];
    [sortTopItem setIcon:@"icon_sort" highIcon:@"icon_sort_highlighted"];
    [sortTopItem addTarget:self action:@selector(didClickSortTopItem)];
    UIBarButtonItem *sortItem = [[UIBarButtonItem alloc] initWithCustomView:sortTopItem];
    self.sortItem = sortItem;
    
    self.navigationItem.leftBarButtonItems = @[logoItem, categoryItem, districtItem, sortItem];
}
- (void)setupRightNar
{
    UIBarButtonItem *mapItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(didClickMapTopItem) normalImage:@"icon_map" highImage:@"icon_map_highlighted"];
    mapItem.customView.width = 65;
    
    UIBarButtonItem *searchItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(didClickSearchTopItem) normalImage:@"icon_search" highImage:@"icon_search_highlighted"];
    searchItem.customView.width = 65;
    
    self.navigationItem.rightBarButtonItems = @[mapItem, searchItem];
}

- (void)setupAwesomeMenu
{
    //initWithImage放背景图片，normal和highlighted状态下的背景图片
    //contentImage放具体要显示的图片
    AwesomeMenuItem *midItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"icon_pathMenu_background_highlighted"] highlightedImage:nil ContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_normal"] highlightedContentImage:nil];
    
    AwesomeMenuItem *firstItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"] highlightedImage:nil ContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_highlighted"]];
    AwesomeMenuItem *secoendItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"] highlightedImage:nil ContentImage:[UIImage imageNamed:@"icon_pathMenu_scan_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_scan_highlighted"]];
    AwesomeMenuItem *thirdItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"] highlightedImage:nil ContentImage:[UIImage imageNamed:@"icon_pathMenu_more_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_more_highlighted"]];
    AwesomeMenuItem *fourthItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"] highlightedImage:nil ContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_highlighted"]];
    
    NSArray *items = @[firstItem, secoendItem, thirdItem, fourthItem];
    AwesomeMenu *awesome = [[AwesomeMenu alloc] initWithFrame:CGRectZero startItem:midItem optionMenus:items];
    //开始点
    awesome.startPoint = CGPointMake(50, 150);
    //设置显示区域（也就是角度）
    awesome.menuWholeAngle = M_PI_2;
    
    awesome.delegate = self;
    //让中间按钮不旋转
    awesome.rotateAddButton = NO;
    awesome.alpha = 0.5;
    [self.view addSubview:awesome];
    
    [awesome autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [awesome autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    
    [awesome autoSetDimensionsToSize:CGSizeMake(200, 200)];
}
- (void)setupNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityDidChange:) name:ZHZCityDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sortDidChange:) name:ZHZSortDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(regionDidChange:) name:ZHZRegionDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(caregoryDidChange:) name:ZHZCategoryDidChangeNotification object:nil];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark ----receiveNotification调用的方法

- (void)cityDidChange:(NSNotification *)notification
{
    NSString *cityName = notification.userInfo[ZHZSelectedCityName];
    self.selectedCityName = cityName;
    if (notification == nil) {
        self.selectedCityName = @"广州";
    }
    ZHZHomeTopItem *homeTopItem = (ZHZHomeTopItem *)self.districtItem.customView;
    [homeTopItem setTitle:[NSString stringWithFormat:@"%@ - 全部",self.selectedCityName]];
    [homeTopItem setSubTitle:nil];
    
    [self.collectionView.header beginRefreshing];
}

- (void)sortDidChange:(NSNotification *)notification
{
    self.selectedSort = notification.userInfo[ZHZSelectSort];
    
    ZHZHomeTopItem *homeTopItem = (ZHZHomeTopItem *)self.sortItem.customView;
    [homeTopItem setSubTitle:self.selectedSort.label];
    
    [self.collectionView.header beginRefreshing];
}

- (void)regionDidChange:(NSNotification *)notification
{
    ZHZRegion *region = notification.userInfo[ZHZSelectRegion];
    NSLog(@"++++++%@",region.name);
    NSString *subReginName = notification.userInfo[ZHZSelectSubregionName];
    
    if (subReginName == nil || [region.name isEqualToString:@"全部"]) {
        self.selectedRegionName = nil;
    }
    else{
        self.selectedRegionName = subReginName;
    }
    
    if ([subReginName isEqualToString:@"全部"]) {
        self.selectedRegionName = nil;
    }
    
   ZHZHomeTopItem *homeTopItem = (ZHZHomeTopItem *)self.districtItem.customView;
    
    NSString *regionName = region.name;
    
    if (regionName == nil) {
        regionName = @"全部";
    }
    [homeTopItem setTitle:[NSString stringWithFormat:@"%@ - %@", self.selectedCityName, regionName]];
    [homeTopItem setSubTitle:subReginName];
    
    [self.collectionView.header beginRefreshing];
}

- (void)caregoryDidChange:(NSNotification *)notification
{
    ZHZGategoty *category = notification.userInfo[ZHZSelectCategory];
    NSString *subcategoryName = notification.userInfo[ZHZSelectSubcategoryName];
    
    if (subcategoryName == nil || [subcategoryName isEqualToString:@"全部"]) { // 点击的数据没有子分类
        self.selectedCategoryName = category.name;
    } else {
        self.selectedCategoryName = subcategoryName;
    }
    if ([self.selectedCategoryName isEqualToString:@"全部分类"]) {
        self.selectedCategoryName = nil;
    }
    
    ZHZHomeTopItem *topItem = (ZHZHomeTopItem *)self.categoryItem.customView;
    [topItem setIcon:category.icon highIcon:category.highlighted_icon];
    [topItem setTitle:category.name];
    [topItem setSubTitle:subcategoryName];
    
    [self.collectionView.header beginRefreshing];
}


#pragma mark ----与服务器进行交互
- (void)setParams:(NSMutableDictionary *)params
{
    // 城市
    params[@"city"] = self.selectedCityName;
    // 分类(类别)
    if (self.selectedCategoryName) {
        params[@"category"] = self.selectedCategoryName;
    }
    // 区域
    if (self.selectedRegionName) {
        params[@"region"] = self.selectedRegionName;
    }
    // 排序
    if (self.selectedSort) {
        params[@"sort"] = @(self.selectedSort.value);
    }
}
#pragma mark ----clickItem
- (void)didClickCategoryTopItem
{
    UIPopoverController *popVc = [[UIPopoverController alloc] initWithContentViewController:[[ZHCategoryViewController alloc] init]];
    
    [popVc presentPopoverFromBarButtonItem:self.categoryItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

- (void)didClickDistrictTopItem
{
    ZHZDistrictViewController *districtTopItem = [[ZHZDistrictViewController alloc] init];
    UIPopoverController *popVc = [[UIPopoverController alloc] initWithContentViewController:districtTopItem];
    if (self.selectedCityName) {
        ZHZCity *city = [[[ZHZMetaTool cities] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name = %@",self.selectedCityName]] lastObject];
        districtTopItem.regions = city.regions;
    }
    [popVc presentPopoverFromBarButtonItem:self.districtItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)didClickSortTopItem
{
    ZHZSortViewController *sortVc = [[ZHZSortViewController alloc] init];
    UIPopoverController *sortPopVc = [[UIPopoverController alloc] initWithContentViewController:sortVc];
    
    [sortPopVc presentPopoverFromBarButtonItem:self.sortItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)didClickMapTopItem
{
    ZHZMaoViewController *mapVc = [[ZHZMaoViewController alloc] initWithNibName:@"ZHZMaoViewController" bundle:nil];
    
    [self.navigationController pushViewController:mapVc animated:YES];
}

- (void)didClickSearchTopItem
{
    if (self.selectedCityName) {
        ZHZSearchViewController *vc = [[ZHZSearchViewController alloc] init];
        vc.cityName = self.selectedCityName;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        [MBProgressHUD showError:@"请您选择城市后再搜索..." toView:self.view];
    }
}

#pragma mark---- AwesomeMenuDelegate
- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    
    [self awesomeMenuWillAnimateClose:menu];
    
    if (idx == 0) {
        ZHZCollectViewController *vc = [[ZHZCollectViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (idx == 1) {
        ZHZBrowseViewController *vc = [[ZHZBrowseViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)awesomeMenuWillAnimateOpen:(AwesomeMenu *)menu
{
    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_cross_normal"];
    menu.alpha = 1.0;
}

- (void)awesomeMenuWillAnimateClose:(AwesomeMenu *)menu
{
    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_mainMine_normal"];
    menu.alpha = 0.5;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
