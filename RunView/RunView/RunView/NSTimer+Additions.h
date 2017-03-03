//
//  NSTimer+Additions.h
//  RunView
//
//  Created by MacOS on 2017/3/3.
//  Copyright © 2017年 LiuMingHui. All rights reserved.

#import <Foundation/Foundation.h>

@interface NSTimer (Additions)

- (void)pause;

- (void)continueWithDalay:(NSTimeInterval)delay;
- (void)continueNow;


@end
