//
//  DCTIMManager.h
//  DCTIM
//
//  Created by 王磊 on 2020/4/27.
//  Copyright © 2020 王磊. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(DCTIM)
@interface DCTIMManager : NSObject

+ (void)initWithAppkey:(NSString * _Nonnull)appkey;

+ (void)initWithToken:(NSString * _Nonnull)token;

+ (void)initWithAppSecret:(NSString * _Nonnull)appSecret
                  andSucc:(void (^)(NSString * _Nonnull))success
                  andFail:(void (^)(NSError * _Nonnull))failure;

@end

NS_ASSUME_NONNULL_END
