//
//  QRScanView.m
//  QRCodeEx
//
//  Created by  on 10/11/16.
//  Copyright © 2016 . All rights reserved.
//

#import "QRScanView.h"


@implementation QRScanView


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setClipsToBounds:NO];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setUserInteractionEnabled:NO];
    [self setContentMode:UIViewContentModeRedraw];
    
}


- (id)initWithScanRect:(CGRect)scanRect
{
    self = [super init];
    if (self)
    {
        [self setClipsToBounds:NO];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:NO];
        [self setContentMode:UIViewContentModeRedraw];
        
        self.scanRect = scanRect;
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context)
    {
        // 画背景色
        CGContextSetRGBFillColor(context, 0.0f, 0.0f, 0.0f, 0.5f); // 黑色 0.35 alpha
        
        CGRect boundingRect = CGContextGetClipBoundingBox(context);
        CGContextAddRect(context, boundingRect);
        CGContextFillRect(context, boundingRect);
        
        CGContextSetBlendMode(context, kCGBlendModeClear); // 设置混合模式为 clear，意为清除，擦除
        // 设置擦除位置
        CGContextAddRect(context, _scanRect);
        CGContextFillPath(context);
        
        // 画扫描边框
        CGContextSetLineJoin(context, kCGLineJoinRound);
        CGContextSetLineWidth(context, 4.0f);
        CGContextAddRect(context, _scanRect);
        CGContextStrokePath(context);
        
    }
    
    
}








@end










