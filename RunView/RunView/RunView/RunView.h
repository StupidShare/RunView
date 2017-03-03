//
//  RunView.h
//  RunView
//
//  Created by MacOS on 2017/3/3.
//  Copyright © 2017年 LiuMingHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RunViewDelegate <NSObject>

@optional
- (void)TapCycleScrollViewWithImageIndex:(NSInteger)index;
@end

@interface RunView : UIView

@property (nonatomic,strong) NSArray<NSURL*> *imageUrlArray;
/** 停止时间 */
@property (nonatomic,assign) NSTimeInterval autoScrollTime;

@property (nonatomic,assign) id<RunViewDelegate> delegate;

@property (nonatomic,readonly) NSInteger showImageIndex;

- (void)startAutoScroll;
- (void)pauseAutoScroll;
- (void)continueAutoScroll;
@end
