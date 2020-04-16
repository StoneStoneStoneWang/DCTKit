//
//  CATAreaViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//

@import CATTable;
@import CATBridge;
#import "CATConfig.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^CATAreaBlock)(CATBaseViewController *from ,CATAreaBean *selectedArea ,CATAreaType type ,BOOL hasNext);

@interface CATAreaViewController : CATTableNoLoadingViewController

+ (instancetype)createAreaWithType:(CATAreaType )type andAreaBlock:(CATAreaBlock) block;

- (void)selectedArea:(NSInteger )sid andBlock:(CATAreaBlock)block;

- (void)updateAreas:(NSInteger )sid ;

- (CATAreaBean *)fetchAreaWithId:(NSInteger)sid ;
@end

NS_ASSUME_NONNULL_END
