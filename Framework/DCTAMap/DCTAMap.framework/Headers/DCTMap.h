//
//  WLMapUtil.h
//  WLThirdUtilDemo
//
//  Created by three stone 王 on 2019/5/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AMapFoundationKit;
NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(DCTAMap)
@interface DCTMap : NSObject

+ (instancetype)shared NS_SWIFT_NAME(DCTDefault());

- (void)registerApiKey:(NSString *)apiKey;

@end

NS_ASSUME_NONNULL_END
