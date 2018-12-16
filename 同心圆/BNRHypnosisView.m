//
//  BNRHypnosisView.m
//  同心圆
//
//  Created by Du Carl on 2018/12/15.
//  Copyright © 2018 desg. All rights reserved.
//

#import "AppDelegate.h"
#import "BNRHypnosisView.h"

@implementation BNRHypnosisView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }

    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

    CGRect bounds = self.bounds;
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;

//    CGFloat radius = (MIN(bounds.size.width, bounds.size.height) / 2.0);
    CGFloat radius = hypot(bounds.size.width, bounds.size.height) / 2.0;

    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];

    for (CGFloat currentRadius = radius; currentRadius > 0 ; currentRadius -= 20) {
        [bezierPath moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        [bezierPath addArcWithCenter:center radius:currentRadius startAngle:0.0 endAngle:M_PI*2.0 clockwise:YES];
    }

    bezierPath.lineWidth = 10;

    [[UIColor lightGrayColor] setStroke];

    [bezierPath stroke];

    UIImage *logo = [UIImage imageNamed:@"hua.png"];

    CGContextRef cgContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(cgContext);
    CGContextSetShadow(cgContext, CGSizeMake(4, 7), 3);
    [logo drawInRect:CGRectMake(150, 300, logo.size.width, logo.size.height) blendMode:kCGBlendModeNormal alpha:0.9];
    CGContextRestoreGState(cgContext);
//    UIImage *logo = [UIImage imageNamed:@"017.ai"];
//    logo = [UIImage imageNamed:@"res/yellowMan.png"];
//    [logo drawInRect:bounds];
}

@end
