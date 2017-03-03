//
//  RunView.m
//  RunView
//
//  Created by MacOS on 2017/3/3.
//  Copyright © 2017年 LiuMingHui. All rights reserved.

#import "RunView.h"
#import "NSTimer+Additions.h"
#import "UIImageView+WebCache.h"
@interface RunView()<UIScrollViewDelegate>

@property (nonatomic,strong) UIImageView *curImageView;
@property (nonatomic,strong) UIImageView *prevImageView;
@property (nonatomic,strong) UIImageView *nextImageView;

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSTimer *scrollTimer;

@end

@implementation RunView{
    NSInteger curIndex;
}
- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self initSubViews];
}

- (void)dealloc{
    if (_scrollTimer) {
        [_scrollTimer invalidate];
        _scrollTimer = nil;
    }
}

- (void)initSubViews{
    float width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(self.bounds.size.width*self.imageUrlArray.count, height);
    [self addSubview:_scrollView];
    _scrollView.bounces = YES;
    _scrollView.showsVerticalScrollIndicator = _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    
    _prevImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    _curImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width, 0, width, height)];
    _nextImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width*2, 0, width, height)];
    _prevImageView.clipsToBounds = _curImageView.clipsToBounds = _nextImageView.clipsToBounds = YES;
    
    [_scrollView addSubview:_prevImageView];
    [_scrollView addSubview:_curImageView];
    [_scrollView addSubview:_nextImageView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCycleView:)];
    [self addGestureRecognizer:tapGesture];
}

- (void)layoutSubviews{
    float width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    _scrollView.contentSize = CGSizeMake(width*(self.imageUrlArray.count>1?(self.imageUrlArray.count+1):1), height);
    _scrollView.frame = self.bounds;

    _prevImageView.frame = CGRectMake(0, 0, width, height);
    _curImageView.frame = CGRectMake(width, 0, width, height);
    _nextImageView.frame = CGRectMake(width*2, 0, width, height);
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
}

- (void)reloadData{
    [self.scrollTimer pause];
    
    [self layoutSubviews];
    [self reloadImageData];
    
    [self.scrollTimer continueNow];
}

- (void)startAutoScroll{
    if (_scrollTimer) {
        [self.scrollTimer continueWithDalay:2];
    }else{
        _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTime target:self selector:@selector(autoScroll:) userInfo:nil repeats:YES];
    }
}

- (void)pauseAutoScroll{
    [self.scrollTimer pause];
}

- (void)continueAutoScroll{
    [self.scrollTimer continueNow];
}

- (void)setImageUrlArray:(NSArray *)imageUrlArray{
    _imageUrlArray = imageUrlArray;
    [self reloadData];
}

- (void)autoScroll:(id)sender{
    [_scrollView setContentOffset:CGPointMake(self.bounds.size.width*(self.imageUrlArray.count - 1), 0) animated:YES];
}

- (void)tapCycleView:(UITapGestureRecognizer*)tapHesture{
    if (self.delegate) {
        [_delegate TapCycleScrollViewWithImageIndex:curIndex];
    }
}

- (NSInteger)showImageIndex{
    return curIndex;
}
#pragma mark - scrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.scrollTimer pause];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.scrollTimer continueWithDalay:self.autoScrollTime];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollView.contentOffset.x <= 0) {
        //prev image
        --curIndex;
        if(curIndex<0){
            curIndex = self.imageUrlArray.count-1;
        }
        [self reloadImageData];
        self.scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
    }else if (self.scrollView.contentOffset.x >= self.bounds.size.width*2){
        //next
        ++curIndex;
        if (curIndex+1>self.imageUrlArray.count) {
            curIndex = 0;
        }
        [self reloadImageData];
        self.scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
    }
}

- (void)reloadImageData{
    NSUInteger imageCount = self.imageUrlArray.count;
    [_prevImageView sd_setImageWithURL:[self.imageUrlArray objectAtIndex:curIndex>0?curIndex-1:imageCount-1] placeholderImage:[UIImage imageNamed:@"p1.jpg"] options:kNilOptions];
    [_curImageView sd_setImageWithURL:self.imageUrlArray[curIndex] placeholderImage:[UIImage imageNamed:@"p1.jpg"] options:kNilOptions];
    [_nextImageView sd_setImageWithURL:[self.imageUrlArray objectAtIndex:(curIndex+1<imageCount)?curIndex+1:0] placeholderImage:[UIImage imageNamed:@"p1.jpg"] options:kNilOptions];
}
@end
