//
//  HDAttributeMaker.h
//  frame
//
//  Created by hd-apple10 on 6/15/17.
//  Copyright © 2017 hd-apple10. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface HDAttributeMaker : NSObject


@property (nonatomic, strong) NSMutableAttributedString *attStr; //!< 富文本


- (instancetype)initWithString:(NSString *)str;


- (HDAttributeMaker * (^)(UIColor *))foregroundColor; //!< 设置整体前景色
- (HDAttributeMaker * (^)(UIColor *, NSRange))foregroundColorInRange; //!< 设置局部前景色

- (HDAttributeMaker * (^)(UIColor *))backgroundColor; //!< 设置背景色
- (HDAttributeMaker * (^)(UIColor *, NSRange))backgroundColorInRange; //!< 设置背景色

- (HDAttributeMaker * (^)(UIFont *))font; //!< 设置字体
- (HDAttributeMaker * (^)(UIFont *, NSRange))fontInRange; //!< 设置字体

- (HDAttributeMaker * (^)(NSUnderlineStyle, UIColor *))strikethrough; //!< 设置删除线样式。可设置 style，color, range
- (HDAttributeMaker * (^)(NSUnderlineStyle, UIColor *, NSRange))strikethroughInRange;

- (HDAttributeMaker * (^)(NSUnderlineStyle, UIColor *))underline; //!< 设置下划线样式。可设置 style，color, range
- (HDAttributeMaker * (^)(NSUnderlineStyle, UIColor *, NSRange))underlineInRange;


@end
