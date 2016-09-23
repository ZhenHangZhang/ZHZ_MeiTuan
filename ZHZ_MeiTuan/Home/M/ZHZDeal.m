//
//  ZHZDeal.m
//  ZHZ_MeiTuan
//
//  Created by zhanghangzhen on 16/9/23.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import "ZHZDeal.h"
#import "MJExtension.h"

#import "ZHZBusiness.h"

@implementation ZHZDeal


+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"desc" : @"description"};
}


+ (NSDictionary *)objectClassInArray
{
    return @{@"businesses" : [ZHZBusiness class]};
}

MJCodingImplementation

- (BOOL)isEqual:(ZHZDeal *)object
{
    return [self.deal_id isEqualToString:object.deal_id];
}
@end
