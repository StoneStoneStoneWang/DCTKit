//
//  WLCacheUtil.h
//  WLThirdUtilDemo
//
//  Created by three stone 王 on 2019/4/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class YYCache;

NS_SWIFT_NAME(DCTYY)
@interface DCTYYCahce : NSObject

+ (instancetype)shared;

@property (nonatomic ,strong , readonly) YYCache *cache;

- (void)createCache:(NSString *)name;

- (void)saveObj:(id<NSCoding>)obj withKey:(NSString *)key;

- (nullable id <NSCoding>)fetchObj:(NSString *)key;

- (BOOL)checkEnv;

@end

NS_ASSUME_NONNULL_END
