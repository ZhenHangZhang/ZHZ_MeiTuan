//
//  ZHZDeal.h
//  ZHZ_MeiTuan
//
//  Created by zhanghangzhen on 16/9/23.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZHZRestructions;


@interface ZHZDeal : NSObject<NSCoding>
/** 团购单ID */
@property (copy, nonatomic) NSString *deal_id;
/** 团购标题 */
@property (copy, nonatomic) NSString *title;
/** 团购描述 */
@property (copy, nonatomic) NSString *desc;
/** 如果想完整地保留服务器返回数字的小数位数(没有小数\1位小数\2位小数等),那么就用NSNumber */
/** 团购包含商品原价值 */
@property (strong, nonatomic) NSNumber *list_price;
/** 团购价格 */
@property (strong, nonatomic) NSNumber *current_price;
/** 团购当前已购买数 */
@property (assign, nonatomic) int purchase_count;
/** 团购图片链接，最大图片尺寸450×280 */
@property (copy, nonatomic) NSString *image_url;
/** 小尺寸团购图片链接，最大图片尺寸160×100 */
@property (copy, nonatomic) NSString *s_image_url;
/** string	团购发布上线日期 */
@property (nonatomic, copy) NSString *publish_date;
/** string	团购单的截止购买日期 */
@property (nonatomic, copy) NSString *purchase_deadline;

/** string	团购HTML5页面链接 */
@property (nonatomic, copy) NSString *deal_h5_url;

/** 团购限制条件 */
@property (nonatomic, strong) ZHZRestructions *restrictions;

/**  是否正在编辑  */
@property (nonatomic, assign, getter=isEditing) BOOL editing;

/**  是否被勾选  */
@property (nonatomic, assign, getter=isChecking) BOOL checking;

@property (nonatomic, strong) NSArray *businesses;
@property (nonatomic, strong) NSArray *categories;


@end
