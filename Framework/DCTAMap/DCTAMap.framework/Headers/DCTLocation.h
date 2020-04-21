//
//  DCTLocation.h
//  WLThirdUtilDemo
//
//  Created by three stone 王 on 2019/5/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AMapLocationKit;
@import CoreLocation;

NS_ASSUME_NONNULL_BEGIN

typedef void(^DCTLocationBlock)(CLLocation *_Nullable location);

@interface DCTLocation : NSObject

@property (nonatomic ,strong ,readonly) AMapLocationManager *DCTAmlocation;

@property (nonatomic ,strong ,readonly) CLLocationManager *cllocation;

- (void)requestLocationWithReGeocodeWithCompletionBlock:(AMapLocatingCompletionBlock)completionBlock;

@property (nonatomic ,assign) CLAuthorizationStatus authStatus;

// 开始定位
- (void)DCTStartLocation:(DCTLocationBlock )location;

// 停止定位
- (void)DCTStopLocation;

@end

NS_ASSUME_NONNULL_END
