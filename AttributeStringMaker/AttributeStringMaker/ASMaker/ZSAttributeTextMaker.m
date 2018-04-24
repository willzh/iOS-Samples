//
//  ZSAttributeTextMaker.m
//  HouseKeeper
//
//  Created by Will on 2017/11/22.
//  Copyright © 2017年 NoOrg. All rights reserved.
//

#import "ZSAttributeTextMaker.h"


@implementation ZSAttribute

@end



@interface ZSAttributeTextMaker ()
{
    
}

@property (nonatomic, strong) NSMutableString *string;
@property (nonatomic, strong) NSMutableArray *attributes;

@end



@implementation ZSAttributeTextMaker


#pragma mark -init
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.string = [[NSMutableString alloc] init];
        self.attributes = [NSMutableArray array];
    }
    return self;
}

- (ZSAttributeTextMaker * (^)(NSString *, UIColor *, UIFont *))appendText
{
    return ^(NSString *text, UIColor *color, UIFont *font) {
        ZSAttribute *att = [[ZSAttribute alloc] init];
        att.text = text;
        att.color = color;
        att.font = font;
        [self.attributes addObject:att];
        
        [_string appendString:text];
        return self;
    };
}

- (ZSAttributeTextMaker * (^)(NSString *, UIColor *, UIFont *, ZSAttributeStringTapAction))appendTextWithTap
{
    return ^(NSString *text, UIColor *color, UIFont *font, ZSAttributeStringTapAction tap) {
        ZSAttribute *att = [[ZSAttribute alloc] init];
        att.text  = text;
        att.color = color;
        att.font  = font;
        att.tapAction = tap;
        [self.attributes addObject:att];
        
        [_string appendString:text];
        return self;
    };
}










#pragma mark - Getter
- (NSMutableAttributedString *)attStr
{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:_string];
    
    for (ZSAttribute *att in _attributes)
    {
        NSRange range = [_string rangeOfString:att.text];
        [attStr addAttribute:NSForegroundColorAttributeName value:att.color range:range];
        [attStr addAttribute:NSFontAttributeName value:att.font range:range];
    }
    
    return attStr;
}

- (NSMutableArray *)actions
{
    //TODO:点击事件
    return nil;
}
















@end































