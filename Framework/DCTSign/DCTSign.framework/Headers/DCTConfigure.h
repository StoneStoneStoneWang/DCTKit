//
//  ZSignConfigration.h
//  ZSign
//
//  Created by three stone 王 on 2019/8/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger ,DCTConfigureType) {
    /** 花店  */
    DCTConfigureTypeCleaner NS_SWIFT_NAME(cleaner) = 1,
};

NS_ASSUME_NONNULL_BEGIN

@interface DCTConfigure : NSObject

/** 初始化所有组件产品
 @param appKey 开发者在官网申请的appKey.
 @param domain 请求主地址
 @param ptype 类型 1.花店
 */
+ (void)initWithAppKey:(NSString * _Nonnull)appKey
                domain:(NSString * _Nonnull)domain
                 pType:(DCTConfigureType)ptype;

+ (NSString *)createSign:(NSDictionary *_Nonnull)json;

/**
 @result signature
 */
+ (NSString *)fetchSignature;

+ (NSString *)fetchAppKey;

+ (NSString *)fetchDomain;

+ (NSString *)fetchSmsSign;

+ (NSString *)fetchSmsLogin;

+ (NSString *)fetchSmsPwd;

+ (DCTConfigureType )fetchPType;

@end

NS_ASSUME_NONNULL_END
