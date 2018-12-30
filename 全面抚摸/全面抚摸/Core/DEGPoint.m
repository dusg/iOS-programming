//
// Created by Du Carl on 2018-12-30.
// Copyright (c) 2018 杜... All rights reserved.
//

#import "DEGPoint.h"

@interface DEGPoint()
@end

@implementation DEGPoint
- (instancetype)initWithPoint:(CGPoint)point {
    self = [super init];
    if (self) {
        self.point = point;
    }

    return self;
}

+ (instancetype)pointWithPoint:(CGPoint)point {
    return [[self alloc] initWithPoint:point];
}

- (CGFloat)x {
    return self.point.x;
}

- (CGFloat)y {
    return self.point.y;
}


@end