//
//  YSNetWorkManager.m
//  MRShop
//
//  Created by yangshuai on 2017/8/24.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "YSNetWorkManager.h"
#import "Reachability.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetExportSession.h>
#import <AVFoundation/AVMediaFormat.h>
#import "UIImage+MRTool.h"
@implementation YSNetWorkManager

#pragma mark - shareManager
/**
 *  获得全局唯一的网络请求实例单例方法
  */

static YSNetWorkManager * manager;
+(instancetype)shareManager{
    @synchronized(self) {
        if(manager == nil) {
            manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:SERVER]];
        }
    }
    return manager;
}
+(void)deallocShareManager{
    manager = nil;
}

#pragma mark - 重写initWithBaseURL
/**
 *
 *
 *  @param url baseUrl
 *
 *  @return 通过重写夫类的initWithBaseURL方法,返回网络请求类的实例
 */

-(instancetype)initWithBaseURL:(NSURL *)url{
    if (self = [super initWithBaseURL:url]) {
        NSAssert(url,@"您需要为您的请求设置baseUrl");
        /**设置请求超时时间*/
        self.requestSerializer.timeoutInterval = 30;
        /**设置相应的缓存策略*/
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        /**分别设置请求以及相应的序列化器*/
        AFHTTPRequestSerializer *requestSerializer =  [AFHTTPRequestSerializer serializer];
        NSDictionary *headerFieldValueDictionary = @{@"version":[[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"],@"client":@"ios",@"token":kToken?:@""};
        if (headerFieldValueDictionary != nil) {
            for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
                NSString *value = headerFieldValueDictionary[httpHeaderField];
                [requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
            }
        }
        self.requestSerializer = requestSerializer;
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
        AFJSONResponseSerializer * response = [AFJSONResponseSerializer serializer];
        //        response.removesKeysWithNullValues = YES;
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.validatesDomainName = NO;
        securityPolicy.allowInvalidCertificates = YES;
        self.securityPolicy = securityPolicy;
        self.responseSerializer = response;
        /**复杂的参数类型 需要使用json传值-设置请求内容的类型*/
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        /**设置接受的类型*/
        [self.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain",@"application/json",@"text/json",@"text/javascript",@"text/html", nil]];        
    }
    return self;
}



#pragma mark - 网络请求的类方法---get/post

/**
 *  网络请求的实例方法
 *
 *  @param type         get / post
 *  @param urlString    请求的地址
 *  @param paraments    请求的参数
 *  @param successBlock 请求成功的回调
 */
//展示loading
+ (void)requestWithType:(HttpRequestType)type withUrlString:(NSString *)urlString withParaments:(id)paraments withSuccessBlock:(requestSuccess)successBlock{
    [MRProgressHUD show:kLoadingText inView:[[MRBaseViewController new] getCurrentVC].view];
    [self requestWithType:type withUrlString:urlString withParaments:paraments withSuccessBlock:successBlock withFailureBlock:nil progress:nil];
}
//不展示loading
+ (void)requestWithHideHUDType:(HttpRequestType)type withUrlString:(NSString *)urlString withParaments:(id)paraments withSuccessBlock:(requestSuccess)successBlock{
    [self requestWithType:type withUrlString:urlString withParaments:paraments withSuccessBlock:successBlock withFailureBlock:nil progress:nil];
}
/**
 *  返回失败block
 */
+ (void)requestWithType:(HttpRequestType)type withUrlString:(NSString *)urlString withParaments:(id)paraments withSuccessBlock:(requestSuccess)successBlock withFailureBlock:(requestFailure)failureBlock{
    [MRProgressHUD show:kLoadingText inView:[[MRBaseViewController new] getCurrentVC].view];
    [self requestWithType:type withUrlString:urlString withParaments:paraments withSuccessBlock:successBlock withFailureBlock:failureBlock progress:nil];
}
+(void)requestWithType:(HttpRequestType)type withUrlString:(NSString *)urlString withParaments:(id)paraments withSuccessBlock:(requestSuccess)successBlock withFailureBlock:(requestFailure)failureBlock progress:(downloadProgress)progress{
    switch (type) {
            case HttpRequestTypeGet:{
                [[YSNetWorkManager shareManager] GET:urlString parameters:paraments progress:^(NSProgress * _Nonnull downloadProgress) {
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    MRRequsetInfoModel * model = [MRRequsetInfoModel modelWithDictionary:responseObject[@"info"]];
                    if (failureBlock) {
                        successBlock(model);
                    }else{
                        if ([model.state intValue] ==0) {
                            [MRProgressHUD hide];
                            successBlock(model);
                        }else{
                            [MRProgressHUD showMessage:model.msg inView:[[MRBaseViewController new] getCurrentVC].view];
                            
                        }
                    }
                    if ([[[MRBaseViewController new] getCurrentVC] isKindOfClass:[MRBaseViewController class]]) {
                        [[[MRBaseViewController new] getCurrentVC].tableView.mj_header endRefreshing];
                        [[[MRBaseViewController new] getCurrentVC].tableView.mj_footer endRefreshing];
                    }
                    if ([responseObject[@"info"][@"data"] isKindOfClass:[NSDictionary class]]) {
                        if([responseObject[@"info"][@"data"] objectForKey:@"lastPage"]){
                            if ([responseObject[@"info"][@"data"][@"lastPage"] integerValue]==1) {
                                [[[MRBaseViewController new] getCurrentVC].tableView.mj_footer setHidden:YES];
                            }else{
                                [[[MRBaseViewController new] getCurrentVC].tableView.mj_footer setHidden:NO];
                            }
                        }
                    }

                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if ([[[MRBaseViewController new] getCurrentVC] isKindOfClass:[MRBaseViewController class]]) {
                        [[[MRBaseViewController new] getCurrentVC].tableView.mj_header endRefreshing];
                        [[[MRBaseViewController new] getCurrentVC].tableView.mj_footer endRefreshing];
                    }
                        [[[MRBaseViewController new] getCurrentVC].tableView.mj_footer setHidden:YES];
                    [MRProgressHUD showMessage:kLoadingFailedText inView:[[MRBaseViewController new] getCurrentVC].view];
                    if (failureBlock) {
                        failureBlock(error);
                    }
                }];
                break;
            }
            
            case HttpRequestTypePost:{
                [[YSNetWorkManager shareManager] POST:urlString parameters:paraments progress:^(NSProgress * _Nonnull uploadProgress) {
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    MRRequsetInfoModel * model = [MRRequsetInfoModel modelWithDictionary:responseObject[@"info"]];
                    if (failureBlock) {
                        successBlock(model);
                    }else{
                        if ([model.state intValue] ==0) {
                            [MRProgressHUD hide];
                            successBlock(model);
                        }else{
                            [MRProgressHUD showMessage:model.msg inView:[[MRBaseViewController new] getCurrentVC].view];
                        }
                    }
                    if ([[[MRBaseViewController new] getCurrentVC] isKindOfClass:[MRBaseViewController class]]) {
                        [[[MRBaseViewController new] getCurrentVC].tableView.mj_header endRefreshing];
                        [[[MRBaseViewController new] getCurrentVC].tableView.mj_footer endRefreshing];
                    }
                    if ([responseObject[@"info"][@"data"] isKindOfClass:[NSDictionary class]]) {
                        if([responseObject[@"info"][@"data"] objectForKey:@"lastPage"]){
                            if ([responseObject[@"info"][@"data"][@"lastPage"] integerValue]==1) {
                                [[[MRBaseViewController new] getCurrentVC].tableView.mj_footer setHidden:YES];
                            }else{
                                [[[MRBaseViewController new] getCurrentVC].tableView.mj_footer setHidden:NO];
                            }
                        }
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if ([[[MRBaseViewController new] getCurrentVC] isKindOfClass:[MRBaseViewController class]]) {
                        [[[MRBaseViewController new] getCurrentVC].tableView.mj_header endRefreshing];
                        [[[MRBaseViewController new] getCurrentVC].tableView.mj_footer endRefreshing];
                    }
                    [[[MRBaseViewController new] getCurrentVC].tableView.mj_footer setHidden:YES];

                    [MRProgressHUD showMessage:kLoadingFailedText inView:[[MRBaseViewController new] getCurrentVC].view];
                    if (failureBlock) {
                        failureBlock(error);
                    }
                }];
                break;
            }
            case HttpRequestTypeFormData:{
            [[YSNetWorkManager shareManager] POST:urlString parameters:paraments constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            } progress:^(NSProgress * _Nonnull uploadProgress) {
            
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                MRRequsetInfoModel * model = [MRRequsetInfoModel modelWithDictionary:responseObject[@"info"]];
                successBlock(model);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureBlock(error);
            }] ;
            break;
        }
    }
}


+(void)requestInfoWithType:(HttpRequestType)type withUrlString:(NSString *)urlString withParaments:(id)paraments withSuccessBlock:(requestInfoSuccess)successBlock withFailureBlock:(requestFailure)failureBlock progress:(downloadProgress)progress{
    switch (type) {
            case HttpRequestTypeGet:
        {
            [[YSNetWorkManager shareManager] GET:urlString parameters:paraments progress:^(NSProgress * _Nonnull downloadProgress) {
                progress(downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                successBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureBlock(error);
            }];
            break;
        }
            case HttpRequestTypePost:
        {
            [[YSNetWorkManager shareManager] POST:urlString parameters:paraments progress:^(NSProgress * _Nonnull uploadProgress) {
                progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                successBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureBlock(error);
            }];
        }
            case HttpRequestTypeFormData: {
                break;
            }
    }
}


#pragma mark - 视频上传

/**
 *  视频上传
 *
 *  @param operations   上传视频预留参数---视具体情况而定 可移除
 *  @param videoPath    上传视频的本地沙河路径
 *  @param urlString     上传的url
 *  @param successBlock 成功的回调
 *  @param failureBlock 失败的回调
 *  @param progress     上传的进度
 */

+(void)uploadVideoWithOperaitons:(NSDictionary *)operations withVideoPath:(NSString *)videoPath withUrlString:(NSString *)urlString withSuccessBlock:(requestSuccess)successBlock withFailureBlock:(requestFailure)failureBlock withUploadProgress:(uploadProgress)progress{
    /**获得视频资源*/
    AVURLAsset * avAsset = [AVURLAsset assetWithURL:[NSURL URLWithString:videoPath]];
    /**压缩*/
    //    NSString *const AVAssetExportPreset640x480;
    //    NSString *const AVAssetExportPreset960x540;
    //    NSString *const AVAssetExportPreset1280x720;
    //    NSString *const AVAssetExportPreset1920x1080;
    //    NSString *const AVAssetExportPreset3840x2160;
    AVAssetExportSession  *  avAssetExport = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPreset640x480];
    /**创建日期格式化器*/
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    /**转化后直接写入Library---caches*/
    NSString *  videoWritePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:[NSString stringWithFormat:@"/output-%@.mp4",[formatter stringFromDate:[NSDate date]]]];
    avAssetExport.outputURL = [NSURL URLWithString:videoWritePath];
    avAssetExport.outputFileType =  AVFileTypeMPEG4;
    [avAssetExport exportAsynchronouslyWithCompletionHandler:^{
        switch ([avAssetExport status]) {
                case AVAssetExportSessionStatusCompleted:
            {
                AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
                [manager POST:urlString parameters:operations constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    //获得沙盒中的视频内容
                    [formData appendPartWithFileURL:[NSURL fileURLWithPath:videoWritePath] name:@"write you want to writre" fileName:videoWritePath mimeType:@"video/mpeg4" error:nil];
                } progress:^(NSProgress * _Nonnull uploadProgress) {
                    progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
                } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
                    MRRequsetInfoModel * model = [MRRequsetInfoModel modelWithDictionary:responseObject[@"info"]];
                    successBlock(model);                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        failureBlock(error);
                    }];
                break;
            }
            default:
                break;
        }
    }];
}

#pragma mark - 文件下载


/**
 *  文件下载
 *
 *  @param operations   文件下载预留参数---视具体情况而定 可移除
 *  @param savePath     下载文件保存路径
 *  @param urlString        请求的url
 *  @param successBlock 下载文件成功的回调
 *  @param failureBlock 下载文件失败的回调
 *  @param progress     下载文件的进度显示
 */

+(void)downLoadFileWithOperations:(NSDictionary *)operations withSavaPath:(NSString *)savePath withUrlString:(NSString *)urlString withSuccessBlock:(requestSuccess)successBlock withFailureBlock:(requestFailure)failureBlock withDownLoadProgress:(downloadProgress)progress{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return  [NSURL URLWithString:savePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            failureBlock(error);
        }
    }];
}


