//
//  DCTTViewController.h
//  ZTransiton
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>
@import DCTBase;
NS_ASSUME_NONNULL_BEGIN

@interface DCTTViewController : DCTBaseViewController 

@property(nonatomic,strong,readonly) UIPercentDrivenInteractiveTransition *DCTInteractivePopTransition;

@property (nonatomic ,assign) BOOL canPanResponse;

- (void)handlePopRecognizer:(UIPanGestureRecognizer *)recognizer;

@end

NS_ASSUME_NONNULL_END
