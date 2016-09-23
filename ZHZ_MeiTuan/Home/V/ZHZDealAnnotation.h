//
//  ZHZDealAnnotation.h
//  ZHZ_MeiTuan
//
//  Created by zhanghangzhen on 16/9/23.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface ZHZDealAnnotation : NSObject<MKAnnotation>



@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
/** 图片名 */
@property (nonatomic, copy) NSString *icon;



@end
