//
//  QQCircleLoaderView.h
//  QQCircleLoaderView
//
//  Created by 彭倩倩 on 2018/12/27.
//  Copyright © 2018 彭倩倩. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QQCircleProgressLayer;

NS_ASSUME_NONNULL_BEGIN

@interface QQCircleLoaderView : UIView

/** 动画中间的图片 */
@property (nonatomic, strong) UIImageView *imageView;

/** 动画过后显示的文本 */
@property (nonatomic, strong) UILabel *textLabel;

/** 时间 */
@property (nonatomic, assign) CGFloat progress;

/** 进度条子视图 */
@property (nonatomic, strong) QQCircleProgressLayer *circleProgressLayer;

@end

NS_ASSUME_NONNULL_END


@interface QQCircleProgressLayer : CALayer

@property (nonatomic, assign) CGFloat progress;

@end
