//
//  DCTUserInfoViewController.h
//  DCTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "DCTConfig.h"
@import DCTBridge;
@import DCTTable;

NS_ASSUME_NONNULL_BEGIN

@interface DCTUserInfoTableViewCell : DCTBaseTableViewCell

@property (nonatomic ,strong) DCTUserInfoBean *userInfo;

@end

typedef NS_ENUM(NSInteger, DCTUserInfoActionType) {
    DCTUserInfoActionTypeName,
    DCTUserInfoActionTypeSignature,
};

typedef void(^DCTUserInfoBlock)(DCTUserInfoActionType actionType ,DCTBaseViewController *from);

@interface DCTUserInfoViewController : DCTTableNoLoadingViewController

+ (instancetype)createUserInfoWithBlock:(DCTUserInfoBlock )block;

- (void)updateName:(NSString *)name;

- (void)updateSignature:(NSString *)signature;

@end

NS_ASSUME_NONNULL_END
