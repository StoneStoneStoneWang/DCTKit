//
//  CATAMapViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "CATAMapTViewController.h"
@import CATAMap;
@import CoreLocation;
#import <SToolsKit/SLog.h>
@interface CATAMapTViewController ()

@property (nonatomic ,strong ,readwrite) CATAMapView *CATMapView;

@property (nonatomic ,strong ,readwrite) CATLocation *CATLocation;

@end

@implementation CATAMapTViewController

- (CATAMapView *)CATMapView {
    
    if (!_CATMapView) {
        
        _CATMapView = [[CATAMapView alloc] initWithFrame:self.view.bounds];
        
        _CATMapView.mapType = MAMapTypeStandard;
        
        _CATMapView.showsUserLocation = true;
        
        _CATMapView.showsScale = false;
        
        _CATMapView.showsCompass = false;
        
        _CATMapView.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        
        _CATMapView.delegate = self;
        
        _CATMapView.CATLeftResp = 100;
    }
    return _CATMapView;
}
- (CATLocation *)CATLocation {
    
    if (!_CATLocation) {
        
        _CATLocation = [CATLocation new];
        
    }
    return _CATLocation;
}

+ (instancetype)createAMapWithLat:(CLLocationDegrees )lat andLon:(CLLocationDegrees)lon {
    
    return [[self alloc] initWithLat:lat andLon:lon];
}
- (instancetype)initWithLat:(CLLocationDegrees )lat andLon:(CLLocationDegrees)lon {
    
    if (self = [super init]) {
        
        self.lat = lat;
        
        self.lon = lon;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.CATMapView setZoomLevel:16.5f animated:false];
    
    __weak typeof(self) weakSelf = self;
    
#if TARGET_IPHONE_SIMULATOR //模拟器
    
    if (!self.lat && !self.lon) {
        
        self.lat = 40.976204;
        
        self.lon = 117.939152;
    }
    
    CLLocation *l = [[CLLocation alloc] initWithLatitude:self.lat longitude:self.lon];
    
    [weakSelf.CATMapView setCenterCoordinate:l.coordinate animated:true];
    
    [weakSelf CATFetchLocaiton:l];
    
#elif TARGET_OS_IPHONE //真机
    [self.CATLocation CATStartLocation:^(CLLocation * _Nonnull location) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //            40.976204 117.939152
            
            [weakSelf.CATMapView setCenterCoordinate:location.coordinate animated:true];
            
            [weakSelf CATFetchLocaiton:location];
            
        });
        
    }];
#endif
}
- (void)CATFetchLocaiton:(CLLocation *)location {
    
    // MARK: Do something in child
}
-(void)addOwnSubViews {
    [super addOwnSubViews];
    
    [self.view addSubview:self.CATMapView];
}

- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    self.CATMapView.frame = self.view.bounds;
}
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    
    
}
- (void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    
    
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    
    
}

@end

