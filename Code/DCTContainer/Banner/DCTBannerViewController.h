//
//  DCTBannerViewController.h
//  DCTContainer
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "DCTConfig.h"
@import DCTCollection;

NS_ASSUME_NONNULL_BEGIN

@interface DCTBannerViewController : DCTCollectionNoLoadingViewController

+ (instancetype)createBannerWithBanners:(NSArray <NSDictionary *>*)banners;

@end

NS_ASSUME_NONNULL_END
