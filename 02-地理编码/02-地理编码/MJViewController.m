//
//  MJViewController.m
//  02-地理编码
//
//  Created by apple on 14-5-29.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface MJViewController ()
@property (nonatomic, strong) CLGeocoder *geocoder;

#pragma mark - 地理编码
- (IBAction)geocode;
@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailAddressLabel;

#pragma mark - 反地理编码
- (IBAction)reverseGeocode;
@property (weak, nonatomic) IBOutlet UITextField *longtitudeField;
@property (weak, nonatomic) IBOutlet UITextField *latitudeField;
@property (weak, nonatomic) IBOutlet UILabel *reverseDetailAddressLabel;

@end

@implementation MJViewController

- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        self.geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

/**
 *  地理编码
 */
- (IBAction)geocode {
    NSString *address = self.addressField.text;
    if (address.length == 0) return;
    
    [self.geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) { // 有错误（地址乱输入）
            self.detailAddressLabel.text = @"你找的地址可能只在火星有！！！";
        } else { // 编码成功
            // 取出最前面的地址
            CLPlacemark *pm = [placemarks firstObject];
            
            // 设置经纬度
            self.latitudeLabel.text = [NSString stringWithFormat:@"%.1f", pm.location.coordinate.latitude];
            self.longitudeLabel.text = [NSString stringWithFormat:@"%.1f", pm.location.coordinate.longitude];
            
            // 设置具体地址
            self.detailAddressLabel.text = pm.name;
            
//            NSLog(@"总共找到%d个地址", placemarks.count);
//            
//            for (CLPlacemark *pm in placemarks) {
//                NSLog(@"-----地址开始----");
//                
//                NSLog(@"%f %f %@", pm.location.coordinate.latitude, pm.location.coordinate.longitude, pm.name);
//                
//                [pm.addressDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//                    NSLog(@"%@ %@", key, obj);
//                }];
//                
//                NSLog(@"-----地址结束----");
//            }
        }
    }];
}

/**
 *  反地理编码
 */
- (IBAction)reverseGeocode {
    // 1.包装位置
    CLLocationDegrees latitude = [self.latitudeField.text doubleValue];
    CLLocationDegrees longitude = [self.longtitudeField.text doubleValue];
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    // 2.反地理编码
    [self.geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) { // 有错误（地址乱输入）
            self.reverseDetailAddressLabel.text = @"你找的地址可能只在火星有！！！";
        } else { // 编码成功
            // 取出最前面的地址
            CLPlacemark *pm = [placemarks firstObject];
            
            // 设置具体地址
            self.reverseDetailAddressLabel.text = pm.name;
//            NSLog(@"总共找到%d个地址", placemarks.count);
//
//            for (CLPlacemark *pm in placemarks) {
//                NSLog(@"-----地址开始----");
//
//                NSLog(@"%f %f %@", pm.location.coordinate.latitude, pm.location.coordinate.longitude, pm.name);
//
//                [pm.addressDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//                    NSLog(@"%@ %@", key, obj);
//                }];
//
//                NSLog(@"-----地址结束----");
//            }
        }
    }];
}
@end
