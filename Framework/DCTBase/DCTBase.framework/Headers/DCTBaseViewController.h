//
//  DCTBaseViewController.h
//  ZBase
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(DCTBaseViewController)
@interface DCTBaseViewController  : UIViewController

- (void)configNaviItem NS_SWIFT_NAME(configNaviItem());

- (void)configOwnProperties NS_SWIFT_NAME(configOwnProperties());

- (void)addOwnSubViews NS_SWIFT_NAME(addOwnSubViews());

- (void)configOwnSubViews NS_SWIFT_NAME(configOwnSubViews());

- (void)configLoading NS_SWIFT_NAME(configLoading());

- (void)configViewModel NS_SWIFT_NAME(configViewModel());

- (void)prepareData NS_SWIFT_NAME(s_prepareData());

- (void)configAuto NS_SWIFT_NAME(configAuto());

- (void)addOwnSubViewController NS_SWIFT_NAME(addOwnSubViewController());

@end

NS_ASSUME_NONNULL_END
