//
//  MJViewController.m
//  04-大头针
//
//  Created by apple on 14-5-29.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJViewController.h"
#import "MJAnnotation.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MJViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.跟踪用户位置(显示用户的具体位置)
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    // 2.设置代理
    self.mapView.delegate = self;
    
    // 3.监听mapView的点击事件
    [self.mapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMapView:)]];
}

/**
 *  监听mapView的点击
 */
- (void)tapMapView:(UITapGestureRecognizer *)tap
{
    // 1.获得用户在mapView点击的位置（x，y）
    CGPoint point = [tap locationInView:tap.view];
    
    // 2.将数学坐标 转为 地理经纬度坐标
    CLLocationCoordinate2D coordinate = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    
    // 3.创建大头针模型，添加大头针到地图上
    MJAnnotation *anno = [[MJAnnotation alloc] init];
    anno.coordinate = coordinate;
    anno.title = @"传智播客";
    anno.subtitle = @"传智播客传智播客传智播客传智播客";
    [self.mapView addAnnotation:anno];
    
    // 纬度范围：N 3°51′ ~  N 53°33′
    // 经度范围：E 73°33′ ~  E 135°05′

//    for (int i = 0; i<1000; i++) {
//        MJAnnotation *anno = [[MJAnnotation alloc] init];
//        CLLocationDegrees latitude = 4 + arc4random_uniform(50);
//        CLLocationDegrees longitude = 73 + arc4random_uniform(60);
//        anno.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
//        anno.title = @"传智播客";
//        anno.subtitle = @"传智播客传智播客传智播客传智播客";
//        [self.mapView addAnnotation:anno];
//    }
}

#pragma mark - MKMapViewDelegate
/**
 *  当用户的位置更新，就会调用（不断地监控用户的位置，调用频率特别高）
 *
 *  @param userLocation 表示地图上蓝色那颗大头针的数据
 */
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    // 取出用户当前的经纬度
    CLLocationCoordinate2D center = userLocation.location.coordinate;
    
    // 设置地图的中心点（以用户所在的位置为中心点）
    //    [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    
    // 设置地图的显示范围
    MKCoordinateSpan span = MKCoordinateSpanMake(0.5, 0.5);
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    [mapView setRegion:region animated:YES];
}

@end
