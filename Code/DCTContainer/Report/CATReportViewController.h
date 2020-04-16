//
//  CATReportViewController.h
//  CATContainer
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "CATConfig.h"
#if CATCONFIGURETYPECIRCLE

@import CATTable;
@import CATBridge;
NS_ASSUME_NONNULL_BEGIN

@interface CATReportTableViewCell : CATBaseTableViewCell

@property (nonatomic ,strong) CATReportBean * reportBean;

@end

typedef void(^CATReportBlock)(CATBaseViewController *from);
@interface CATReportViewController : CATTableNoLoadingViewController

+ (instancetype)createReportWithUid:(NSString *)uid andEncode:(NSString *)encode andBlock:(CATReportBlock) block;

@end


NS_ASSUME_NONNULL_END
#endif
