//
//  DCTBaseTableViewCell.h
//  ZTable
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger ,DCTBottomLineType) {
    
    DCTBottomLineTypeNormal NS_SWIFT_NAME(normal),
    
    DCTBottomLineTypeNone NS_SWIFT_NAME(none) ,
    
    DCTBottomLineTypeCustom NS_SWIFT_NAME(custom)
};

@interface DCTBaseTableViewCell : UITableViewCell

@property (nonatomic ,strong ,readonly) UIImageView *bottomView;

@property (nonatomic ,assign) DCTBottomLineType bottomLineType;

- (void)commitInit;
@end

NS_ASSUME_NONNULL_END