#pragma mark -  取消所有的网络请求

/**
 *  取消所有的网络请求
 *  a finished (or canceled) operation is still given a chance to execute its completion block before it iremoved from the queue.
 */

+(void)cancelAllRequest
{
    [[YSNetWorkManager shareManager].operationQueue cancelAllOperations];
}



#pragma mark -   取消指定的url请求/
/**
 *  取消指定的url请求
 *
 *  @param requestType 该请求的请求类型
 *  @param string      该请求的完整url
 */

+(void)cancelHttpRequestWithRequestType:(NSString *)requestType requestUrlString:(NSString *)string
{
    NSError * error;
    /**根据请求的类型 以及 请求的url创建一个NSMutableURLRequest---通过该url去匹配请求队列中是否有该url,如果有的话 那么就取消该请求*/
    NSString * urlToPeCanced = [[[[YSNetWorkManager shareManager].requestSerializer requestWithMethod:requestType URLString:string parameters:nil error:&error] URL] path];
    for (NSOperation * operation in [YSNetWorkManager shareManager].operationQueue.operations) {
        //如果是请求队列
        if ([operation isKindOfClass:[NSURLSessionTask class]]) {
            //请求的类型匹配
            BOOL hasMatchRequestType = [requestType isEqualToString:[[(NSURLSessionTask *)operation currentRequest] HTTPMethod]];
            //请求的url匹配
            BOOL hasMatchRequestUrlString = [urlToPeCanced isEqualToString:[[[(NSURLSessionTask *)operation currentRequest] URL] path]];
            //两项都匹配的话  取消该请求
            if (hasMatchRequestType&&hasMatchRequestUrlString) {
                [operation cancel];
            }
        }
    }
}

