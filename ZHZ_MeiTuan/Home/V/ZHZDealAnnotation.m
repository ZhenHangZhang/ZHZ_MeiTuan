
//
//  ZHZDealAnnotation.m
//  ZHZ_MeiTuan
//
//  Created by zhanghangzhen on 16/9/23.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import "ZHZDealAnnotation.h"

@implementation ZHZDealAnnotation
/**
 *  这里需要重写这个方法，用来判断两个位置、标题一样的大头针
 *
 */
- (BOOL)isEqual:(ZHZDealAnnotation *)object
{
    return [object.title isEqualToString:_title];
}
@end
