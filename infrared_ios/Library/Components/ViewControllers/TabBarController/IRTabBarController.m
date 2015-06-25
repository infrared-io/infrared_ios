//
// Created by Uros Milivojevic on 6/25/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRTabBarController.h"
#import "IRNavigationController.h"


@implementation IRTabBarController

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Orientation handling

-(NSUInteger)supportedInterfaceOrientations
{
    IRViewController *viewController = (IRViewController *) self.selectedViewController;
    if ([viewController isKindOfClass:[IRNavigationController class]]) {
        viewController = [((IRNavigationController *)viewController).viewControllers lastObject];
    }
    return [viewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    IRViewController *viewController = (IRViewController *) self.selectedViewController;
    if ([viewController isKindOfClass:[IRNavigationController class]]) {
        viewController = [((IRNavigationController *)viewController).viewControllers lastObject];
    }
    return [viewController preferredInterfaceOrientationForPresentation];
}

-(BOOL)shouldAutorotate
{
    IRViewController *viewController = (IRViewController *) self.selectedViewController;
    if ([viewController isKindOfClass:[IRNavigationController class]]) {
        viewController = [((IRNavigationController *)viewController).viewControllers lastObject];
    }
    return [viewController shouldAutorotate];
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Status-bar methods

- (BOOL)prefersStatusBarHidden {
    IRViewController *viewController = (IRViewController *) self.selectedViewController;
    if ([viewController isKindOfClass:[IRNavigationController class]]) {
        viewController = [((IRNavigationController *)viewController).viewControllers lastObject];
    }
    return [viewController prefersStatusBarHidden]; // set to "NO" to show status-bar in landscape mode
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    IRViewController *viewController = (IRViewController *) self.selectedViewController;
    if ([viewController isKindOfClass:[IRNavigationController class]]) {
        viewController = [((IRNavigationController *)viewController).viewControllers lastObject];
    }
    return [viewController preferredStatusBarStyle];
}
@end