+(BOOL) isConnectionAvailable{
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus]) {
            case NotReachable:
            isExistenceNetwork = NO;
            break;
            case ReachableViaWiFi:
            isExistenceNetwork = YES;
            break;
            case ReachableViaWWAN:
            isExistenceNetwork = YES;
            break;
    }
    return isExistenceNetwork;
}

static inline NSString *cachePath() {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/default"];
}

+ (void)clearCaches {
    NSString *directoryPath = cachePath();
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:directoryPath error:&error];
        if (error) {
            NSLog(@"HYBNetworking clear caches error: %@", error);
        } else {
            NSLog(@"HYBNetworking clear caches ok");
        }
    }
}

+ (float)totalCacheSize {
    NSString *directoryPath = cachePath();
    BOOL isDir = NO;
    float total = 0;
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:&isDir]) {
        if (isDir) {
            NSError *error = nil;
            NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:&error];
            if (error == nil) {
                for (NSString *subpath in array) {
                    NSString *path = [directoryPath stringByAppendingPathComponent:subpath];
                    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:path
                                                                                          error:&error];
                    if (!error) {
                        total += [dict[NSFileSize] unsignedIntegerValue];
                    }
                }
            }
        }
    }
    total = total/1000;
    return total;
}

#pragma mark - 多图上传
/**
 *  上传图片
 *
 *  @param operations   上传图片等预留参数---视具体情况而定 可移除
 *  @param imageArray   上传的图片数组
 *  @parm width      图片要被压缩到的宽度
 *  @param urlString    上传的url---请填写完整的url
 *  @param width 上传成功的回调
 *  @param failureBlock 上传失败的回调
 *  @param progress     上传进度
 *  @param fileName 文件名
 */
