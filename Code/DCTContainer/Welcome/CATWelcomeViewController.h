//
//  CATWelcomeViewController.h
//  CATContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

@import CATCollection;
#import "CATConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface CATWelcomeCollectionViewCell : UICollectionViewCell

@property (nonatomic ,copy) NSString *icon;

@end

typedef void(^CATWelcomeBlock)(CATBaseViewController *from);

@interface CATWelcomeViewController : CATCollectionNoLoadingViewController

+ (instancetype)createWelcomeWithSkipBlock:(CATWelcomeBlock )block;

@end

NS_ASSUME_NONNULL_END
