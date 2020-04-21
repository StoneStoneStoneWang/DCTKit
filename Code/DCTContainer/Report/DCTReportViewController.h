//
//  DCTReportViewController.h
//  DCTContainer
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "DCTConfig.h"
#if DCTCONFIGURETYPECIRCLE

@import DCTTable;
@import DCTBridge;
NS_ASSUME_NONNULL_BEGIN

@interface DCTReportTableViewCell : DCTBaseTableViewCell

@property (nonatomic ,strong) DCTReportBean * reportBean;

@end

typedef void(^DCTReportBlock)(DCTBaseViewController *from);
@interface DCTReportViewController : DCTTableNoLoadingViewController

+ (instancetype)createReportWithUid:(NSString *)uid andEncode:(NSString *)encode andBlock:(DCTReportBlock) block;

@end


NS_ASSUME_NONNULL_END
#endif
