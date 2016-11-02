//
//  JSHandlerVC.m
//  WKWebViewEx
//
//  Created by hd-apple10 on 10/14/16.
//
//

#import "JSHandlerVC.h"
#import <WebKit/WebKit.h>


@interface JSHandlerVC () <WKNavigationDelegate, WKScriptMessageHandler, WKUIDelegate>
{
    UIActivityIndicatorView *aiv;
    WKWebView *webV;
}

@end



@implementation JSHandlerVC


#pragma mark - dealloc
- (void)dealloc
{
    
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
    
    WKWebViewConfiguration *configure = [[WKWebViewConfiguration alloc] init];
    
    WKPreferences *preference = [[WKPreferences alloc] init];
    preference.minimumFontSize = 20;
    preference.javaScriptEnabled = YES; 
    preference.javaScriptCanOpenWindowsAutomatically = NO;
    
    configure.preferences = preference;
    
    configure.userContentController = [[WKUserContentController alloc] init];
    
    
    webV = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configure];
    webV.navigationDelegate = self;
    webV.UIDelegate = self;
    [self.view addSubview:webV];
    
    [webV sizeToFit];
    
    NSString *str = [[NSBundle mainBundle] pathForResource:@"test.js" ofType:nil];
    [webV loadHTMLString:[NSString stringWithContentsOfFile:str encoding:NSUTF8StringEncoding error:nil] baseURL:nil];
    
//    // 添加一个JS到HTML中，这样就可以直接在JS中调用我们添加的JS方法
//    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:@"function showAlert() { alert('在载入webview时通过Swift注入的JS方法'); }" injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
//    [webV.configuration.userContentController addUserScript:userScript];
    
    
    aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    aiv.center = self.view.center;
    [self.view addSubview:aiv];
    
    [aiv startAnimating];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // js code can post message with the name
    [webV.configuration.userContentController addScriptMessageHandler:self name:@"methodIniOS"];
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // addScriptMessageHandler can make memory leak. need manually remove
    [webV.configuration.userContentController removeScriptMessageHandlerForName:@"methodIniOS"];
    
}



#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    [aiv stopAnimating];
    self.title = webView.title.length ? webV.title : self.title;
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"load fail");
    [aiv stopAnimating];
}



#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:@"methodIniOS"])
    {
        // support params type: NSNumber, NSString, NSDate, NSArray, NSDictionary, and NSNull 类型
        NSLog(@"message:%@", message.body);
        
        // do something
        
        
    }
}














@end
