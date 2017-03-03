//
//  ViewController.m
//  RunView
//
//  Created by MacOS on 2017/3/3.
//  Copyright © 2017年 LiuMingHui. All rights reserved.
//

#import "ViewController.h"
#import "RunView.h"

#define BundleSource(name,type) [[NSBundle mainBundle] pathForResource:name ofType:type]

@interface ViewController ()<RunViewDelegate>
@property (weak, nonatomic) IBOutlet RunView *runView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.runView.delegate = self;
    
    NSArray * images = @[[NSURL fileURLWithPath:BundleSource(@"p1", @"jpg")],
                         [NSURL fileURLWithPath:BundleSource(@"p2", @"jpg")],
                         [NSURL fileURLWithPath:BundleSource(@"p3", @"jpg")],
                         ];
    self.runView.imageUrlArray = images;
    self.runView.autoScrollTime = 4;
    [self.runView startAutoScroll];
    
}


- (void)TapCycleScrollViewWithImageIndex:(NSInteger)index{

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
