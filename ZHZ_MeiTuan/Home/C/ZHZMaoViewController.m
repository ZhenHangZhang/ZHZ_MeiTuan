//
//  ZHZMaoViewController.m
//  ZHZ_MeiTuan
//
//  Created by zhanghangzhen on 16/9/23.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

#import "ZHZMaoViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DPAPI.h"
#import "UIBarButtonItem+ZYExtension.h"
#import "ZHZConst.h"
#import "ZHZDeal.h"
#import "ZHZGategoty.h"
#import "ZHZMetaTool.h"
#import "ZHZBusiness.h"
#import "MJExtension.h"
#import "ZHZDealAnnotation.h"





@interface ZHZMaoViewController ()<CLLocationManagerDelegate, MKMapViewDelegate, DPRequestDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *mgr;

@property (nonatomic, strong) CLGeocoder *geocoder;
/**
 *  被反地理编码出来的城市
 */
@property (nonatomic, copy) NSString *city;

/**
 *  记录最后一次请求
 */
@property (nonatomic, strong) DPRequest *lastRequest;

@property (nonatomic, strong) NSArray *categoryArray;
@end

@implementation ZHZMaoViewController
- (NSArray *)categoryArray
{
    if (!_categoryArray) {
        _categoryArray = @[@"ic_category_2", @"ic_category_3", @"ic_category_4", @"ic_category_20", @"ic_category_22", @"ic_category_78"];
    }
    return _categoryArray;
}

- (CLGeocoder *)geocoder
{
    if (_geocoder == nil) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNar];

    [self setupMapView];
}
- (void)setupMapView
{
    // 注意:在iOS8中, 如果想要追踪用户的位置, 必须自己主动请求隐私权限
    self.mgr = [[CLLocationManager alloc] init];
    self.mgr.desiredAccuracy = kCLLocationAccuracyBest;
    self.mgr.distanceFilter = 1000;
    self.mgr.delegate = self;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [self.mgr requestAlwaysAuthorization];
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>= 9){
    
        self.mgr.allowsBackgroundLocationUpdates = YES;
    }
    
    //设置跟踪模式(MKUserTrackingModeFollow == 跟踪)
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    self.mapView.delegate = self;
    
    if ([CLLocationManager locationServicesEnabled]) {  //判断是否可以定位
        [self.mgr startUpdatingLocation]; //如果网络正常、定位开关打开的情况下，开始定位
    }
    else{  //通知用户，检查网络，或者是否打开定位开关
        NSLog(@"请检查网络");
    }
}
- (void)setupNar
{
    self.navigationItem.title = @"地图";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(clickLeftBarButton) normalImage:@"icon_back" highImage:@"icon_back_highlighted"];
}
- (void)clickLeftBarButton
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ----dealloc
- (void)dealloc
{
    // 注意，当不再需要定位服务了，需要停止定位，不然会很耗电
    [self.mgr stopUpdatingLocation];
}

#pragma mark ----MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    // 让地图显示到用户所在的中心位置
    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.location.coordinate, MKCoordinateSpanMake(0.5, 0.5));
    [mapView setRegion:region animated:YES];
    
    // 经纬度 --> 城市名 : 反地理编码
    // 城市名 --> 经纬度 : 地理编码
    [self.geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (error || placemarks.count == 0) {
            return;
        }
        
        CLPlacemark *placemark = [placemarks firstObject];
        
        NSString *city = placemark.locality ? placemark.locality : placemark.addressDictionary[@"State"];
        self.city = [city substringToIndex:city.length - 1];
        
        NSString *subStr = [self.city substringWithRange:NSMakeRange(self.city.length - 2, 2)];
        if ([subStr isEqualToString:@"市辖"]) {
            self.city = [self.city substringToIndex:self.city.length - 3];
        }
        // 第一次发送请求给服务器
        [self mapView:self.mapView regionDidChangeAnimated:YES];
    }];
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if (self.city == nil) return;
    
    // 发送请求给服务器
    DPAPI *api = [[DPAPI alloc] init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"city"] = self.city;
    
    // 经纬度\显示范围
    params[@"latitude"] = @(mapView.region.center.latitude);
    params[@"longitude"] = @(mapView.region.center.longitude);
    params[@"radius"] = @(2000);
    self.lastRequest = [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(ZHZDealAnnotation *)annotation
{
    // 返回nil,意味着交给系统处理
    if (![annotation isKindOfClass:[ZHZDealAnnotation class]]) return nil;
    
    // 创建大头针控件
    static NSString *ID = @"deal";
    MKAnnotationView *annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (annoView == nil) {
        annoView = [[MKAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:ID];
        annoView.canShowCallout = YES;
    }
    // 设置模型(位置\标题\子标题)
    annoView.annotation = annotation;
    // 设置图片
    annoView.image = [UIImage imageNamed:annotation.icon];
    return annoView;
}



#pragma mark ----与服务器进行交互
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    if (request != self.lastRequest) return;
    
    NSArray *deals = [ZHZDeal objectArrayWithKeyValuesArray:result[@"deals"]];
    for (ZHZDeal *deal in deals) {
        
        // 获得团购所属的类型
        ZHZGategoty *category = [ZHZMetaTool categoryWithDeal:deal];
        
        for (ZHZBusiness *business in deal.businesses) {
            ZHZDealAnnotation *anno = [[ZHZDealAnnotation alloc] init];
            anno.coordinate = CLLocationCoordinate2DMake(business.latitude, business.longitude);
            anno.title = business.name;
            anno.subtitle = deal.title;
            anno.icon = category.map_icon;
            if (anno.icon == nil) {
                int r = arc4random_uniform(5);
                anno.icon = self.categoryArray[r];
            }
            //            NSLog(@"++++%@",anno.icon);
            if ([self.mapView.annotations containsObject:anno]) break;
            
            [self.mapView addAnnotation:anno];
        }
    }
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    if (request != self.lastRequest) return;
    
    NSLog(@"请求失败 - %@", error);
}


@end
