//
//  QRCodeReaderVC.m
//  QRCodeEx
//
//  Created by  on 8/25/16.
//  Copyright © 2016 . All rights reserved.
//

#import "QRCodeReaderVC.h"
#import "QRCodeReader.h"
#import "QRScanView.h"
#import "Masonry/Masonry.h"


@interface QRCodeReaderVC ()
{
    IBOutlet UIButton *btn_cameraDevice; // 相机
    IBOutlet UIButton *btn_flashMode;    // 闪光灯
    
    
}

@property (nonatomic, strong) QRScanView *scanView;
@property (nonatomic, strong) QRCodeReader *codeReader;


@end



@implementation QRCodeReaderVC


#pragma mark - dealloc
- (void)dealloc
{
    [_codeReader stopScanning];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}



#pragma mark - init
- (instancetype)init
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self = [sb instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
    if (self)
    {
        
        
        
    }
    return self;
}






#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    CGRect sr = [UIScreen mainScreen].bounds;
    CGFloat x = 30.0;
    CGFloat w = CGRectGetWidth(sr) - (2 * x);
    CGRect scanRect = CGRectMake(x, 140, w, w);
    
    self.scanView = [[QRScanView alloc] initWithScanRect:scanRect];
    
    self.codeReader = [[QRCodeReader alloc] init];
    _codeReader.previewLayer.frame = _scanView.bounds;
    
    if ([_codeReader.previewLayer.connection isVideoOrientationSupported])
    {
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        _codeReader.previewLayer.connection.videoOrientation = [QRCodeReader videoOrientationFromInterfaceOrientation:orientation];
    }
    [self.view.layer addSublayer:_codeReader.previewLayer];
    
    
    [self.view addSubview:_scanView];
    [_scanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    __weak typeof(self) wself = self;
    [_codeReader setCompletionWithBlock:^(NSString * _Nullable resultAsString) {
        NSLog(@"resultAsString:%@", resultAsString);
        //[[[UIAlertView alloc] initWithTitle:@"二维码" message:resultAsString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        
        // if reader complete, stop scanning, pop / dismiss viewController or show your controller
        // [weakSelf.codeReader stopScanning];
    }];
    
    
    // 设置二维码可读屏幕范围
    [[NSNotificationCenter defaultCenter] addObserverForName:AVCaptureInputPortFormatDescriptionDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue currentQueue]
                                                  usingBlock: ^(NSNotification *_Nonnull note) {
                                                      [wself setQRReaderRect:wself.scanView.scanRect];
                                                  }];
    
    
    btn_cameraDevice.hidden = [_codeReader hasFrontDevice];
    btn_flashMode.hidden = [_codeReader isTorchAvailable];
    
    
    
    
    
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_codeReader startScanning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_codeReader stopScanning];
    
    [super viewWillDisappear:animated];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    _codeReader.previewLayer.frame = self.view.bounds;
}




#pragma mark - Autorotate
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}







#pragma mark - IBActions
- (IBAction)cameraDeviceModeAction:(id)sender
{
    [_codeReader switchDeviceInput];
}

- (IBAction)toggleTorchAction:(id)sender
{
    [_codeReader toggleTorch];
}







#pragma mark - Public Methods
- (void)setQRReaderRect:(CGRect)rect
{
    _codeReader.metadataOutput.rectOfInterest = [_codeReader.previewLayer metadataOutputRectOfInterestForRect:rect];
    
}










@end

















