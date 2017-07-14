//
//  ViewController.m
//  HZCityPicker
//
//  Created by 黄泽 on 2017/7/13.
//  Copyright © 2017年 黄泽. All rights reserved.
//

#import "ViewController.h"
#import "CityPickerController.h"
#import "HZLocation.h"
@interface ViewController ()<CityPickerDelegate,HZLocationDelegate>
//城市名字
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
/** 城市定位管理器*/
@property (nonatomic, strong) HZLocation *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.locationManager = [[HZLocation alloc] init];
    _locationManager.delegate = self;
   
}

//跳转城市选择
- (IBAction)btnClick:(id)sender {
    
    CityPickerController *cityPickerVC = [[CityPickerController alloc] init];
    [cityPickerVC setDelegate:self];
    
    cityPickerVC.locationCityName = _cityLabel.text;
    cityPickerVC.hotCitys = @[@"兰州市", @"酒泉市", @"北京市", @"海口市"];
    //
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
        
    }];
}

#pragma mark - CityPickerDelegate
//点击后传值
- (void) cityPickerController:(CityPickerController *)cityPickerViewController didSelectCity:(CityModel *)city
{
    
    _cityLabel.text = city.cityName;
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) cityPickerControllerDidCancel:(CityPickerController *)cityPickerViewController
{
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark --- HZLocationDelegate

//定位中...
- (void)locating {
    NSLog(@"定位中...");
}

//定位成功
- (void)currentLocation:(NSDictionary *)locationDictionary {
    NSString *city = [locationDictionary valueForKey:@"City"];
   
    if (![_cityLabel.text isEqualToString:city]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"您定位到%@，确定切换城市吗？",city] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _cityLabel.text = city;

        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    
}

/// 拒绝定位
- (void)refuseToUsePositioningSystem:(NSString *)message {
    NSLog(@"%@",message);
}

/// 定位失败
- (void)locateFailure:(NSString *)message {
    NSLog(@"%@",message);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
