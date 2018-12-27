//
//  QQCircleLoaderView.m
//  QQCircleLoaderView
//
//  Created by 彭倩倩 on 2018/12/27.
//  Copyright © 2018 彭倩倩. All rights reserved.
//

#import "QQCircleLoaderView.h"

@implementation QQCircleLoaderView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = self.frame.size.height/2.0;
        self.layer.masksToBounds = YES;
        [self creatChildViews];
    }
    return self;
}

- (void)creatChildViews {
    self.circleProgressLayer = [QQCircleProgressLayer layer];
    self.circleProgressLayer.frame = CGRectMake(6, 6, self.frame.size.width-12, self.frame.size.height-12);
    
    // 像素大小比例
    self.circleProgressLayer.contentsScale = [UIScreen mainScreen].scale;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-27)/2.0, (self.frame.size.width-32)/2.0, 27, 32)];
    self.imageView = imageView;
    imageView.image = [UIImage imageNamed:@"image"];
    [self addSubview:imageView];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.frame.size.width-30)/2.0, self.frame.size.width, 30)];
    self.textLabel = textLabel;
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.text = @"+1";
    textLabel.font = [UIFont boldSystemFontOfSize:18];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.hidden = YES;
    [self addSubview:textLabel];
    [self.layer addSublayer:self.circleProgressLayer];
}

/** 缩放动画 */
- (void)addAnimationWithCALayer:(CALayer *)layer interval:(CFTimeInterval)interval repeatCount:(NSInteger)repeatCount fromValue:(CGFloat)fromValue toValue:(CGFloat)toValue {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:fromValue];
    scaleAnimation.toValue = [NSNumber numberWithFloat:toValue];
    scaleAnimation.duration = interval;
    scaleAnimation.repeatCount = repeatCount;
    scaleAnimation.autoreverses = YES;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [layer addAnimation:scaleAnimation forKey:nil];
}

/** 进度 */
- (void)setProgress:(CGFloat)progress {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"progress"];
    ani.duration = progress;
    ani.toValue = @(1);
    ani.removedOnCompletion = YES;
    ani.fillMode = kCAFillModeForwards;
    [self.circleProgressLayer addAnimation:ani forKey:@"progressAni"];
    _progress = progress;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(progress * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.1 animations:^{
            self.imageView.hidden = YES;
            self.backgroundColor = [UIColor redColor];
            self.textLabel.hidden = NO;
        }];
        [self addAnimationWithCALayer:self.layer interval:0.12 repeatCount:2 fromValue:0.95 toValue:1.05];
    });
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.circleProgressLayer.progress = self.progress;
}

@end


@implementation QQCircleProgressLayer

- (void)drawInContext:(CGContextRef)ctx {
    CGFloat radius = self.bounds.size.width / 2;
    CGFloat lineWidth = 4.0;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius - lineWidth / 2 startAngle:0.f endAngle:M_PI * 2 * self.progress clockwise:YES];
    // 颜色
    CGContextSetRGBStrokeColor(ctx, 253/255.0, 117/255.0, 17/255.0, 1);
    // 线条宽度
    CGContextSetLineWidth(ctx, 4.0);
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
}

- (instancetype)initWithLayer:(QQCircleProgressLayer *)layer {
    if (self = [super initWithLayer:layer]) {
        self.progress = layer.progress;
    }
    return self;
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"progress"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

@end
