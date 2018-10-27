//
//  JLMPublicLocation.m
//  JLMClient
//
//  Created by yangshuai on 2017/10/27.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "YSPublicLocation.h"

@implementation YSPublicLocation

+ (YSPublicLocation *)sharedManager{
    static YSPublicLocation *SharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SharedInstance = [[YSPublicLocation alloc] init];
    });
    return SharedInstance;
}
#pragma mark ----- 获取位置相关代理
//开始定位
- (void)getLocationDidFinishBlock:(getLocationDidFinish)sucessblock errorBolck:(getLocationDidError)errorBlock{
    self.sucessblock = sucessblock;
    self.errorBlock = errorBlock;
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 100.0f;
        self.locationManager.desiredAccuracy= 10;
        if ([[[UIDevice currentDevice]systemVersion]doubleValue] >8.0){
            [self.locationManager requestWhenInUseAuthorization];
        }
        [self.locationManager startUpdatingLocation];
        
    }else{
        //不能定位用户的位置的情况再次进行判断，并给与用户提示
        
        //1.提醒用户检查当前的网络状况
        
        //2.提醒用户打开定位开关
        NSLog(@"定位或者网络异常");
    }
    
}
//刷新位置 获取经纬度
- (void)refreshLoctionDidFinish:(getCoordinateDidFinish)block{
    self.coordinateBlock  = block;
    [self.locationManager startUpdatingLocation];
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    /*设置提示提示用户打开定位服务*/
    NSLog(@"%@",error);
    if (self.errorBlock) {
        self.errorBlock(error);
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
//反地理编码
    [self.geocoder reverseGeocodeLocation:manager.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //判断是否有错误或者placemarks是否为空
        if (error !=nil || placemarks.count==0) {
            NSLog(@"%@",error);
            return ;
        }
        CLPlacemark *placemark = placemarks[0];
        self.longitude =  placemark.location.coordinate.longitude;
        self.latitude =  placemark.location.coordinate.latitude;
        if (self.sucessblock) {
            self.sucessblock(placemark);
        }
        if (self.coordinateBlock) {
            self.coordinateBlock(self.longitude,self.latitude);
        }
        
        [self.locationManager stopUpdatingLocation];
    }];

}
- (CLLocationManager *)locationManager{
    if(!_locationManager){
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    
    return _locationManager;
}
- (CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}
@end
