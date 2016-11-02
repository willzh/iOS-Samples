//
//  QRCodeGeneratorVC.m
//  QRCodeEx
//
//  Created by  on 10/12/16.
//  Copyright © 2016 . All rights reserved.
//


#import "QRCodeGeneratorVC.h"


@interface QRCodeGeneratorVC ()

@end


@implementation QRCodeGeneratorVC


#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self generateQRCode:@"http://www.baidu.com"];
    
    [self readerQRCodeFromImage:[UIImage imageNamed:@"IMG_0514"]];
    
    
    
}





- (void)generateQRCode:(NSString *)codeStr
{
    // 官方建议使用 NSISOLatin1StringEncoding 来编码，但经测试这种编码对中文或表情无法生成，改用 NSUTF8StringEncoding 就可以了。 字符串或者url均可
    NSData *stringData = [codeStr dataUsingEncoding:NSUTF8StringEncoding];
    
    /* 
     CIQRCodeGenerator 有两个属性可以设置，inputMessage 和 inputCorrectionLevel。
     inputMessage 是一个 NSData 对象，可以是字符串也可以是一个 URL。
     inputCorrectionLevel 是一个单字母（@"L", @"M", @"Q", @"H" 中的一个），表示不同级别的容错率，默认为 @"M"。
     
     inputCorrectionLevel
     　　parameter controls the amount of additional data encoded in the output image to provide error correction. Higher levels of error correction result in larger output images but allow larger areas of the code to be damaged or obscured without. There are four possible correction modes (with corresponding error resilience levels):
     L　: 7%
     M　: 15%
     Q　: 25%
     H　: 30%
     
     */
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    // 通过这个属性改变填充颜色
    UIColor *onColor  = [UIColor yellowColor]; // 二维码线条颜色
    UIColor *offColor = [UIColor redColor];   // 背景色
    
    // 指定滤镜名称构成滤镜链条完成合成效果
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"];
    [colorFilter setValue:qrFilter.outputImage forKey:@"inputImage"];
    [colorFilter setValue:[CIColor colorWithCGColor:onColor.CGColor] forKey:@"inputColor0"];
    [colorFilter setValue:[CIColor colorWithCGColor:offColor.CGColor] forKey:@"inputColor1"];
    
    // 生成的图片尺寸(outputImage.extent.size)会比较小，需要对它进行缩放。
    // 也可以根据自己想要的尺寸来重绘图片
    // the output image size is small, so need scale it or render it with you wanted size.
    CIImage *qrImage = colorFilter.outputImage;
    NSLog(@"qr image size:%@", NSStringFromCGSize(qrImage.extent.size));
    
    CIImage *transformImage = [qrImage imageByApplyingTransform:CGAffineTransformMakeScale(10, 10)]; // 放大10倍
    
    UIImage *codeimgae = [UIImage imageWithCIImage:transformImage];
    NSLog(@"result image size:%@", NSStringFromCGSize(codeimgae.size));
    
    imgV_Code.image = codeimgae;
    
}




- (void)readerQRCodeFromImage:(UIImage *)image
{
    CIImage *inputImg  = [CIImage imageWithCGImage:image.CGImage];
    CIDetector *dector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:nil];
    NSArray *array     = [dector featuresInImage:inputImg];
    
    for (CIFeature *feature in array)
    {
        if([feature isKindOfClass:[CIQRCodeFeature class]])
        {
            CIQRCodeFeature *code = (CIQRCodeFeature *)feature;
            [[[UIAlertView alloc] initWithTitle:@"二维码" message:code.messageString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
            
            return;
        }
    }
    
}





























@end
