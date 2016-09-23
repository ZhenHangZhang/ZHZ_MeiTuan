//
//  ZHZHomeDropdown.m
//  ZHZ_MeiTuan
//
//  Created by zhanghangzhen on 16/9/23.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import "ZHZHomeDropdown.h"

#import "ZHZMainTableViewCell.h"
#import "ZHZSubTableViewCell.h"



@interface ZHZHomeDropdown ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *maintab;

@property (weak, nonatomic) IBOutlet UITableView *subtab;
@property (nonatomic, assign) int selectedMainRow;



@end



@implementation ZHZHomeDropdown

+ (instancetype)homeDropdown
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super init]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ZHZHomeDropdown" owner:nil options:nil] lastObject];
        [self commitInit];
    }
    return self;
}

- (void)commitInit
{
    self.maintab.delegate = self;
    self.maintab.dataSource = self;
    
    self.subtab.delegate = self;
    self.subtab.dataSource = self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}
#pragma mark ----UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.maintab == tableView) {
        return [self.dataSource numberOfRowsInMainTable:self];
    }
    else{
        return [self.dataSource homeDropdown:self subDataForRowInMainTable:self.selectedMainRow].count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.maintab) {
        ZHZMainTableViewCell *cell = [ZHZMainTableViewCell mainCellWithTableView:tableView];
        cell.textLabel.text = [self.dataSource homeDropdown:self titleForRowInMainTable:indexPath.row];
        
        if ([self.dataSource respondsToSelector:@selector(homeDropdown:normalIconForRowInMainTable:)]) {
            
            cell.imageView.image = [UIImage imageNamed:[self.dataSource homeDropdown:self normalIconForRowInMainTable:indexPath.row]];
        }
        
        if ([self.dataSource respondsToSelector:@selector(homeDropdown:selectedIconForRowInMainTable:)]) {
            
            cell.imageView.highlightedImage = [UIImage imageNamed:[self.dataSource homeDropdown:self selectedIconForRowInMainTable:indexPath.row]];
        }
        
        NSArray *subData = [self.dataSource homeDropdown:self subDataForRowInMainTable:indexPath.row];
        
        if (subData.count) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        return cell;
    }
    else{
        ZHZSubTableViewCell *cell = [ZHZSubTableViewCell subCellWithTableView:tableView];
        
        NSArray *subData = [self.dataSource homeDropdown:self subDataForRowInMainTable:self.selectedMainRow];
        
        cell.textLabel.text = subData[indexPath.row];
        
        return cell;
    }
}


#pragma mark ----UITabelViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.maintab) {
        self.selectedMainRow = (int)indexPath.row;
        [self.subtab reloadData];
        
        if ([self.delegate respondsToSelector:@selector(homeDropdown:didSelectedRowInMainTable:)]) {
            [self.delegate homeDropdown:self didSelectedRowInMainTable:(int)indexPath.row];
        }
    }
    else{
        if ([self.delegate respondsToSelector:@selector(homeDropdown:didSelectedRowInSubTable:mainRow:)]) {
            [self.delegate homeDropdown:self didSelectedRowInSubTable:(int)indexPath.row mainRow:self.selectedMainRow];
        }
    }
}

@end
