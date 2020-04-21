//
//  DCTCarouselViewController.h
//  DCTContainer
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "DCTConfig.h"
@import DCTCollection;

NS_ASSUME_NONNULL_BEGIN

@interface DCTCarouselViewController : DCTCollectionNoLoadingViewController

+ (instancetype)createCarousel;

@end

NS_ASSUME_NONNULL_END
