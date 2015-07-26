//
// Created by Uros Milivojevic on 12/16/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRViewController.h"
#import "UINavigationControllerExport.h"

@protocol IRNavigationControllerExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRNavigationController : UINavigationController <IRComponentInfoProtocol, UINavigationControllerExport, IRNavigationControllerExport, UIViewControllerExport, IRViewControllerExport>

@end