//
//  ZHZHomeTopItem.h
//  ZHZ_MeiTuan
//
//  Created by zhanghangzhen on 16/9/23.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHZHomeTopItem : UIView


+ (instancetype)homeTopItem;

- (void)addTarget:(id)target action:(SEL)action;

- (void)setTitle:(NSString *)title;

- (void)setSubTitle:(NSString *)title;

- (void)setIcon:(NSString *)icon highIcon:(NSString *)highIcon;


@end
