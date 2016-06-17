//
// Created by Uros Milivojevic on 8/27/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRBaseDescriptor.h"

@class IRSideMenuDescriptor;
@class IRNavigationControllerSubDescriptor;
@class IRKeyboardManagerSubDescriptor;
@class IRTabBarControllerSubDescriptor;


@interface IRViewControllerDescriptor : IRBaseDescriptor

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *nativeController;
@property (nonatomic, strong) NSString *controller;
#if TARGET_OS_IPHONE
@property (nonatomic) UIStatusBarStyle preferredStatusBarStyle;
#endif
@property (nonatomic) BOOL prefersStatusBarHidden;
#if TARGET_OS_IPHONE
@property (nonatomic, strong) NSArray *supportedInterfaceOrientationsArray;
#endif
@property (nonatomic, strong) IRSideMenuDescriptor *sideMenu;
@property (nonatomic, strong) IRTabBarControllerSubDescriptor *tabBarController;
@property (nonatomic, strong) IRNavigationControllerSubDescriptor *navigationController;
@property (nonatomic, strong) IRKeyboardManagerSubDescriptor *keyboardManager;
@property (nonatomic) BOOL requestWhenInUseAuthorization;
@property (nonatomic) BOOL requestAlwaysAuthorization;

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
                 appDescriptor:(IRAppDescriptor *)appDescriptor;

@end