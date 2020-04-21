//
//  DCTAMapViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "DCTAMapTViewController.h"
@import DCTAMap;
@import CoreLocation;
#import <SToolsKit/SLog.h>
@interface DCTAMapTViewController ()

@property (nonatomic ,strong ,readwrite) DCTAMapView *DCTMapView;

@property (nonatomic ,strong ,readwrite) DCTLocation *DCTLocation;

@end

@implementation DCTAMapTViewController

- (DCTAMapView *)DCTMapView {
    
    if (!_DCTMapView) {
        
        _DCTMapView = [[DCTAMapView alloc] initWithFrame:self.view.bounds];
        
        _DCTMapView.mapType = MAMapTypeStandard;
        
        _DCTMapView.showsUserLocation = true;
        
        _DCTMapView.showsScale = false;
        
        _DCTMapView.showsCompass = false;
        
        _DCTMapView.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        
        _DCTMapView.delegate = self;
        
        _DCTMapView.DCTLeftResp = 100;
    }
    return _DCTMapView;
}
- (DCTLocation *)DCTLocation {
    
    if (!_DCTLocation) {
        
        _DCTLocation = [DCTLocation new];
        
    }
    return _DCTLocation;
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
    
    [self.DCTMapView setZoomLevel:16.5f animated:false];
    
    __weak typeof(self) weakSelf = self;
    
#if TARGET_IPHONE_SIMULATOR //模拟器
    
    if (!self.lat && !self.lon) {
        
        self.lat = 40.976204;
        
        self.lon = 117.939152;
    }
    
    CLLocation *l = [[CLLocation alloc] initWithLatitude:self.lat longitude:self.lon];
    
    [weakSelf.DCTMapView setCenterCoordinate:l.coordinate animated:true];
    
    [weakSelf DCTFetchLocaiton:l];
    
#elif TARGET_OS_IPHONE //真机
    [self.DCTLocation DCTStartLocation:^(CLLocation * _Nonnull Location) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //            40.976204 117.939152
            
            [weakSelf.DCTMapView setCenterCoordinate:Location.coordinate animated:true];
            
            [weakSelf DCTFetchLocaiton:Location];
            
        });
        
    }];
#endif
}
- (void)DCTFetchLocaiton:(CLLocation *)Location {
    
    // MARK: Do something in child
}
-(void)addOwnSubViews {
    [super addOwnSubViews];
    
    [self.view addSubview:self.DCTMapView];
}

- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    self.DCTMapView.frame = self.view.bounds;
}
- (void)dealloc {
    
    [[NSNotifiDCTionCenter defaultCenter] removeObserver:self];
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    
    
}
- (void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    
    
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    
    
}

@end

