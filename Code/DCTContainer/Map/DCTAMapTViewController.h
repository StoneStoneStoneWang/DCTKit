//
//  DCTAMapViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//
#import <MAMapKit/MAMapKit.h>
@import DCTTransition;
#import "DCTConfig.h"
NS_ASSUME_NONNULL_BEGIN

@class DCTAMapView;
@class DCTLocation;

NS_SWIFT_NAME(DCTAMapViewController)
@interface DCTAMapTViewController : DCTTViewController <MAMapViewDelegate>

+ (instancetype)createAMapWithLat:(CLLocationDegrees )lat andLon:(CLLocationDegrees)lon;

@property (nonatomic ,strong ,readonly) DCTAMapView *DCTMapView;

@property (nonatomic ,strong ,readonly) DCTLocation *DCTLocation;

@property (nonatomic ,assign) CLLocationDegrees lat;

@property (nonatomic ,assign) CLLocationDegrees lon;

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation;

- (void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated;

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views;

- (void)DCTFetchLocaiton:(CLLocation *)Location;

@end

NS_ASSUME_NONNULL_END
