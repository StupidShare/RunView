//
//  NSTimer+Additions.m
//  RunView
//
//  Created by MacOS on 2017/3/3.
//  Copyright © 2017年 LiuMingHui. All rights reserved.

#import "NSTimer+Additions.h"

@implementation NSTimer (Additions)

- (void)pause{
    [self setFireDate:[NSDate distantFuture]];
}

- (void)continueWithDalay:(NSTimeInterval)delay{
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:delay]];
}

- (void)continueNow{
    [self setFireDate:[NSDate distantPast]];
}

@end
