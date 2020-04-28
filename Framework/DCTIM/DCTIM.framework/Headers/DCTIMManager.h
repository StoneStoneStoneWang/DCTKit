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

+ (void)connetWithUserId:(NSString * _Nonnull)userId
                 andName:(NSString * _Nonnull)name
              andHeadImg:(NSString * _Nonnull)headImg
           andFetchUserId:( void (^)(NSString * _Nonnull userId))fetchUserId
                 andFailure:( void (^)(NSError * _Nonnull error))failure;

@end

NS_ASSUME_NONNULL_END
