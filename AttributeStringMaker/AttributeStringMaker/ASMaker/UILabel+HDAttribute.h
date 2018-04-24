//
//  UILabel+HDAttribute.h
//  frame
//
//  Created by hd-apple10 on 6/15/17.
//  Copyright © 2017 hd-apple10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDAttributeMaker.h"
#import "ZSAttributeTextMaker.h"


@interface UILabel (HDAttribute)

- (void)hd_setString:(NSString *)str makeAttribute:(void(^)(HDAttributeMaker *maker))block;

- (void)zs_makeAttributeText:(void(^)(ZSAttributeTextMaker *maker))block;

@end



@interface UITextField (HDAttribute)

- (void)hd_setString:(NSString *)str makeAttribute:(void(^)(HDAttributeMaker *maker))block;


@end



@interface UITextView (HDAttribute)

- (void)hd_setString:(NSString *)str makeAttribute:(void(^)(HDAttributeMaker *maker))block;


@end



@interface UIButton (HDAttribute)

- (void)hd_setTitle:(NSString *)str forState:(UIControlState)state makeAttribute:(void(^)(HDAttributeMaker *maker))block;


@end
