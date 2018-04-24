//
//  HDAttributeMaker.m
//  frame
//
//  Created by hd-apple10 on 6/15/17.
//  Copyright © 2017 hd-apple10. All rights reserved.
//

#import "HDAttributeMaker.h"


@interface HDAttributeMaker ()

@end



@implementation HDAttributeMaker


#pragma mark -init
- (instancetype)initWithString:(NSString *)str
{
    self = [super init];
    if (self)
    {
        self.attStr = [[NSMutableAttributedString alloc] initWithString:str];
        
    }
    return self;
}


#pragma mark -
- (HDAttributeMaker * (^)(UIColor *))foregroundColor
{
    return ^(UIColor *color) {
        return self.foregroundColorInRange(color, [self fullRange]);
    };
}

- (HDAttributeMaker * (^)(UIColor *, NSRange))foregroundColorInRange
{
    return ^(UIColor *color, NSRange range) {
        return [self addAttribute:NSForegroundColorAttributeName value:color range:range];
    };
}

- (HDAttributeMaker * (^)(UIColor *, NSRange, UIColor *))foregroundColorInRange2
{
    return ^(UIColor *color, NSRange range, UIColor *elseColor) {
        [self addAttribute:NSForegroundColorAttributeName value:elseColor range:[self fullRange]];
        return [self addAttribute:NSForegroundColorAttributeName value:color range:range];
    };
}

- (HDAttributeMaker * (^)(UIColor *))backgroundColor
{
    return ^(UIColor *color) {
        return self.backgroundColorInRange(color, [self fullRange]);
    };
}

- (HDAttributeMaker * (^)(UIColor *, NSRange))backgroundColorInRange
{
    return ^(UIColor *color, NSRange range) {
        return [self addAttribute:NSBackgroundColorAttributeName value:color range:range];
    };
}

- (HDAttributeMaker * (^)(UIFont *))font
{
    return ^(UIFont *font) {
        return self.fontInRange(font, [self fullRange]);
    };
}

- (HDAttributeMaker * (^)(UIFont *, NSRange))fontInRange
{
    return ^(UIFont *font, NSRange range) {
        return [self addAttribute:NSFontAttributeName value:font range:range];
    };
}


- (HDAttributeMaker * (^)(NSUnderlineStyle, UIColor *))strikethrough
{
    return ^(NSUnderlineStyle sts, UIColor *color) {
        return self.strikethroughInRange(sts, color, [self fullRange]);
    };
}

- (HDAttributeMaker * (^)(NSUnderlineStyle, UIColor *, NSRange))strikethroughInRange
{
    return ^(NSUnderlineStyle sts, UIColor *color, NSRange range) {
        return [self addAttributes:@{NSStrikethroughStyleAttributeName: @(sts), NSStrikethroughColorAttributeName: color} range:range];
    };
}

- (HDAttributeMaker * (^)(NSUnderlineStyle, UIColor *))underline
{
    return ^(NSUnderlineStyle uls, UIColor *color) {
        return self.underlineInRange(uls, color, [self fullRange]);
    };
}

- (HDAttributeMaker * (^)(NSUnderlineStyle, UIColor *, NSRange))underlineInRange
{
    return ^(NSUnderlineStyle uls, UIColor *color, NSRange range) {
        return [self addAttributes:@{NSUnderlineStyleAttributeName: @(uls), NSUnderlineColorAttributeName: color} range:range];
    };
}






#pragma mark -
- (HDAttributeMaker *)addAttribute:(NSString *)attName value:(id)value range:(NSRange)range
{
    [_attStr addAttribute:attName value:value range:range];
    
    return self;
}

- (HDAttributeMaker *)addAttributes:(NSDictionary *)atts range:(NSRange)range
{
    [_attStr addAttributes:atts range:range];
    
    return self;
}

- (NSRange)fullRange
{
    return NSMakeRange(0, _attStr.length);
}





@end
