//
//  ViewController.m
//  QRCodeEx
//
//  Created by  on 8/25/16.
//  Copyright © 2016 . All rights reserved.
//

#import "ViewController.h"
#import "QRCodeReaderVC.h"
#import "QRCodeGeneratorVC.h"


@interface ViewController ()

@end

@implementation ViewController


#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
}








- (IBAction)generateQRCodeAction:(id)sender
{
    QRCodeGeneratorVC *vc = [[QRCodeGeneratorVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (IBAction)readerQRCodeAction:(id)sender
{
    QRCodeReaderVC *vc = [[QRCodeReaderVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}




@end
