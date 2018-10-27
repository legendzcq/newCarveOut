//
//  JLMPublicLocation.h
//  JLMClient
//
//  Created by yangshuai on 2017/10/27.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import <Foundation/Foundation.h>
//SubLocality 区 Thoroughfare小路 name详细地址
typedef void (^ getLocationDidFinish)   (CLPlacemark * placemark);
typedef void (^ getCoordinateDidFinish) (CGFloat longitude,CGFloat latitude);

typedef void (^ getLocationDidError) (NSError * error);
@interface YSPublicLocation : NSObject<CLLocationManagerDelegate>
- (void)getLocationDidFinishBlock:(getLocationDidFinish)sucessblock errorBolck:(getLocationDidError)errorBlock;

+ (YSPublicLocation*)sharedManager;
//刷新位置信息
- (void)refreshLoctionDidFinish:(getCoordinateDidFinish)block;

@property (nonatomic,strong) getLocationDidFinish sucessblock;
@property (nonatomic,strong) getLocationDidError errorBlock;
@property (nonatomic,strong) getCoordinateDidFinish  coordinateBlock;
@property (nonatomic,strong) CLLocationManager * locationManager;
@property (nonatomic,strong) CLGeocoder        *geocoder;

@property (nonatomic,assign) CGFloat    latitude;//纬度
@property (nonatomic,assign) CGFloat    longitude;//经度
@property (nonatomic,  copy) NSString * city;
@end



