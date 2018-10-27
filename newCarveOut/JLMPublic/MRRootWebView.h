//
//  MRRootWebView.h
//  CrowdFunding
//
//  Created by yangshuai on 2017/7/27.
//  Copyright © 2017年 lxl. All rights reserved.
//
@class MRRootWebView;
@protocol FFTWebViewDelegate <NSObject>

- (void)didFinishBusinessProcess:(BOOL)finish;

@end
#import "MRBaseViewController.h"
@interface MRRootWebView : MRBaseViewController<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView * webView;
@property (nonatomic,  copy) NSString  * urlString;
@property (nonatomic,  copy) NSString  * tokenUrl;
@property (nonatomic,  copy) NSString  * titleString;
@property (nonatomic,assign) id<FFTWebViewDelegate>delegate;
- (void)initWebView;
@end
