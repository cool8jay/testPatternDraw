#import "MyView.h"

@implementation MyView

void HPSDebugPattern(void *info, CGContextRef context) {
    NSDictionary *dict = (__bridge NSDictionary *)info;
    
    CGFloat size = [dict[@"size"] floatValue];
    CGRect rect = {
        0, 0, size, size
    };
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, NSColor.redColor.CGColor);
    CGContextFillRect(context, rect);
    CGContextRestoreGState(context);
}

- (void)drawRect:(NSRect)dirtyRect {
    CGContextRef context = [NSGraphicsContext currentContext].CGContext;
    
    CGContextSaveGState(context);
    CGColorSpaceRef patternSpace = CGColorSpaceCreatePattern(NULL);
    CGContextSetFillColorSpace(context, patternSpace);
    CGColorSpaceRelease(patternSpace);
    
    NSDictionary *info = @{
        @"size": @(self.size)
    };
    
    CGPatternDrawPatternCallback callbackFunc = HPSDebugPattern;
    CGPatternCallbacks callbacks = {
        0, callbackFunc, NULL
    };
    
    CGRect cellRect = {
        0, 0, self.size, self.size
    };
    
    CGPatternRef pattern = CGPatternCreate((__bridge_retained void *)info,
                                           cellRect,
                                           CGAffineTransformIdentity,
                                           self.size,
                                           self.size,
                                           kCGPatternTilingConstantSpacing,
                                           true,
                                           &callbacks);
    
    CGFloat alpha = 1;
    CGContextSetFillPattern(context, pattern, &alpha);
    CGPatternRelease(pattern);
    CGContextFillRect(context, self.bounds);
    CGContextRestoreGState(context);
}

- (void)setSize:(CGFloat)size {
    _size = size;
    self.needsDisplay = YES;
}

@end
