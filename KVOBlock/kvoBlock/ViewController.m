//
//  ViewController.m
//  frame
//
//  Created by  on 3/10/17.
//  Copyright © 2017 . All rights reserved.
//


#import "ViewController.h"
#import "DetailVC.h"

#import "NSObject+KVOBlock.h"


@interface ViewController ()
{
    
}

@property (nonatomic, copy) NSString *str;
@property (nonatomic, copy) NSString *str2;

@property (nonatomic, strong) UIView *temp;

@end


@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
//    [self addObserverForKeyPath:@"str" options:NSKeyValueObservingOptionNew block:^(NSObject *observer, NSString *keyPath, NSDictionary<NSString *,id> *change) {
//        printf("111\n");
//    }];
//    [self addObserverForKeyPath:@"str2" options:NSKeyValueObservingOptionNew block:^(NSObject *observer, NSString *keyPath, NSDictionary<NSString *,id> *change) {
//        printf("222\n");
//    }];
    
    [self addObserverForKeyPaths:@[@"str", @"str2"] options:NSKeyValueObservingOptionNew block:^(NSObject *observer, NSString *keyPath, NSDictionary<NSString *,id> *change) {
        if ([keyPath isEqualToString:@"str"]) {
            NSLog(@"str was changed");
        }else if ([keyPath isEqualToString:@"str2"]) {
            NSLog(@"str2 was changed");
        }
    }];
    
    self.str = @"111";
    self.str2 = @"333";
    
    self.str = @"222";
    
    [self removeAllObserver]; // 移除后下面的改变就不会再响应
    
    self.str2 = @"444";
    self.str = @"2242";
    
    
    
    self.temp = [UIView new];
    [self addObserverForKeyPath:@"temp.frame" options:NSKeyValueObservingOptionNew block:^(NSObject *observer, NSString *keyPath, NSDictionary<NSString *,id> *change) {
        NSLog(@"change:%@", change);
    }];
    
    _temp.frame = CGRectZero;
    [self removeAllObserver]; // 移除后下面的改变就不会再响应
    _temp.frame = CGRectMake(0, 0, 10, 10);
    
    
    
    [_temp addObserverForKeyPath:@"frame" options:NSKeyValueObservingOptionNew block:^(NSObject *observer, NSString *keyPath, NSDictionary<NSString *,id> *change) {
        NSLog(@"change:%@", change);
    }];
    _temp.frame = CGRectMake(0, 0, 20, 10);
    [_temp removeAllObserver]; // 移除后下面的改变就不会再响应
    _temp.frame = CGRectMake(0, 0, 10, 30);
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




- (IBAction)gotoDetailVC:(id)sender
{
    self.str = @"111";
    
    DetailVC *vc = [[DetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}








@end











