//
//  JLMRootWebView.m
//  CrowdFunding
//
//  Created by yangshuai on 2017/7/27.
//  Copyright © 2017年 lxl. All rights reserved.
//

#import "JLMRootWebView.h"
#import "MRProgressLayer.h"
#import <Reachability/Reachability.h>
@interface JLMRootWebView ()<UIWebViewDelegate>
@property (nonatomic, strong) MRProgressLayer *layer;
@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, assign) BOOL authenticated;
@end

@implementation JLMRootWebView
- (void)viewDidLoad {
    [super viewDidLoad];
    _authenticated = NO;
    Reachability *reach = [Reachability reachabilityForInternetConnection]; NetworkStatus internetStatus = [reach currentReachabilityStatus]; if (internetStatus) {
        [self createWebView];
        [self createProgressView];
    } else {
        [MRProgressHUD showMessage:kWebLoadingFailedText inView:self.view];
    }
}
- (void)createProgressView{
    _layer = [MRProgressLayer new];
    _layer.progressStyle = DKProgressStyle_Noraml;
    _layer.progressColor = kBuleColor;
    _layer.frame = CGRectMake(0, kNaviBarHeight-2, 0, 2);
    [self.navigationView.layer addSublayer:_layer];
}
- (void)createWebView{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kNaviBarHeight, kWidth, kHeight - kNaviBarHeight)];
    // 2.创建URL
    // 3.创建Request
    [self.view addSubview:webView];
    self.webView = webView;
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    NSString * fileUrl = _urlString;
    NSString *urlString = [fileUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self.webView loadRequest:self.request];
}

- (void)backToTop{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [_layer progressAnimationStart];
}
//
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.titleLabel.text = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [_layer progressAnimationCompletion];
}
//
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [_layer progressAnimationCompletion];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_layer progressAnimationCompletion];
}
- (void)leftBtnClicked:(UIButton *)leftBtn{
    if ([self.webView canGoBack]) {
        //如果有则返回
        [self.webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    NSString* scheme = [[request URL] scheme];
    if ([scheme isEqualToString:@"https"]) {
        if (!_authenticated) {
            _request = request;
            _authenticated = NO;
            _urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            [_urlConnection start];
            return NO;
            
        }
    }
    return YES;
}
#pragma mark - NSURLConnection Delegate

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;
{
    if ([challenge previousFailureCount] == 0)
    {
        _authenticated = YES;
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
    } else {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
{
    _authenticated =YES;
    [self.webView loadRequest:_request];
    
    [_urlConnection cancel];
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}


@end
