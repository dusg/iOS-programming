//
// Created by Du Carl on 2018-12-30.
// Copyright (c) 2018 杜... All rights reserved.
//

#import "DEGDrawView.h"
#import "DEGLine.h"

@interface DEGDrawView()
@property (nonatomic, strong) DEGLine *currentLine;
@property (nonatomic, strong) NSMutableArray *finishedLines;
@end

@implementation DEGDrawView {

}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.finishedLines = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
    }

    return self;
}

-(void)strokeLine:(DEGLine *)line {
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineWidth = 10;
    bezierPath.lineCapStyle = kCGLineCapRound;
    [bezierPath moveToPoint:line.begin];
    [bezierPath addLineToPoint:line.end];
    [bezierPath stroke];
}

- (void)drawRect:(CGRect)rect {
    [[UIColor blackColor] set];
    for (DEGLine *line in self.finishedLines) {
        [self strokeLine:line];
    }

    if (self.currentLine) {
        [[UIColor redColor] set];
        [self strokeLine:self.currentLine];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    UITouch *touch = [touches anyObject];
    // 根据触摸位置创建BNRLine对象
    CGPoint point = [touch locationInView:self];
    self.currentLine = [[DEGLine alloc] init];
    self.currentLine.begin = point;
    self.currentLine.end = point;

    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    UITouch *touch = [touches anyObject];
    // 根据触摸位置创建BNRLine对象
    CGPoint point = [touch locationInView:self];
    self.currentLine.end = point;
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self.finishedLines addObject:self.currentLine];
    self.currentLine = nil;

    [self setNeedsDisplay];
}


@end