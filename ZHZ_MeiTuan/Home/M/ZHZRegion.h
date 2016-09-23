//
//  ZHZRegion.h
//  ZHZ_MeiTuan
//
//  Created by zhanghangzhen on 16/9/23.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHZRegion : NSObject

/** 区域名字 */
@property (nonatomic, copy) NSString *name;
/** 子区域 (字符串) */
@property (nonatomic, strong) NSArray *subregions;

@end
