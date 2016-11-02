//
//  ProgressVC.m
//  WKWebViewEx
//
//  Created by hd-apple10 on 10/14/16.
//
//

#import "ProgressVC.h"
#import <WebKit/WebKit.h>

@interface ProgressVC () <WKNavigationDelegate>
{
    WKWebView *webV;
    IBOutlet UIProgressView *progressView;
    
}

@end

@implementation ProgressVC


#pragma mark - dealloc
- (void)dealloc
{
    [webV removeObserver:self forKeyPath:@"estimatedProgress"];
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
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
    
    self.title = @"Progress";
    
    WKWebViewConfiguration *configure = [[WKWebViewConfiguration alloc] init];
    WKPreferences *preference = [[WKPreferences alloc] init];
    preference.minimumFontSize = 10;
    configure.preferences = preference;
    
    webV = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configure];
    webV.navigationDelegate = self;
    [self.view insertSubview:webV belowSubview:progressView];
    
    if (_urlStr.length == 0) {
        _urlStr = @"http://www.github.com";
    }
    [webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
    
    [webV addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}





#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    progressView.progress = 0.0;
    self.title = webView.title.length ? webV.title : self.title;
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"load fail");
    progressView.progress = 0.0;
    
}




#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"estimatedProgress"])
    {
        // NSLog(@"progress: %f", webV.estimatedProgress);
        progressView.progress = webV.estimatedProgress;
        
    }
    
}













@end
