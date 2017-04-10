//
//  DetailVC.m
//  frame
//
//  Created by  on 3/22/17.
//  Copyright © 2017 . All rights reserved.
//

#import "DetailVC.h"
#import "NSObject+KVOBlock.h"

@interface DetailVC ()

@property (nonatomic, copy) NSString *str;
@end

@implementation DetailVC



#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"Detail");
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addObserverForKeyPaths:@[@"str"] options:NSKeyValueObservingOptionNew block:^(NSObject *observer, NSString *keyPath, NSDictionary<NSString *,id> *change) {
        NSLog(@"str was changed");
    }];
    
    self.str = @"111";
    self.str = @"222";
    
    
}













@end
