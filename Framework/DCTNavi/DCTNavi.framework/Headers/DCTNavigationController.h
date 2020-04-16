//
//  DCTNavigationController.h
//  ZNavi
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationBar+DCT.h"
#import "UIBarButtonItem+DCT.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DCTNavigationConfig <NSObject>

@property (nonatomic ,assign) CGFloat DCTFontSize;

@property (nonatomic ,strong) UIColor *DCTNormalTitleColor;

@property (nonatomic ,strong) UIColor *DCTLoginTitleColor;

@property (nonatomic ,strong) UIColor *DCTNormalBackgroundColor;

@property (nonatomic ,strong) UIColor *DCTLoginBackgroundColor;

@property (nonatomic ,copy) NSString *DCTNormalBackImage;

@property (nonatomic ,copy) NSString *DCTLoginBackImage;

@end

@interface DCTNavigationController : UINavigationController

+ (void)initWithConfig:(id <DCTNavigationConfig>) config;

@end

NS_ASSUME_NONNULL_END
