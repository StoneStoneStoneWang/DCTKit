//
//  CATUserInfoViewController.h
//  CATContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "CATConfig.h"
@import CATBridge;
@import CATTable;

NS_ASSUME_NONNULL_BEGIN

@interface CATUserInfoTableViewCell : CATBaseTableViewCell

@property (nonatomic ,strong) CATUserInfoBean *userInfo;

@end

typedef NS_ENUM(NSInteger, CATUserInfoActionType) {
    CATUserInfoActionTypeName,
    CATUserInfoActionTypeSignature,
};

typedef void(^CATUserInfoBlock)(CATUserInfoActionType actionType ,CATBaseViewController *from);

@interface CATUserInfoViewController : CATTableNoLoadingViewController

+ (instancetype)createUserInfoWithBlock:(CATUserInfoBlock )block;

- (void)updateName:(NSString *)name;

- (void)updateSignature:(NSString *)signature;

@end

NS_ASSUME_NONNULL_END
