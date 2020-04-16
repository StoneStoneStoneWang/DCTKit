//
//  DCTTextInnerViewController.h
//  ZTextInner
//
//  Created by three stone 王 on 2020/3/26.
//  Copyright © 2020 three stone 王. All rights reserved.
//

@import DCTLoading;

NS_ASSUME_NONNULL_BEGIN

@interface DCTTextInnerViewController : DCTLoadingViewController

- (void)DCTLoadHtmlString:(NSString *)htmlString NS_SWIFT_NAME(DCTLoadHtmlString(htmlString:));

@property (nonatomic ,strong ,readonly) UITextView *textView;

@end

NS_ASSUME_NONNULL_END
