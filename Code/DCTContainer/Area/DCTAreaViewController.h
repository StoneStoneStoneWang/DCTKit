//
//  DCTAreaViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//

@import DCTTable;
@import DCTBridge;
#import "DCTConfig.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^DCTAreaBlock)(DCTBaseViewController *from ,DCTAreaBean *selectedArea ,DCTAreaType type ,BOOL hasNext);

@interface DCTAreaViewController : DCTTableNoLoadingViewController

+ (instancetype)createAreaWithType:(DCTAreaType )type andAreaBlock:(DCTAreaBlock) block;

- (void)selectedArea:(NSInteger )sid andBlock:(DCTAreaBlock)block;

- (void)updateAreas:(NSInteger )sid ;

- (DCTAreaBean *)fetchAreaWithId:(NSInteger)sid ;
@end

NS_ASSUME_NONNULL_END
