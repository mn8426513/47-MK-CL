//
//  MJViewController.m
//  01-CoreLocation的使用
//
//  Created by apple on 14-5-29.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface MJViewController () <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locMgr;
@end

@implementation MJViewController

- (CLLocationManager *)locMgr
{
#warning 定位服务不可用
    if(![CLLocationManager locationServicesEnabled]) return nil;
    
    if (!_locMgr) {
        // 创建定位管理者
        self.locMgr = [[CLLocationManager alloc] init];
        // 设置代理
        self.locMgr.delegate = self;
    }
    return _locMgr;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 开始定位用户的位置
    [self.locMgr startUpdatingLocation];
    
    // 开始监控某个位置
    CLRegion *region = [[CLRegion alloc] init];
    /**
     ........
     */
    [self.locMgr startMonitoringForRegion:region];
}

/**
 *  计算2个经纬度之间的直线距离
 */
- (void)countLineDistance
{
    // 计算2个经纬度之间的直线距离
    CLLocation *loc1 = [[CLLocation alloc] initWithLatitude:40 longitude:116];
    CLLocation *loc2 = [[CLLocation alloc] initWithLatitude:41 longitude:116];
    CLLocationDistance distance = [loc1 distanceFromLocation:loc2];
    NSLog(@"%f", distance);
}

#pragma mark - CLLocationManagerDelegate
/**
 *  只要定位到用户的位置，就会调用（调用频率特别高）
 *  @param locations : 装着CLLocation对象
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // 1.取出位置对象
    CLLocation *loc = [locations firstObject];
    
    // 2.取出经纬度
    CLLocationCoordinate2D coordinate = loc.coordinate;
    
    // 3.打印经纬度
    NSLog(@"didUpdateLocations------%f %f", coordinate.latitude, coordinate.longitude);
    
    // 停止定位(省电措施：只要不想用定位服务，就马上停止定位服务)
    [manager stopUpdatingLocation];
}
@end
