//
//  DCTOSSManager.h
//  WLThirdUtilDemo
//
//  Created by three stone 王 on 2019/4/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(DCTOSS)
@interface DCTOSSManager : NSObject

+ (instancetype)shared;

- (void)uploadData:(NSData *)data
     andProjectKey:(NSString *)projectKey
    andAccessKeyId:(NSString *)accessKeyId
andAccessKeySecret:(NSString *)accessKeySecret
  andSecurityToken:(NSString *)securityToken
       andProgress:(void (^) (int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend))progress
           andSucc:(void (^)(NSString * _Nonnull))succ
           andFail:(void (^)(NSError * _Nonnull))fail;

@end

NS_ASSUME_NONNULL_END
