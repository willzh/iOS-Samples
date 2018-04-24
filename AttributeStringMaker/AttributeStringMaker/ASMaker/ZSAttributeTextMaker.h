//
//  ZSAttributeTextMaker.h
//  HouseKeeper
//
//  Created by Will on 2017/11/22.
//  Copyright © 2017年 NoOrg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ZSAttribute : NSObject

typedef void(^ZSAttributeStringTapAction)(ZSAttribute *attribute);

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, copy) ZSAttributeStringTapAction tapAction; //!< 点击回调

@end


@interface ZSAttributeTextMaker : NSObject

@property (nonatomic, strong) NSMutableAttributedString *attStr; //!< 富文本

- (ZSAttributeTextMaker * (^)(NSString *, UIColor *, UIFont *))appendText; //!< 添加一段文字，同时设置颜色，字体

@end


