//
// Created by Uros Milivojevic on 10/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <RESideMenu/RESideMenu.h>
#import "IRViewControllerBuilder.h"
#import "IRViewController.h"
#import "IRViewControllerDescriptor.h"
#import "IRScreenDescriptor.h"
#import "IRDataController.h"
#import "IRBaseBuilder+AutoLayout.h"
#import "IRView.h"
#import "IRBaseBuilder+DataBinding.h"
#import "IRSimpleCache.h"
#import "IRUtil.h"
#import "IRBaseBuilder+GestureRecognizer.h"
#import "IRNavigationController.h"
#import "IRNavigationControllerSubDescriptor.h"
#import "IRSideMenuDescriptor.h"
#import "IRSideMenu.h"
#import "IRFileLoadingUtil.h"
#import "IRViewDescriptor.h"
#import "IRUtilLibrary.h"
#import "IRTabBarController.h"
#import "IRTabBarControllerSubDescriptor.h"
#import "IRTabBarItemDescriptor.h"


@implementation IRViewControllerBuilder

+ (IRViewController *) buildAndWrapViewControllerFromScreenDescriptor:(IRScreenDescriptor *)descriptor
                                                                 data:(id)data
{
    // -- set data and ui
    IRViewController *irViewController = [IRViewControllerBuilder buildViewControllerFromScreenDescriptor:descriptor
                                                                                                     data:data];
    // -- wrap if needed
    irViewController = [IRViewControllerBuilder wrapInTabBarControllerAndNavigationControllerAndSideMenuIfNeeded:irViewController];
    return irViewController;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

+ (IRViewController *) buildViewControllerFromScreenDescriptor:(IRScreenDescriptor *)descriptor
                                                          data:(id)data
{
    IRViewController *irViewController = nil;

    IRViewControllerDescriptor *controllerDescriptor = descriptor.viewControllerDescriptor;
    if ([controllerDescriptor.useExistingClass length] > 0) {
        irViewController = (IRViewController *) [[NSClassFromString(controllerDescriptor.useExistingClass) alloc] init];
        if (irViewController == nil) {
            NSLog(@" ########## buildViewControllerFromScreenDescriptor:data: - ViewController with class name '%@' can NOT be created",
              controllerDescriptor.useExistingClass);
            irViewController = [[IRViewController alloc] init];
        }
    } else {
        irViewController = [[IRViewController alloc] init];
    }

    // Set init data
    irViewController.data = data;

    [IRViewControllerBuilder setUpComponent:irViewController fromDescriptor:descriptor];

    return irViewController;
}

+ (void) setUpComponent:(IRViewController *)irViewController
         fromDescriptor:(IRScreenDescriptor *)descriptor
{
    IRViewControllerDescriptor *irViewControllerDescriptor;
    JSContext *jsContext;

    irViewControllerDescriptor = descriptor.viewControllerDescriptor;

    [IRBaseBuilder setUpComponent:irViewController componentDescriptor:irViewControllerDescriptor viewController:nil
                            extra:nil];

    // Register namespace in JSContext
    jsContext = [IRDataController sharedInstance].globalJSContext;
    jsContext[irViewController.key] = irViewController;

    // VC jsPlugin
    [self extendVCWithJSPlugin:irViewController descriptor:irViewControllerDescriptor jsContext:jsContext];

    // VC title
    irViewController.title = [IRBaseBuilder textWithI18NCheck:irViewControllerDescriptor.title];

    // VC rootView
    irViewController.rootView = [IRBaseBuilder buildComponentFromDescriptor:(id) descriptor.rootViewDescriptor
                                                             viewController:irViewController extra:nil];
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

+ (IRViewController *) wrapInTabBarControllerAndNavigationControllerAndSideMenuIfNeeded:(IRViewController *)irViewController
{
    IRViewController *resultingViewController = irViewController;
    IRViewControllerDescriptor *viewControllerDescriptor = (IRViewControllerDescriptor *) resultingViewController.descriptor;

    // -- navigation controller and tabBar controller
    resultingViewController = [IRViewControllerBuilder wrapInTabBarControllerAndNavigationControllerIfNeeded:resultingViewController];
    // -- sideMenu controller
    resultingViewController = [IRViewControllerBuilder wrapInSideMenuIfNeeded:resultingViewController
                                                                   descriptor:viewControllerDescriptor
                                                             sideMenuDelegate:irViewController];

    return resultingViewController;
}

+ (IRViewController *) wrapInTabBarControllerAndNavigationControllerIfNeeded:(IRViewController *)irViewController
{
    IRViewController *resultingViewController = irViewController;
    IRViewControllerDescriptor *viewControllerDescriptor = (IRViewControllerDescriptor *) resultingViewController.descriptor;

    // -- navigation controller
    resultingViewController = [IRViewControllerBuilder wrapInNavigationControllerIfNeeded:resultingViewController
                                                                               descriptor:viewControllerDescriptor];
    // -- tabBar controller
    resultingViewController = [IRViewControllerBuilder wrapInTabBarControllerIfNeeded:resultingViewController
                                                                           descriptor:viewControllerDescriptor];

    return resultingViewController;
}

+ (IRViewController *) wrapInNavigationControllerIfNeeded:(IRViewController *)irViewController
                                               descriptor:(IRViewControllerDescriptor *)viewControllerDescriptor
{
    IRViewController *resultingViewController = irViewController;
    IRNavigationController *navigationController;

    if (viewControllerDescriptor.navigationController.autoAddIfNeeded) {
        navigationController = [[IRNavigationController alloc] initWithRootViewController:resultingViewController];
        resultingViewController = navigationController;
    }

    return resultingViewController;
}

+ (IRViewController *) wrapInTabBarControllerIfNeeded:(IRViewController *)irViewController
                                           descriptor:(IRViewControllerDescriptor *)viewControllerDescriptor
{
    IRViewController *resultingViewController = irViewController;
    IRTabBarController *tabBarController;
    IRTabBarControllerSubDescriptor *descriptor;
    IRScreenDescriptor *anTabBarScreenDescriptor;
    NSMutableArray *viewControllersArray;
    IRViewController *anTabBarViewController;
    NSString *screenId;
    BOOL irViewControllerAlreadyUsed = NO;

    if (viewControllerDescriptor.tabBarController) {
        descriptor = viewControllerDescriptor.tabBarController;
        tabBarController = [[IRTabBarController alloc] init];

        // -- viewControllers
        viewControllersArray = [NSMutableArray array];
        screenId = [[IRDataController sharedInstance] screenIdForControllerId:viewControllerDescriptor.componentId];
        for (IRTabBarItemDescriptor *irTabBarItemDescriptor in descriptor.viewControllers) {
            if ([irTabBarItemDescriptor.screenId isEqualToString:screenId]
                && irViewControllerAlreadyUsed == NO)
            { // reusing already build viewController (if there is screenId match)
                anTabBarViewController = irViewController;
                if ([anTabBarViewController isKindOfClass:[IRNavigationController class]]) {
                    ((IRViewController *)[((IRNavigationController *) anTabBarViewController).viewControllers lastObject]).data = irTabBarItemDescriptor.data;
                } else {
                    anTabBarViewController.data = irTabBarItemDescriptor.data;
                }
                irViewControllerAlreadyUsed = YES;
            } else {
                anTabBarScreenDescriptor = [[IRDataController sharedInstance] screenDescriptorWithId:irTabBarItemDescriptor.screenId];
                if (anTabBarScreenDescriptor) {
                    // -- set data and ui
                    anTabBarViewController = [IRViewControllerBuilder buildViewControllerFromScreenDescriptor:anTabBarScreenDescriptor
                                                                                                         data:irTabBarItemDescriptor.data];
                    // -- wrap if needed
                    anTabBarViewController = [IRViewControllerBuilder wrapInNavigationControllerIfNeeded:anTabBarViewController
                                                                                              descriptor:anTabBarScreenDescriptor.viewControllerDescriptor];
                } else {
                    anTabBarViewController = nil;
                }
            }
            anTabBarViewController.tabBarItem.title = irTabBarItemDescriptor.title;
            anTabBarViewController.tabBarItem.image = [[IRSimpleCache sharedInstance] imageForURI:irTabBarItemDescriptor.image];

            if (anTabBarViewController) {
                [viewControllersArray addObject:anTabBarViewController];
            }
        }
        tabBarController.viewControllers = viewControllersArray;

        // -- selectedIndex
        tabBarController.selectedIndex = descriptor.selectedIndex;

        // -- autoresizingMask
//        tabBarController.view.autoresizingMask=(UIViewAutoresizingFlexibleHeight);

        resultingViewController = tabBarController;
    }

    return resultingViewController;
}

+ (IRViewController *) wrapInSideMenuIfNeeded:(IRViewController *)irViewController
                                   descriptor:(IRViewControllerDescriptor *)viewControllerDescriptor
                             sideMenuDelegate:(id <RESideMenuDelegate>)delegate
{
    IRViewController *resultingViewController = irViewController;
    IRViewController *leftVC;
    IRViewController *rightVC;
    NSString *screenId;
    IRScreenDescriptor *screenDescriptor;
    RESideMenu *sideMenu;

    if (viewControllerDescriptor.sideMenu.enable) {
        // -- leftVC
        screenId = viewControllerDescriptor.sideMenu.leftMenuScreenId;
        screenDescriptor = [[IRDataController sharedInstance] screenDescriptorWithId:screenId];
        if (screenDescriptor) {
            leftVC = [IRViewControllerBuilder buildViewControllerFromScreenDescriptor:screenDescriptor data:nil];
        } else {
            leftVC = nil;
        }
        // -- rightVC
        screenId = viewControllerDescriptor.sideMenu.rightMenuScreenId;
        screenDescriptor = [[IRDataController sharedInstance] screenDescriptorWithId:screenId];
        if (screenDescriptor) {
            rightVC = [IRViewControllerBuilder buildViewControllerFromScreenDescriptor:screenDescriptor data:nil];
        } else {
            rightVC = nil;
        }
        if (leftVC || rightVC) {
            sideMenu = [IRViewControllerBuilder buildSideMenuFromScreenDescriptor:viewControllerDescriptor.sideMenu
                                                        withContentViewController:resultingViewController
                                                           leftMenuViewController:leftVC
                                                          rightMenuViewController:rightVC
                                                                 sideMenuDelegate:delegate];
            resultingViewController = sideMenu;
        }
    }

    return resultingViewController;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Private methods

+ (void) extendVCWithJSPlugin:(IRViewController *)irViewController
                   descriptor:(IRViewControllerDescriptor *)descriptor
                    jsContext:(JSContext *)jsContext
{
    NSString *jsPluginString;
    JSContext *tempJSContext;
    JSValue *tempGlobalObject;
    JSValue *tempPluginsMapValue;
    NSDictionary *tempPluginsMap;
    NSString *stringToEvaluate;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSString *jsonImagesPathComponent = [IRUtil jsonAndJsPathForAppDescriptor:[IRDataController sharedInstance].appDescriptor];
    NSData *fileData = [IRFileLoadingUtil dataForFileWithPath:descriptor.jsPluginPath
                                              destinationPath:[documentsDirectory stringByAppendingPathComponent:jsonImagesPathComponent]
                                                 preserveName:YES];
    jsPluginString = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
    if ([jsPluginString length] > 0) {
        tempJSContext = [[IRDataController sharedInstance] vcPluginExtensionJSContext];
        [tempJSContext evaluateScript:jsPluginString];
        tempGlobalObject = tempJSContext.globalObject;
        tempPluginsMapValue = tempGlobalObject[/*@"infrared"*/[IRUtilLibrary parent]][@"pluginsMap"];
        tempPluginsMap = [tempPluginsMapValue toDictionary];
        for (NSString *pluginName in tempPluginsMap) {
            stringToEvaluate = [NSString stringWithFormat:@
                                                            // IMPORTANT: 'setZeroTimeout' can not be added here this way. Operation is done on separate thread
                                                            //            and successive ObjC methods, which expect extended methods te be available,
                                                            //            don't have guarantee for availability
                                                            //            If 'setZeroTimeout' becomes necessary (for debugging) JS call-back methods has to be
                                                            //            introduced so successive ObjC code can rely on extended methods availability
//#if ENABLE_SAFARI_DEBUGGING == 1
//                                                        "setZeroTimeout( function() { "
//#endif
                                                            "%@.extendVCWithPluginName(%@, '%@');"
//#if ENABLE_SAFARI_DEBUGGING == 1
//                                                        " } );"
//#endif
              , [IRUtilLibrary parent], irViewController.key, pluginName];
            [jsContext evaluateScript:stringToEvaluate];
        }
    }
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
+ (void) addAutoLayoutConstraintsForRootView:(IRViewController *)irViewController
{
    // -- add constraints to root view
    [IRBaseBuilder addAutoLayoutConstraintsForView:irViewController.view
                                        descriptor:irViewController.rootView.descriptor
                                    viewController:irViewController];
    // -- add constraints to root view's subviews
    [IRBaseBuilder addAutoLayoutConstraintsForViewsArray:irViewController.view.subviews
                                          viewController:irViewController];
}
+ (void) addDataBindingsForRootView:(IRViewController *)irViewController
{
    [IRBaseBuilder addDataBindingsForView:irViewController.view
                           viewController:irViewController
                             dataBindings:((IRViewDescriptor *) irViewController.rootView.descriptor).dataBindingsArray];
}
+ (void) addRequireGestureRecognizerToFailForRootView:(IRViewController *)irViewController
{
    [IRBaseBuilder setRequireGestureRecognizerToFailForView:irViewController.view/*rootView*/
                                             viewController:irViewController];
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
+ (IRSideMenu *) buildSideMenuFromScreenDescriptor:(IRSideMenuDescriptor *)descriptor
                         withContentViewController:(IRViewController *)contentVC
                            leftMenuViewController:(IRViewController *)leftVC
                           rightMenuViewController:(IRViewController *)rightVC
                                  sideMenuDelegate:(id <RESideMenuDelegate>)delegate
{
    IRSideMenu *sideMenu = [[IRSideMenu alloc] initWithContentViewController:contentVC
                                                      leftMenuViewController:leftVC
                                                     rightMenuViewController:rightVC];
    if (descriptor.animationDuration != CGDOUBLE_UNDEFINED) {
        sideMenu.animationDuration = descriptor.animationDuration;
    }
    sideMenu.backgroundImage = [[IRSimpleCache sharedInstance] imageForURI:descriptor.backgroundImage];
    sideMenu.panGestureEnabled = descriptor.panGestureEnabled;
    sideMenu.panFromEdge = descriptor.panFromEdge;
    if (descriptor.panMinimumOpenThreshold != NSUINTEGER_UNDEFINED) {
        sideMenu.panMinimumOpenThreshold = descriptor.panMinimumOpenThreshold;
    }
    sideMenu.interactivePopGestureRecognizerEnabled = descriptor.interactivePopGestureRecognizerEnabled;
    sideMenu.scaleContentView = descriptor.scaleContentView;
    sideMenu.scaleBackgroundImageView = descriptor.scaleBackgroundImageView;
    sideMenu.scaleMenuView = descriptor.scaleMenuView;
    sideMenu.contentViewShadowEnabled = descriptor.contentViewShadowEnabled;
    sideMenu.contentViewShadowColor = descriptor.contentViewShadowColor;
    if (CGSizeEqualToSize(descriptor.contentViewShadowOffset, CGSizeNull) == NO) {
        sideMenu.contentViewShadowOffset = descriptor.contentViewShadowOffset;
    }
    if (descriptor.contentViewShadowOpacity != CGFLOAT_UNDEFINED) {
        sideMenu.contentViewShadowOpacity = descriptor.contentViewShadowOpacity;
    }
    if (descriptor.contentViewShadowRadius != CGFLOAT_UNDEFINED) {
        sideMenu.contentViewShadowRadius = descriptor.contentViewShadowRadius;
    }
    if (descriptor.contentViewScaleValue != CGFLOAT_UNDEFINED) {
        sideMenu.contentViewScaleValue = descriptor.contentViewScaleValue;
    }
    if (descriptor.contentViewInLandscapeOffsetCenterX != CGFLOAT_UNDEFINED) {
        sideMenu.contentViewInLandscapeOffsetCenterX = descriptor.contentViewInLandscapeOffsetCenterX;
    }
    if (descriptor.contentViewInPortraitOffsetCenterX != CGFLOAT_UNDEFINED) {
        sideMenu.contentViewInPortraitOffsetCenterX = descriptor.contentViewInPortraitOffsetCenterX;
    }
    if (descriptor.parallaxMenuMinimumRelativeValue != CGFLOAT_UNDEFINED) {
        sideMenu.parallaxMenuMinimumRelativeValue = descriptor.parallaxMenuMinimumRelativeValue;
    }
    if (descriptor.parallaxMenuMaximumRelativeValue != CGFLOAT_UNDEFINED) {
        sideMenu.parallaxMenuMaximumRelativeValue = descriptor.parallaxMenuMaximumRelativeValue;
    }
    if (descriptor.parallaxContentMinimumRelativeValue != CGFLOAT_UNDEFINED) {
        sideMenu.parallaxContentMinimumRelativeValue = descriptor.parallaxContentMinimumRelativeValue;
    }
    if (descriptor.parallaxContentMaximumRelativeValue != CGFLOAT_UNDEFINED) {
        sideMenu.parallaxContentMaximumRelativeValue = descriptor.parallaxContentMaximumRelativeValue;
    }
    sideMenu.menuViewControllerTransformation = descriptor.menuViewControllerTransformation;
    sideMenu.parallaxEnabled = descriptor.parallaxEnabled;
    sideMenu.bouncesHorizontally = descriptor.bouncesHorizontally;
    sideMenu.menuPreferredStatusBarStyle = descriptor.menuPreferredStatusBarStyle;
    sideMenu.menuPrefersStatusBarHidden = descriptor.menuPrefersStatusBarHidden;
//    if ([contentVC isKindOfClass:[UINavigationController class]]) {
//        if ([((UINavigationController *) contentVC).viewControllers count] > 0) {
//            sideMenu.delegate = [((UINavigationController *) contentVC).viewControllers firstObject];
//        }
//    } else if ([contentVC isKindOfClass:[UIViewController class]]) {
//        sideMenu.delegate = contentVC;
//    }
    sideMenu.delegate = delegate;
    return sideMenu;
}

@end