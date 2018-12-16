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

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect bigRect = screenRect;
//    bigRect.size.height *= 2;
    bigRect.size.width *= 2;

//    BNRHypnosisView *hypnosisView = [[BNRHypnosisView alloc] initWithFrame:bigRect];
    BNRHypnosisView *hypnosisView = [[BNRHypnosisView alloc] initWithFrame:screenRect];

    [scrollView addSubview:hypnosisView];

    screenRect.origin.x += screenRect.size.width;
    BNRHypnosisView *anotherView = [[BNRHypnosisView alloc] initWithFrame:screenRect];
    [scrollView addSubview:anotherView];

    scrollView.contentSize = bigRect.size;

    [scrollView setPagingEnabled:YES];
}

@end
