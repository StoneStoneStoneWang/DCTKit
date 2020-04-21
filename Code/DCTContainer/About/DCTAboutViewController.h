//
//  DCTAboutViewController.h
//  DCTContainer
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
//


#import "DCTConfig.h"
@import DCTBridge;
@import DCTTable;
NS_ASSUME_NONNULL_BEGIN

@interface DCTAboutTableHeaderView : DCTTableHeaderView

@end

@interface DCTAboutTableViewCell : DCTBaseTableViewCell

@property (nonatomic ,strong) DCTAboutBean *about;

@end

@interface DCTAboutViewController : DCTTableNoLoadingViewController

+ (instancetype)createAbout;

@end

NS_ASSUME_NONNULL_END
