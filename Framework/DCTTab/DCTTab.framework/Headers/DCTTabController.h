//
//  DCTTabBarConntroller.h
//  ZTab
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DCTTabController : UITabBarController

- (void)addChildViewController:(UIViewController *)childController
                      andTitle:(NSString *)title
                andNormalColor:(NSString *)normalColor
              andSelectedColor:(NSString *)selectedColor
                andNormalImage:(NSString *)normalImage
                andSelectImage:(NSString *)selectImage;

@end

NS_ASSUME_NONNULL_END
