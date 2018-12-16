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
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.view = scrollView;

    CGRect bigRect = [[UIScreen mainScreen] bounds];
    bigRect.size.height *= 2;
    bigRect.size.width *= 2;

    BNRHypnosisView *hypnosisView = [[BNRHypnosisView alloc] initWithFrame:bigRect];

    [scrollView addSubview:hypnosisView];
    scrollView.contentSize = bigRect.size;
}

@end
