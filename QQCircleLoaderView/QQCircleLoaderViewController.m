//
//  QQCircleLoaderViewController.m
//  QQCircleLoaderView
//
//  Created by 彭倩倩 on 2018/12/27.
//  Copyright © 2018 彭倩倩. All rights reserved.
//

#import "QQCircleLoaderViewController.h"
#import "QQCircleLoaderView.h"

@interface QQCircleLoaderViewController ()

@end

@implementation QQCircleLoaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    QQCircleLoaderView *loaderView = [[QQCircleLoaderView alloc] initWithFrame:CGRectMake(100, 500, 80, 80)];
    loaderView.center = self.view.center;
    loaderView.progress = 3;
    [self.view addSubview:loaderView];
}

@end
