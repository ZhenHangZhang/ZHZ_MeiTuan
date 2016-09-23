//
//  ZHZCity.h
//  ZHZ_MeiTuan
//
//  Created by zhanghangzhen on 16/9/23.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface ZHZCity : NSObject

/** 城市名字 */
@property (nonatomic, copy) NSString *name;
/** 城市名字的拼音 */
@property (nonatomic, copy) NSString *pinYin;
/** 城市名字的拼音声母 */
@property (nonatomic, copy) NSString *pinYinHead;
/** 区域(存放的都是ZYRegion模型) */
@property (nonatomic, strong) NSArray *regions;

@end
