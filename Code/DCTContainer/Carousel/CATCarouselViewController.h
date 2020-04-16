//
//  CATCarouselViewController.h
//  CATContainer
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "CATConfig.h"
@import CATCollection;

NS_ASSUME_NONNULL_BEGIN

@interface CATCarouselViewController : CATCollectionNoLoadingViewController

+ (instancetype)createCarousel;

@end

NS_ASSUME_NONNULL_END
