//
//  DCTUploadManager.h
//  DUpload
//
//  Created by three stone 王 on 2019/7/24.
//  Copyright © 2019 three stone 王. All rights reserved.
//

@import Foundation;
@import AFNetworking;
#import "DCTALCredentialsBean.h"
NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(DCTUpload)
@interface DCTUploadManager : NSObject

#pragma mark ---- 不是json errorcode 131
+ (void)fetchAliObjWithUrl:(NSString *)url
                 andParams:(NSDictionary *)params
                 andHeader:(NSDictionary *)header
                   andSucc:(nonnull void (^)(DCTALCredentialsBean * _Nonnull))success
                   andFail:(nonnull void (^)(NSError * _Nonnull))failure;

+ (void)uploadAvatarWithData:(NSData *)data
                     andFile:(NSString *)file
                      andUid:(NSString *)uid
                   andParams:(DCTALCredentialsBean *)credentialsBean
                     andSucc:(void (^)(NSString * _Nonnull))success
                     andFail:(void (^)(NSError * _Nonnull))failure;

+ (void)uploadImageWithData:(NSData *)data
                    andFile:(NSString *)file
                     andUid:(NSString *)uid
                  andParams:(DCTALCredentialsBean *)credentialsBean
                    andSucc:(void (^)(NSString * _Nonnull))success
                    andFail:(void (^)(NSError * _Nonnull))failure;

#pragma mark ---- 视频大于10兆 errorcode 132
+ (void)uploadVideoWithData:(NSData *)data
                    andFile:(NSString *)file
                     andUid:(NSString *)uid
                  andParams:(DCTALCredentialsBean *)credentialsBean
                    andSucc:(void (^)(NSString * _Nonnull))success
                    andFail:(void (^)(NSError * _Nonnull))failure;

@end

NS_ASSUME_NONNULL_END