+(void)uploadImageWithOperations:(NSDictionary *)operations withImageArray:(NSArray *)imageArray withtargetWidth:(CGFloat )width withUrlString:(NSString *)urlString withFileName:(NSString*)fileName withSuccessBlock:(requestSuccess)successBlock withFailurBlock:(requestFailure)failureBlock withUpLoadProgress:(uploadProgress)progress{
    [[YSNetWorkManager shareManager] POST:urlString parameters:operations constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /**出于性能考虑,将上传图片进行压缩*/
        for (UIImage * image in imageArray) {
            NSData * imgData;
            //image的分类方法
            if (width !=0) {
                UIImage *  resizedImage =  [UIImage IMGCompressed:image targetWidth:width];
                imgData = UIImageJPEGRepresentation(resizedImage, .5);
            }else{
                imgData = UIImageJPEGRepresentation(image, .5);
            }
            //拼接data
            if (fileName.length !=0) {
                [formData appendPartWithFileData:imgData name:@"file" fileName:[NSString stringWithFormat:@"%@.jpg",fileName ] mimeType:@"image/jpg"];
            }else{
                [formData appendPartWithFileData:imgData name:@"file" fileName:@"image.jpg" mimeType:@"image/jpg"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSNumber * number = [NSNumber numberWithDouble:1.0*uploadProgress.completedUnitCount / uploadProgress.totalUnitCount];
        NSString* string = [NSString stringWithFormat:@"%.1f",[number floatValue]];
        progress([string floatValue]);
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        MRRequsetInfoModel * model = [MRRequsetInfoModel modelWithDictionary:responseObject[@"info"]];
        successBlock(model);
        //        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

@end
