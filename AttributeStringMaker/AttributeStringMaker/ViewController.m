//
//  ViewController.m
//  AttributeStringMaker
//
//  Created by Will on 2017/7/4.
//  Copyright © 2017年 NoOrg. All rights reserved.
//

#import "ViewController.h"
#import "ASMaker.h"


@interface ViewController ()
{
    IBOutlet UILabel *label;
    IBOutlet UITextField *tf;
    IBOutlet UIButton *btn;
    IBOutlet UITextView *tv;
    
}

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [label hd_setString:@"UILabel 设置富文本测试 demo" makeAttribute:^(HDAttributeMaker *maker) {
        maker.foregroundColor([UIColor redColor]).font([UIFont systemFontOfSize:28]);
        maker.underline(NSUnderlineStyleSingle, [UIColor blueColor]);
    }];
    
    
    [tf hd_setString:@"UITextField 设置富文本测试 demo" makeAttribute:^(HDAttributeMaker *maker) {
        maker.foregroundColorInRange([UIColor redColor], NSMakeRange(0, 5)).fontInRange([UIFont systemFontOfSize:28], NSMakeRange(0, 5));
        maker.underlineInRange(NSUnderlineStyleSingle, [UIColor blueColor], NSMakeRange(10, 5));
    }];
    
    
    [tv hd_setString:@"UITextView 设置富文本测试 demo" makeAttribute:^(HDAttributeMaker *maker) {
        maker.foregroundColorInRange([UIColor redColor], NSMakeRange(0, 6)).fontInRange([UIFont systemFontOfSize:28], NSMakeRange(0, 6));
        maker.underlineInRange(NSUnderlineStyleSingle, [UIColor blueColor], NSMakeRange(10, 5));
    }];
    
    
    [btn hd_setTitle:@"UIButton 设置富文本测试 demo" forState:UIControlStateNormal makeAttribute:^(HDAttributeMaker *maker) {
        maker.foregroundColorInRange([UIColor redColor], NSMakeRange(0, 8)).fontInRange([UIFont systemFontOfSize:28], NSMakeRange(0, 7));
        maker.underlineInRange(NSUnderlineStyleSingle, [UIColor blueColor], NSMakeRange(10, 5));
    }];
    
    
    
    
}


@end













