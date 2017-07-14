//
//  HZLocation.m
//  HZCityPicker
//
//  Created by 黄泽 on 2017/7/14.
//  Copyright © 2017年 黄泽. All rights reserved.
//

#import "HZLocation.h"
#import <CoreLocation/CoreLocation.h>

@interface HZLocation ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation HZLocation

- (instancetype)init {
    if (self = [super init]) {
        [self startPositioningSystem];
    }
    return self;
}

- (void)startPositioningSystem {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    [self.locationManager startUpdatingLocation];
}

#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(locating)]) {
            [self.delegate locating];
        }
    });
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            NSDictionary *location = [placemark addressDictionary];
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                if (self.delegate && [self.delegate respondsToSelector:@selector(currentLocation:)]) {
                    [self.delegate currentLocation:location];
                }
            });
        }
    }];
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if ([error code] == kCLErrorDenied) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(refuseToUsePositioningSystem:)]) {
            [self.delegate refuseToUsePositioningSystem:@"已拒绝使用定位系统"];
        }
    }
    if ([error code] == kCLErrorLocationUnknown) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if (self.delegate && [self.delegate respondsToSelector:@selector(locateFailure:)]) {
                [self.delegate locateFailure:@"无法获取位置信息"];
            }
        });
    }
}
@end
