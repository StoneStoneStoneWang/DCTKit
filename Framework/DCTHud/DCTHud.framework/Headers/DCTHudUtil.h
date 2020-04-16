//
//  DCTHudUtil.h
//  WLThirdUtilDemo
//
//  Created by three stone 王 on 2019/4/3.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(DCTHud)
@interface DCTHudUtil : NSObject

+ (void)configHud NS_SWIFT_NAME(configHud());

+ (void)showActivity NS_SWIFT_NAME(show());

+ (void)showInfo:(NSString *_Nonnull)msg;

+ (void)showWithStatus:(NSString * _Nullable)msg;

+ (void)pop NS_SWIFT_NAME(pop());

@end

NS_ASSUME_NONNULL_END
