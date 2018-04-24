//
//  UILabel+HDAttribute.m
//  frame
//
//  Created by hd-apple10 on 6/15/17.
//  Copyright © 2017 hd-apple10. All rights reserved.
//

#import "UILabel+HDAttribute.h"


@implementation UILabel (HDAttribute)


- (void)hd_setString:(NSString *)str makeAttribute:(void(^)(HDAttributeMaker *maker))block
{
    HDAttributeMaker *mak = [[HDAttributeMaker alloc] initWithString:str];
    block(mak);
    
    self.attributedText = mak.attStr;
}

- (void)addLink:(NSArray *)lk touched:(void(^)(UIColor *col))block
{
    if (block) block(nil);
}

- (void)zs_makeAttributeText:(void(^)(ZSAttributeTextMaker *maker))block
{
    ZSAttributeTextMaker *mak = [[ZSAttributeTextMaker alloc] init];
    block(mak);
    
    self.attributedText = mak.attStr;
}


@end





@implementation UITextField (HDAttribute)


- (void)hd_setString:(NSString *)str makeAttribute:(void(^)(HDAttributeMaker *maker))block
{
    HDAttributeMaker *mak = [[HDAttributeMaker alloc] initWithString:str];
    block(mak);
    
    self.attributedText = mak.attStr;
}

@end





@implementation UITextView (HDAttribute)


- (void)hd_setString:(NSString *)str makeAttribute:(void(^)(HDAttributeMaker *maker))block
{
    HDAttributeMaker *mak = [[HDAttributeMaker alloc] initWithString:str];
    block(mak);
    
    self.attributedText = mak.attStr;
}

@end





@implementation UIButton (HDAttribute)


- (void)hd_setTitle:(NSString *)str forState:(UIControlState)state makeAttribute:(void(^)(HDAttributeMaker *maker))block
{
    HDAttributeMaker *mak = [[HDAttributeMaker alloc] initWithString:str];
    block(mak);
    
    [self setAttributedTitle:mak.attStr forState:state];
}

@end




















