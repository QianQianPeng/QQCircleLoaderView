//
//  AppDelegate.h
//  QQCircleLoaderView
//
//  Created by 刘朋坤 on 2018/12/27.
//  Copyright © 2018 彭倩倩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

