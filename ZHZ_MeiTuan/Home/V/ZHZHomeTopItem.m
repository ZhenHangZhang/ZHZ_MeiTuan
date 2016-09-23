//
//  ZHZHomeTopItem.m
//  ZHZ_MeiTuan
//
//  Created by zhanghangzhen on 16/9/23.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import "ZHZHomeTopItem.h"

@interface ZHZHomeTopItem ()

@property (weak, nonatomic) IBOutlet UIButton *iconBtn;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;


@end



@implementation ZHZHomeTopItem

+ (instancetype)homeTopItem
{
    return [[self alloc] init];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    //这一句，可以让xib里面的autolayout尺寸不随着controller的变化而变化
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (instancetype)init
{
    if (self = [super init]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ZHZHomeTopItem" owner:nil options:nil] lastObject];
    }
    return self;
}


- (void)addTarget:(id)target action:(SEL)action
{
    [self.iconBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)setSubTitle:(NSString *)title
{
    self.subTitleLabel.text = title;
}

- (void)setIcon:(NSString *)icon highIcon:(NSString *)highIcon
{
    [self.iconBtn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [self.iconBtn setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
}

@end
