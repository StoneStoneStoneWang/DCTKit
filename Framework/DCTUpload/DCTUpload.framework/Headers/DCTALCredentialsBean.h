//
//  DCTALCredentialsBean.h
//  DUpload
//
//  Created by three stone 王 on 2019/7/24.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(DCTALCredentialsBean)
@interface DCTALCredentialsBean : NSObject

@property (nonatomic ,copy) NSString *accessKeyId;

@property (nonatomic ,copy) NSString *accessKeySecret;

@property (nonatomic ,copy) NSString *securityToken;

@end

NS_ASSUME_NONNULL_END
