//
// Created by Uros Milivojevic on 6/25/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRViewController.h"
#import "UITabBarControllerExport.h"

@protocol IRTabBarControllerExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRTabBarController : UITabBarController <IRComponentInfoProtocol, UITabBarControllerExport, IRTabBarControllerExport, UIViewControllerExport, IRViewControllerExport>

@end