//
// Created by Uros Milivojevic on 12/16/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRNavigationController.h"
#import "IRDataController.h"


@implementation IRNavigationController

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Orientation handling

-(NSUInteger)supportedInterfaceOrientations
{
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

-(BOOL)shouldAutorotate
{
    return [[self.viewControllers lastObject] shouldAutorotate];
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Status-bar methods

- (BOOL)prefersStatusBarHidden {
    return [[self.viewControllers lastObject] prefersStatusBarHidden]; // set to "NO" to show status-bar in landscape mode
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return [[self.viewControllers lastObject] preferredStatusBarStyle];
}

@end