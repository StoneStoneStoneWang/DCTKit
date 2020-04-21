//
//  DCTWelcomeViewController.h
//  DCTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

@import DCTCollection;
#import "DCTConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface DCTWelcomeCollectionViewCell : UICollectionViewCell

@property (nonatomic ,copy) NSString *icon;

@end

typedef void(^DCTWelcomeBlock)(DCTBaseViewController *from);

@interface DCTWelcomeViewController : DCTCollectionNoLoadingViewController

+ (instancetype)createWelcomeWithSkipBlock:(DCTWelcomeBlock )block;

@end

NS_ASSUME_NONNULL_END
