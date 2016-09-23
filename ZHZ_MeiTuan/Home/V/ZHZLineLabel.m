
//
//  ZHZLineLabel.m
//  ZHZ_MeiTuan
//
//  Created by zhanghangzhen on 16/9/23.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import "ZHZLineLabel.h"

@implementation ZHZLineLabel

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef ref = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];
    CGContextMoveToPoint(ref, 0, rect.size.height * 0.5);
    CGContextAddLineToPoint(ref, rect.size.width, rect.size.height * 0.5);
    CGContextSetLineWidth(ref, 1);
    CGContextStrokePath(ref);
}

@end
