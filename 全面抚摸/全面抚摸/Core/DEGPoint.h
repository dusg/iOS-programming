#import <CoreGraphics/CoreGraphics.h>
#import "Foundation/Foundation.h"

@interface DEGPoint : NSObject
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;

@property (nonatomic) CGPoint point;
- (instancetype)initWithPoint:(CGPoint)point;

+ (instancetype)pointWithPoint:(CGPoint)point;

@end
