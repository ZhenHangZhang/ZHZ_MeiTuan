
//
//  ZHZDealCollectionViewCell.m
//  ZHZ_MeiTuan
//
//  Created by zhanghangzhen on 16/9/23.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import "ZHZDealCollectionViewCell.h"
#import "ZHZDeal.h"

#import "UIImageView+WebCache.h"

@interface ZHZDealCollectionViewCell ()


- (IBAction)clickCoverbtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *listPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *purchaseCountLabel;
/**
 属性名不能以new开头
 */
@property (weak, nonatomic) IBOutlet UIImageView *dealNewView;

@property (weak, nonatomic) IBOutlet UIButton *coverBtn;
@property (weak, nonatomic) IBOutlet UIImageView *choosedImageView;







@end


@implementation ZHZDealCollectionViewCell


-(void)setDeal:(ZHZDeal *)deal{

    _deal = deal;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:deal.s_image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];
    self.titleLabel.text = deal.title;
    self.descLabel.text = deal.desc;
    
    self.purchaseCountLabel.text = [NSString stringWithFormat:@"已售%d", deal.purchase_count];
    
    self.currentPriceLabel.text = [NSString stringWithFormat:@"¥ %@", deal.current_price];
    NSUInteger dotLoc = [self.currentPriceLabel.text rangeOfString:@"."].location;
    if (dotLoc != NSNotFound) {
        if (self.currentPriceLabel.text.length - dotLoc > 3) {
            self.currentPriceLabel.text = [self.currentPriceLabel.text substringToIndex:dotLoc + 3];
        }
    }
    self.listPriceLabel.text = [NSString stringWithFormat:@"¥ %@", deal.list_price];
    
    // 是否显示新单图片
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat= @"yyyy-MM-dd";
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    // 隐藏: 发布日期 < 今天
    self.dealNewView.hidden = ([deal.publish_date compare:nowStr] == NSOrderedAscending);
    
    self.coverBtn.hidden = !self.deal.isEditing;
    self.choosedImageView.hidden = !self.deal.isChecking;

    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)clickCoverbtn:(id)sender {
    
    self.deal.checking = !self.deal.checking;
    self.choosedImageView.hidden = !self.deal.checking;
    
    
}
-(void)drawRect:(CGRect)rect{
    [[UIImage imageNamed:@"bg_dealcell"] drawInRect:rect];
}
@end
