//
//  QRScanView.h
//  QRCodeEx
//
//  Created by  on 10/11/16.
//  Copyright © 2016 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRScanView : UIView

// 扫描二维码的区域
@property (nonatomic, assign) CGRect scanRect;


- (id)initWithScanRect:(CGRect)scanRect;

@end
