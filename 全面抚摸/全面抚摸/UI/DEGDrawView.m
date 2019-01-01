//
// Created by Du Carl on 2018-12-30.
// Copyright (c) 2018 杜... All rights reserved.
//

#import "DEGDrawView.h"
#import "DEGLine.h"

@interface DEGDrawView() <UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSMutableDictionary *linesInProgress;
@property (nonatomic, strong) NSMutableArray *finishedLines;
@property (nonatomic, weak) DEGLine *selectedLine;
@property (nonatomic, strong) UIPanGestureRecognizer *moveRecognizer;
@property(nonatomic) CGFloat velocity;
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

        UILongPressGestureRecognizer *pressRecognizer = [[UILongPressGestureRecognizer alloc]
                initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:pressRecognizer];

        self.moveRecognizer = [[UIPanGestureRecognizer alloc]
                initWithTarget:self action:@selector(moveLine:)];
        self.moveRecognizer.delegate = self;
        self.moveRecognizer.cancelsTouchesInView = NO;
        [self addGestureRecognizer:self.moveRecognizer];
    }

    return self;
}

- (void)moveLine:(UIPanGestureRecognizer *)gr {
    CGPoint vXY = [gr velocityInView:self];
    CGFloat v = hypot(vXY.x, vXY.y);
    NSLog(@"速度是：%f", v);
    self.velocity = v;

    if (!self.selectedLine) {
        return;
    }
    if (gr.state == UIGestureRecognizerStateBegan) {
        CGPoint p = [gr locationInView:self];
        self.selectedLine = [self lineAtPoint:p];
        return;
    }
    if (gr.state == UIGestureRecognizerStateChanged) {
        CGPoint move = [gr translationInView:self];
        CGPoint begin = self.selectedLine.begin;
        CGPoint end = self.selectedLine.end;

        begin.x += move.x;
        end.x += move.x;
        begin.y += move.y;
        end.y += move.y;

        self.selectedLine.begin = begin;
        self.selectedLine.end = end;

        [self setNeedsDisplay];

        [gr setTranslation:CGPointZero inView:self];
        return;
    }
    if (gr.state == UIGestureRecognizerStateEnded) {
        self.selectedLine = nil;
        return;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer == self.moveRecognizer) {
        return YES;
    }

    return NO;
}

- (void)longPress:(UIGestureRecognizer *)gr {
    if (gr.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [gr locationInView:self];
        self.selectedLine = [self lineAtPoint:point];
        if (self.selectedLine) {
            [self.linesInProgress removeAllObjects];
        } else if (gr.state == UIGestureRecognizerStateEnded) {
            self.selectedLine = nil;
        }
    }

    [self setNeedsDisplay];
}

- (void)tap:(UIGestureRecognizer *)gr {
    NSLog(@"Recognized tap");
    CGPoint point = [gr locationInView:self];
    self.selectedLine = [self lineAtPoint:point];

    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (self.selectedLine) {
        [self becomeFirstResponder];
        // 创建一个新的标题为“Delete”的UIMenuItem对象
        UIMenuItem *delete = [[UIMenuItem alloc]
                initWithTitle:@"删除" action:@selector(deleteLine:)];
        menu.menuItems = @[delete];
        [menu setTargetRect:CGRectMake(point.x, point.y, 2, 2) inView:self];
        [menu setMenuVisible:YES animated:YES];
    } else {
        [menu setMenuVisible:NO animated:YES];
    }

    [self setNeedsDisplay];
}

- (void)deleteLine:(id)sender {
    [self.finishedLines removeObject:self.selectedLine];
    [self setNeedsDisplay];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)doubleTap:(UIGestureRecognizer *)gestureRecognizer {
    [self.linesInProgress removeAllObjects];
    [self.finishedLines removeAllObjects];
    [self setNeedsDisplay];
}

-(void)strokeLine:(DEGLine *)line {
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineWidth = 1.0/(self.velocity+1.0) * 500;
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
    self.selectedLine = nil;
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuVisible:NO animated:YES];
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