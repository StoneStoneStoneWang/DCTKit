//
//  CATAMapViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//
#import <MAMapKit/MAMapKit.h>
@import CATTransition;
#import "CATConfig.h"
NS_ASSUME_NONNULL_BEGIN

@class CATAMapView;
@class CATLocation;

NS_SWIFT_NAME(CATAMapViewController)
@interface CATAMapTViewController : CATTViewController <MAMapViewDelegate>

+ (instancetype)createAMapWithLat:(CLLocationDegrees )lat andLon:(CLLocationDegrees)lon;

@property (nonatomic ,strong ,readonly) CATAMapView *CATMapView;

@property (nonatomic ,strong ,readonly) CATLocation *CATLocation;

@property (nonatomic ,assign) CLLocationDegrees lat;

@property (nonatomic ,assign) CLLocationDegrees lon;

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation;

- (void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated;

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views;

- (void)CATFetchLocaiton:(CLLocation *)location;

@end

NS_ASSUME_NONNULL_END
