//
//  DCTCommentViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <DCTTable/DCTTable.h>
@import DCTBean;
#import "DCTConfig.h"
NS_ASSUME_NONNULL_BEGIN

@class DCTCommentViewController;

typedef NS_ENUM(NSInteger ,DCTCommentActionType) {
    
    DCTCommentActionTypeUnLogin,
    
    DCTCommentActionTypeComment,
    
    DCTCommentActionTypeReport
    
};

typedef void(^DCTCommentBlock)(DCTCommentViewController *from ,DCTCommentActionType type ,DCTCircleBean *circleBean);

@protocol DCTCommentTableViewCellDelegate <NSObject>

- (void)onMoreItemClick:(DCTCommentBean *)comment;

@end

@interface DCTCommentTableViewCell : DCTBaseTableViewCell

@property (nonatomic ,strong) DCTCommentBean *comment;

@property (nonatomic ,weak) id <DCTCommentTableViewCellDelegate>mDelegate;

@end

@interface DCTCommentTotalTableViewCell : DCTCommentTableViewCell


@end

@interface DCTCommentRectangleTableViewCell : DCTCommentTableViewCell

@end

@interface DCTCommentNoMoreTableViewCell : DCTCommentTableViewCell

@end

@interface DCTCommentFailedTableViewCell : DCTCommentTableViewCell

@end

@interface DCTCommentEmptyTableViewCell : DCTCommentTableViewCell

@end

@interface DCTCommentContentTableViewCell : DCTCommentTableViewCell


@end

@interface DCTCommentViewController : DCTTableLoadingViewController

+ (instancetype)createCommentWithEncode:(NSString *)encode andCircleBean:(DCTCircleBean *)circleBean andOp:(DCTCommentBlock) block;

@property (nonatomic ,strong ,readonly) UIView *bottomBar;

@end

NS_ASSUME_NONNULL_END
