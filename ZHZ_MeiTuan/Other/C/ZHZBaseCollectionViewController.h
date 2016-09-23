//
//  ZHZBaseCollectionViewController.h
//  ZHZ_MeiTuan
//
//  Created by zhanghangzhen on 16/9/23.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHZBaseCollectionViewController : UICollectionViewController

/**  设置请求参数:交给子类去实现  */
- (void)setParams:(NSMutableDictionary *)params;

@end
