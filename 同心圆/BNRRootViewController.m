//
//  BNRRootViewController.m
//  同心圆
//
//  Created by Du Carl on 2018/12/15.
//  Copyright © 2018 desg. All rights reserved.
//

#import "BNRRootViewController.h"
#import "BNRHypnosisView.h"

@implementation BNRRootViewController
- (void)loadView {
    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] init];
//    backgroundView.backgroundColor = [UIColor whiteColor];

//    CGRect firstFrame = CGRectMake(375.0/2, 240, 100, 150);
//    CGRect firstFrame = self.
//    BNRHypnosisView *firstView = [[BNRHypnosisView alloc] initWithFrame:firstFrame];
//    firstView.backgroundColor = [UIColor redColor];

//    [backgroundView addSubview:firstView];

//    CGRect secondFrame = CGRectMake(20, 30, 50, 50);
//    BNRHypnosisView *secondView = [[BNRHypnosisView alloc] initWithFrame:secondFrame];
//    secondView.backgroundColor = [UIColor blueColor];
//    [backgroundView addSubview:secondView];
//    [firstView addSubview:secondView];

    self.view = backgroundView;
}

@end
