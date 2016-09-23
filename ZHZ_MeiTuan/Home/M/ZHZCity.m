//
//  ZHZCity.m
//  ZHZ_MeiTuan
//
//  Created by zhanghangzhen on 16/9/23.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import "ZHZCity.h"
#import "ZHZRegion.h"

#import "MJExtension.h"

@implementation ZHZCity


+(NSDictionary*)objectClassInArray{

    //模型数组中有模型实现这个方法

    return @{
             @"regions" : [ZHZRegion class]

             };
}




@end
