//
//  DCTSearch.h
//  WLThirdUtilDemo
//
//  Created by three stone 王 on 2019/5/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AMapSearchKit;

NS_ASSUME_NONNULL_BEGIN

typedef void(^DCTRegeoSearchBlock)(NSString *city,NSString *street);

typedef void(^DCTTipSearchBlock)(NSArray<AMapTip *> *tips);

@interface DCTSearch : NSObject

- (void)DCTGeoSearchResp:(AMapGeoPoint *)location andResp:(DCTRegeoSearchBlock) resp;

/* 根据关键字来搜索POI. */
- (void)onTipSearchRespWithKeywords:(NSString *) keywords andCity:(NSString *)city andResp:(DCTTipSearchBlock) resp;

/* 根据ID来搜索POI. */
- (void)DCTTipSearchRespWithID:(NSString *)uid;

@property (nonatomic ,strong ,readonly) AMapSearchAPI *searchApi;

@end

NS_ASSUME_NONNULL_END
