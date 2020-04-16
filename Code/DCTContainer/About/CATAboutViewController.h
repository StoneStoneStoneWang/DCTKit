//
//  CATAboutViewController.h
//  CATContainer
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
//


#import "CATConfig.h"
@import CATBridge;
@import CATTable;
NS_ASSUME_NONNULL_BEGIN

@interface CATAboutTableHeaderView : CATTableHeaderView

@end

@interface CATAboutTableViewCell : CATBaseTableViewCell

@property (nonatomic ,strong) CATAboutBean *about;

@end

@interface CATAboutViewController : CATTableNoLoadingViewController

+ (instancetype)createAbout;

@end

NS_ASSUME_NONNULL_END
