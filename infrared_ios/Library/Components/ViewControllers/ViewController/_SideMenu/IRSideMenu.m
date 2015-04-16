//
// Created by Uros Milivojevic on 1/8/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRSideMenu.h"
#import "IRViewController.h"


@implementation IRSideMenu

#pragma mark - Orientation handling

-(NSUInteger)supportedInterfaceOrientations
{
    UIInterfaceOrientationMask supportedInterfaceOrientations = 0;
    IRViewController *viewController = nil;
    if ([self.contentViewController isKindOfClass:[UINavigationController class]]) {
        viewController = (IRViewController *) ((UINavigationController *)self.contentViewController).visibleViewController;
    } else {
        viewController = (IRViewController *) self.contentViewController;
    }
    supportedInterfaceOrientations = [viewController supportedInterfaceOrientations];
    return supportedInterfaceOrientations;
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    UIInterfaceOrientation preferredInterfaceOrientation = 0;
    IRViewController *viewController = nil;
    if ([self.contentViewController isKindOfClass:[UINavigationController class]]) {
        viewController = (IRViewController *) ((UINavigationController *)self.contentViewController).visibleViewController;
    } else {
        viewController = (IRViewController *) self.contentViewController;
    }
    preferredInterfaceOrientation = [viewController preferredInterfaceOrientationForPresentation];
    return preferredInterfaceOrientation;
}
-(BOOL)shouldAutorotate
{
    return YES;
}

@end