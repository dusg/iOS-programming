//
// Created by Du Carl on 2018-12-30.
// Copyright (c) 2018 杜... All rights reserved.
//

#import "DEGDrawView.h"
#import "DEGLine.h"

@interface DEGDrawView()
@property (nonatomic, strong) NSMutableDictionary *linesInProgress;
@property (nonatomic, strong) NSMutableArray *finishedLines;
@property (nonatomic, weak) DEGLine *selectedLine;
@end

@implementation DEGDrawView {

}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.finishedLines = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;

        UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]
                initWithTarget:self action:@selector(doubleTap:)];
        doubleTapGesture.numberOfTapsRequired = 2;
        doubleTapGesture.delaysTouchesBegan = YES;
        [self addGestureRecognizer:doubleTapGesture];

        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                initWithTarget:self action:@selector(tap:)];
        tapGestureRecognizer.delaysTouchesBegan = YES;
        [tapGestureRecognizer requireGestureRecognizerToFail:doubleTapGesture];
        [self addGestureRecognizer:tapGestureRecognizer];
    }

    return self;
}

- (void)tap:(UIGestureRecognizer *)gr {
    NSLog(@"Recognized tap");
    CGPoint point = [gr locationInView:self];
    self.selectedLine = [self lineAtPoint:point];

    [self setNeedsDisplay];
}

- (void)doubleTap:(UIGestureRecognizer *)gestureRecognizer {
    [self.linesInProgress removeAllObjects];
    [self.finishedLines removeAllObjects];
    [self setNeedsDisplay];
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
    for (DEGLine *line in self.finishedLines) {
        [[UIColor blackColor] set];
        [self strokeLine:line];
    }

    for (NSValue *key in self.linesInProgress) {
        [[UIColor redColor] set];
        [self strokeLine:self.linesInProgress[key]];
    }

    if (self.selectedLine) {
        [[UIColor greenColor] set];
        [self strokeLine:self.selectedLine];
    }
}

- (DEGLine *)lineAtPoint:(CGPoint)point {
    for (DEGLine *line in self.finishedLines) {
        CGPoint start = line.begin;
        CGPoint end = line.end;

        for (CGFloat i = 0.0; i < 1.0; i += 0.05) {
            CGFloat x = start.x + i * (end.x - start.x);
            CGFloat y = start.y + i * (end.y - start.y);
            if (hypot(x - point.x, y - point.y) < 20.0) {
                return line;
            }
        }
    }

    return nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint point = [touch locationInView:self];
        DEGLine *line = [[DEGLine alloc] init];
        line.begin = point;
        line.end = point;
        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        self.linesInProgress[key] = line;
    }

    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    for (UITouch *touch in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        DEGLine *line = self.linesInProgress[key];
        line.end = [touch locationInView:self];
    }
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    for (UITouch *touch in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        DEGLine *line = self.linesInProgress[key];

        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectForKey:key];
    }

    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    for (UITouch *touch in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        [self.linesInProgress removeObjectForKey:key];
    }

    [self setNeedsDisplay];
}

@end