//
// Created by Uros Milivojevic on 8/30/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRViewController.h"
#import "IRGlobal.h"
#import "IRView.h"
#import "IRDataController.h"
#import "IRBaseBuilder.h"
#import "IRBaseBuilder+AutoLayout.h"
#import "IRBaseDescriptor.h"
#import "IRViewControllerDescriptor.h"
#import "IRUtil.h"
#import "IRViewControllerBuilder.h"
#import "IRScrollView.h"
#import "IRNavigationControllerSubDescriptor.h"
#import "IRSimpleCache.h"
#import "IRKeyboardAutoResizeData.h"
#import "IRUtilLibrary.h"
#import "IRScreenDescriptor.h"
#import "IQKeyboardManager.h"
#import "IRViewBuilder.h"
#import "IRViewDescriptor.h"
#import "Infrared.h"
#import "IRActionSheet.h"
#import "IRNavigationController.h"
#import "IRAlertView.h"
#import "IRKeyboardManagerSubDescriptor.h"
#import "MBProgressHUD.h"
#import <MapKit/MapKit.h>

@interface UIWindow (AutoLayoutDebug)
+ (UIWindow *)keyWindow;
- (NSString *)_autolayoutTrace;
@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRViewController ()

@property (nonatomic, strong) NSMutableArray *jsValueNamesWatchForDataBindingArray;

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@implementation IRViewController

@synthesize componentInfo;
@synthesize descriptor;
@synthesize rootView;
@synthesize jsPlugin;
@synthesize data;

- (instancetype) init
{
    self = [super init];
    if (self) {
        self.imageLoadingDataDictionary = [NSMutableDictionary dictionary];
        self.shouldUnregisterVC = NO;
        self.shouldUnregisterVCStack = NO;
    }
    return self;
}


- (void)viewDidLoad // Called after the view has been loaded. For view controllers created in code, this is after -loadView. For view controllers unarchived from a nib, this is after the view is set.
{
    [super viewDidLoad];

    NSString *screenId = [[IRDataController sharedInstance] screenIdForControllerId:self.descriptor.componentId];
    IRScreenDescriptor *screenDescriptor = [[IRDataController sharedInstance] screenDescriptorWithId:screenId];

    if (screenDescriptor.viewControllerDescriptor.requestWhenInUseAuthorization
        || screenDescriptor.viewControllerDescriptor.requestAlwaysAuthorization)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        // -- requestWhenInUseAuthorization
        if (screenDescriptor.viewControllerDescriptor.requestWhenInUseAuthorization) {
            if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) { // iOS8+
                // Sending a message to avoid compile time error
                [[UIApplication sharedApplication] sendAction:@selector(requestWhenInUseAuthorization)
                                                           to:self.locationManager
                                                         from:self
                                                     forEvent:nil];
            }
        }
        // -- requestAlwaysAuthorization
        if (screenDescriptor.viewControllerDescriptor.requestAlwaysAuthorization) {
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) { // iOS8+
                // Sending a message to avoid compile time error
                [[UIApplication sharedApplication] sendAction:@selector(requestAlwaysAuthorization)
                                                           to:self.locationManager
                                                         from:self
                                                     forEvent:nil];
            }
        }
        [self.locationManager startUpdatingLocation];
    }

    if (screenDescriptor.rootViewDescriptor) {
        // -- add all subviews
        for (IRView *anSubview in self.rootView.subviews) {
            [self.view addSubview:anSubview];
        }
        // -- set up view
        [IRViewBuilder setUpRootView:self.view
                 componentDescriptor:screenDescriptor.rootViewDescriptor
                      viewController:self
                               extra:nil];

        [IRViewControllerBuilder addAutoLayoutConstraintsForRootView:self];
        [IRViewControllerBuilder addDataBindingsForRootView:self];
        [IRViewControllerBuilder addRequireGestureRecognizerToFailForRootView:self];
    }

    [self callJSEquivalentMethod:NSStringFromSelector(@selector(viewDidLoad)) arguments:@[]];
}

-(void)viewWillAppear:(BOOL)animated // Called when the view is about to made visible. Default does nothing
{
    [super viewWillAppear:animated];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    NSMutableDictionary *titleTextAttributes = [NSMutableDictionary dictionary];

    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    [self updateViewWithOrientation:orientation animated:NO duration:0];

    IRViewControllerDescriptor *descriptor = ((IRViewControllerDescriptor *)self.descriptor);
    // -- leftBarButtonItem
    if (descriptor.navigationController.leftBarButtonItem) {
        self.navigationItem.leftBarButtonItem = [IRBaseBuilder buildComponentFromDescriptor:descriptor.navigationController.leftBarButtonItem
                                                                             viewController:self
                                                                                      extra:nil];
    }
    // -- rightBarButtonItem
    if (descriptor.navigationController.rightBarButtonItem) {
        self.navigationItem.rightBarButtonItem = [IRBaseBuilder buildComponentFromDescriptor:descriptor.navigationController.rightBarButtonItem
                                                                             viewController:self
                                                                                      extra:nil];
    }
    // -- hideNavigationBar
    if (descriptor.navigationController.hideNavigationBar) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    } else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    // -- navigationBarTranslucent
    if (descriptor.navigationController.navigationBarTranslucent) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                      forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [UIImage new];
        self.navigationController.navigationBar.translucent = YES;
    }
    // -- navigationBarTintColor
    if (descriptor.navigationController.navigationBarTintColor) {
        self.navigationController.navigationBar.barTintColor = descriptor.navigationController.navigationBarTintColor;
    }
    // -- navigationTintColor
    if (descriptor.navigationController.navigationTintColor) {
        self.navigationController.navigationBar.tintColor = descriptor.navigationController.navigationTintColor;
    }
    // -- navigationTitleColor
    if (descriptor.navigationController.navigationTitleColor) {
        [titleTextAttributes setValue:descriptor.navigationController.navigationTitleColor
                               forKey:NSForegroundColorAttributeName];
    }
    // -- navigationTitleFont
    if (descriptor.navigationController.navigationTitleFont) {
        [titleTextAttributes setValue:descriptor.navigationController.navigationTitleFont
                               forKey:NSFontAttributeName];
    }
    // -- all titleTextAttributes (navigationTitleColor, navigationTitleFont)
    if ([titleTextAttributes count] > 0) {
        self.navigationController.navigationBar.titleTextAttributes = titleTextAttributes;
    }
    // -- backIndicatorImage
    if (descriptor.navigationController.backIndicatorImage) {
        UIImage *image = [[IRSimpleCache sharedInstance] imageForURI:descriptor.navigationController.backIndicatorImage];
        [self.navigationController.navigationBar setBackIndicatorImage:image];
        [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:image];
    } else {
        [self.navigationController.navigationBar setBackIndicatorImage:nil];
        [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:nil];
    }

    // IQKeyboardManager
    [IQKeyboardManager sharedManager].enable = descriptor.keyboardManager.enable;
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = descriptor.keyboardManager.keyboardDistanceFromTextField;
    [IQKeyboardManager sharedManager].preventShowingBottomBlankSpace = descriptor.keyboardManager.preventShowingBottomBlankSpace;
    [IQKeyboardManager sharedManager].enableAutoToolbar = descriptor.keyboardManager.enableAutoToolbar;
    [IQKeyboardManager sharedManager].toolbarManageBehaviour = descriptor.keyboardManager.toolbarManageBehaviour;
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = descriptor.keyboardManager.shouldToolbarUsesTextFieldTintColor;
    [IQKeyboardManager sharedManager].shouldShowTextFieldPlaceholder = descriptor.keyboardManager.shouldShowTextFieldPlaceholder;
    [IQKeyboardManager sharedManager].placeholderFont = descriptor.keyboardManager.placeholderFont;
    [IQKeyboardManager sharedManager].canAdjustTextView = descriptor.keyboardManager.canAdjustTextView;
    [IQKeyboardManager sharedManager].shouldFixTextViewClip = descriptor.keyboardManager.shouldFixTextViewClip;
    [IQKeyboardManager sharedManager].overrideKeyboardAppearance = descriptor.keyboardManager.overrideKeyboardAppearance;
    [IQKeyboardManager sharedManager].keyboardAppearance = descriptor.keyboardManager.keyboardAppearance;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = descriptor.keyboardManager.shouldResignOnTouchOutside;
    [IQKeyboardManager sharedManager].shouldPlayInputClicks = descriptor.keyboardManager.shouldPlayInputClicks;
    [IQKeyboardManager sharedManager].shouldAdoptDefaultKeyboardAnimation = descriptor.keyboardManager.shouldAdoptDefaultKeyboardAnimation;

    [self callJSEquivalentMethod:NSStringFromSelector(@selector(viewWillAppear:)) arguments:@[@(animated)]];
}

-(void)viewDidAppear:(BOOL)animated // Called when the view has been fully transitioned onto the screen. Default does nothing
{
    [super viewDidAppear:animated];

//    NSLog(@"%@", [[UIWindow keyWindow] _autolayoutTrace]);

    [self callJSEquivalentMethod:NSStringFromSelector(@selector(viewDidAppear:)) arguments:@[@(animated)]];
}

- (void)viewWillDisappear:(BOOL)animated // Called when the view is dismissed, covered or otherwise hidden. Default does nothing
{
    [super viewWillDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification
                                                  object:nil];

    [self callJSEquivalentMethod:NSStringFromSelector(@selector(viewWillDisappear:)) arguments:@[@(animated)]];
}

- (void)viewDidDisappear:(BOOL)animated  // Called after the view was dismissed, covered or otherwise hidden. Default does nothing
{
    [super viewDidDisappear:animated];

    [self callJSEquivalentMethod:NSStringFromSelector(@selector(viewDidDisappear:)) arguments:@[@(animated)]];

    if (self.shouldUnregisterVC) {
//        NSLog(@"viewDidDisappear - unregisterViewController - key:%@", self.key);
        [[IRDataController sharedInstance] unregisterViewController:self];
    }

    if (self.shouldUnregisterVCStack) {
        [self unregisterViewControllerAndItsNavigationStack:self];
    }
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

// Called just before the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
- (void)viewWillLayoutSubviews NS_AVAILABLE_IOS(5_0)
{
    [super viewWillLayoutSubviews];

    self.view.translatesAutoresizingMaskIntoConstraints = YES;
}
// Called just after the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
- (void)viewDidLayoutSubviews NS_AVAILABLE_IOS(5_0)
{
    [super viewDidLayoutSubviews];

}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (void) willMoveToParentViewController:(UIViewController *)parent
{
    if (parent == nil) {
        self.shouldUnregisterVC = YES;
    }
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (void) pushViewControllerWithScreenId:(NSString *)screenId animated:(BOOL)animated
{
    [self pushViewControllerWithScreenId:screenId animated:animated withData:nil];
}
- (void) pushViewControllerWithScreenId:(NSString *)screenId animated:(BOOL)animated withData:(id)data
{
    IRScreenDescriptor *screenDescriptor;
    screenDescriptor = [[IRDataController sharedInstance] screenDescriptorWithId:screenId];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self pushVCFromScreenDescriptor:screenDescriptor animated:animated withData:data];
    });
}
// --------------------------------------------------------------------------------------------------------------------
- (void) pushViewControllerWithId:(NSString *)viewControllerId animated:(BOOL)animated
{
    [self pushViewControllerWithId:viewControllerId animated:animated withData:nil];
}
- (void) pushViewControllerWithId:(NSString *)viewControllerId animated:(BOOL)animated withData:(id)data
{
    IRScreenDescriptor *screenDescriptor;
    screenDescriptor = [[IRDataController sharedInstance] screenDescriptorWithControllerId:viewControllerId];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self pushVCFromScreenDescriptor:screenDescriptor animated:animated withData:data];
    });
}
// --------------------------------------------------------------------------------------------------------------------
- (void) popViewControllerAnimated:(BOOL)animated
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:animated];
    });
}
// --------------------------------------------------------------------------------------------------------------------
- (void) presentViewControllerWithScreenId:(NSString *)screenId animated:(BOOL)animated
{
    [self presentViewControllerWithScreenId:screenId animated:animated withData:nil];
}
- (void) presentViewControllerWithScreenId:(NSString *)screenId animated:(BOOL)animated withData:(id)data
{
    IRScreenDescriptor *screenDescriptor;
    screenDescriptor = [[IRDataController sharedInstance] screenDescriptorWithId:screenId];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentVCFromScreenDescriptor:screenDescriptor animated:animated withData:data];
    });
}
// --------------------------------------------------------------------------------------------------------------------
- (void) presentViewControllerWithId:(NSString *)viewControllerId animated:(BOOL)animated
{
    [self presentViewControllerWithId:viewControllerId animated:animated withData:nil];
}
- (void) presentViewControllerWithId:(NSString *)viewControllerId animated:(BOOL)animated withData:(id)data
{
    IRScreenDescriptor *screenDescriptor;
    screenDescriptor = [[IRDataController sharedInstance] screenDescriptorWithControllerId:viewControllerId];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentVCFromScreenDescriptor:screenDescriptor animated:animated withData:data];
    });
}
- (void)dismissViewControllerAnimated:(BOOL)animated
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:animated
                                 completion:^{
                                     [self unregisterViewControllerAndItsNavigationStack:self];
                                 }];
    });
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
- (void) buildAndSetRootViewControllerWithScreenId:(NSString *)screenId
                                           andData:(id)data
{
    IRScreenDescriptor *screenDescriptor = [[IRDataController sharedInstance] screenDescriptorWithId:screenId];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[Infrared sharedInstance] buildViewControllerAndSetRootViewControllerScreenDescriptor:screenDescriptor
                                                                                          data:data];
    });
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
- (void) showAlertViewWithTitle:(NSString *)title
                        message:(NSString *)message
                         action:(NSString *)action
                         cancel:(NSString *)cancelTitle
                   otherButtons:(NSArray *)otherTitlesArray
                           data:(id)data
{
    IRAlertView * alert = [[IRAlertView alloc ] initWithTitle:title
                                                      message:message
                                                     delegate:self
                                            cancelButtonTitle:cancelTitle
                                            otherButtonTitles:nil];
    alert.action = action;
    alert.data = data;
    __unsafe_unretained typeof(self) weakSelf = self;
    alert.componentInfo = weakSelf;
    for (NSString* otherButtonTitle in otherTitlesArray) {
        [alert addButtonWithTitle:otherButtonTitle];
    }
    [alert show];
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
- (void) showActionSheetWithTitle:(NSString *)title
                           action:(NSString *)action
                           cancel:(NSString *)cancelTitle
                      destructive:(NSString *)destructiveTitle
                     otherButtons:(NSArray *)otherTitlesArray
                             data:(id)data
{
    NSString *destructiveTitleWithCheck = nil;
    // This is necessary - for some reason JSContext transforms null into "null" (NSString) instead of nil
    if (destructiveTitle && [destructiveTitle length] > 0 && [destructiveTitle isEqualToString:@"null"] == NO) {
        destructiveTitleWithCheck = destructiveTitle;
    }
    IRActionSheet *actionSheet = [[IRActionSheet alloc] initWithTitle:title
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:destructiveTitleWithCheck
                                                    otherButtonTitles:nil];
    actionSheet.action = action;
    actionSheet.data = data;
    __unsafe_unretained typeof(self) weakSelf = self;
    actionSheet.componentInfo = weakSelf;
    for (NSString* otherButtonTitle in otherTitlesArray) {
        [actionSheet addButtonWithTitle:otherButtonTitle];
    }
    if (cancelTitle && [cancelTitle length] > 0 && [cancelTitle isEqualToString:@"null"] == NO) {
        [actionSheet addButtonWithTitle:cancelTitle];
        [actionSheet setCancelButtonIndex:[actionSheet numberOfButtons] - 1];
    }
    [actionSheet showInView:self.view];
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
- (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title
{
    return [[IRUtilLibrary sharedInstance] showGlobalProgressHUDWithTitle:title];
}
- (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title mode:(MBProgressHUDMode)mode
{
    return [[IRUtilLibrary sharedInstance] showGlobalProgressHUDWithTitle:title mode:mode];
}
- (void)dismissGlobalHUD
{
    [[IRUtilLibrary sharedInstance] dismissGlobalHUD];
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
- (IRView *) viewWithId:(NSString *)viewId
{
    return [[IRUtilLibrary sharedInstance] viewWithId:viewId viewController:self];
}
- (void) showComponentWithId:(NSString *)componentId
{
    [[IRUtilLibrary sharedInstance] showComponentWithId:componentId viewController:self];
}
- (void) hideComponentWithId:(NSString *)componentId
{
    [[IRUtilLibrary sharedInstance] hideComponentWithId:componentId viewController:self];
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (NSArray *) controllersWithId:(NSString *)controllerId
{
    return [[IRUtilLibrary sharedInstance] controllersWithId:controllerId];
}
- (NSArray *) controllersWithScreenId:(NSString *)screenId
{
    return [[IRUtilLibrary sharedInstance] controllersWithScreenId:screenId];
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (void) updateComponentsWithDataBindingKey:(NSString *)dataBindingKey
{
    // KVO related triggering (ReactiveCocoa uses KVO as base)
    dispatch_async(dispatch_get_main_queue(), ^{
//        [self setJsMapUsedInDataBindingForKey:dataBindingKey currentValue:nil];
        [self willChangeValueForKey:dataBindingKey];
        [self didChangeValueForKey:dataBindingKey];
    });
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (NSString *)key
{
    return [IRUtil createKeyFromVCAddress:self];
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - RESideMenu

- (void)presentLeftMenuViewController:(id)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.sideMenuViewController presentLeftMenuViewController];
    });
}

- (void)presentRightMenuViewController:(id)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.sideMenuViewController presentLeftMenuViewController];
    });
}

- (void)hideMenuViewController
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.sideMenuViewController hideMenuViewController];
    });
}
- (void)setContentViewControllerWithScreenId:(NSString *)screenId animated:(BOOL)animated
{
    NSString *currentVCId;
    NSString *currentScreenId;
    IRScreenDescriptor *screenDescriptor;

    IRViewController *currentContentViewController = (IRViewController *) self.sideMenuViewController.contentViewController;
    if ([currentContentViewController isKindOfClass:[IRNavigationController class]]) {
        currentContentViewController = ((IRNavigationController *)currentContentViewController).viewControllers[0];
    }
    currentVCId = currentContentViewController.descriptor.componentId;
    currentScreenId = [[IRDataController sharedInstance] screenIdForControllerId:currentVCId];
    if ([currentScreenId isEqualToString:screenId] == NO) {
        // -- prepare and set new VC
        screenDescriptor = [[IRDataController sharedInstance] screenDescriptorWithId:screenId];
        if (screenDescriptor) {
            dispatch_async(dispatch_get_main_queue(), ^{
                IRViewController *contentViewController = [IRViewControllerBuilder buildViewControllerFromScreenDescriptor:screenDescriptor
                                                                                                                      data:nil];
                // -- navigation controller and tabBar controller
                contentViewController = [IRViewControllerBuilder wrapInTabBarControllerAndNavigationControllerIfNeeded:contentViewController];
                self.sideMenuViewController.delegate = contentViewController;
                [self.sideMenuViewController setContentViewController:contentViewController
                                                             animated:animated];

                currentContentViewController.shouldUnregisterVCStack = YES;
            });
        }
    }

    [self hideMenuViewController];
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (void) watchJSCallbackToObjC:(id)prop :(id)action :(id)newValue :(id)oldValue
{
    BOOL valueChange = YES;
    if ([newValue isKindOfClass:[NSArray class]]) {
        if ([newValue isEqualToArray:oldValue]) {
            valueChange = NO;
        }
    } else if ([newValue isKindOfClass:[NSDictionary class]]) {
        if ([newValue isEqualToDictionary:oldValue]) {
            valueChange = NO;
        }
    } else if ([newValue isKindOfClass:[NSString class]]) {
        if ([newValue isEqualToString:oldValue]) {
            valueChange = NO;
        }
    } else if ([newValue isKindOfClass:[NSNumber class]]) {
        if ([newValue isEqualToNumber:oldValue]) {
            valueChange = NO;
        }
    }
    if (valueChange) {
//        NSLog(@"watch-ObjC-callback (value DID change): VCkey=%@, property=%@, action=%@, newValue=%@",
//          self.key, prop, action, newValue);
//        [self setJsMapUsedInDataBindingForKey:prop currentValue:newValue];
        [self willChangeValueForKey:prop];
        [self didChangeValueForKey:prop];
    } else {
//        NSLog(@"watch-ObjC-callback (value DID NOT change): VCkey=%@, property=%@, action=%@", self.key, prop, action);
    }
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Status-bar methods

- (BOOL)prefersStatusBarHidden {
    return ((IRViewControllerDescriptor *)self.descriptor).prefersStatusBarHidden; // set to "NO" to show status-bar in landscape mode
}
-(UIStatusBarStyle)preferredStatusBarStyle {
    return ((IRViewControllerDescriptor *)self.descriptor).preferredStatusBarStyle;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Public methods

- (void) keyPathUpdatedInReactiveCocoa:(NSString *)keyPath
                        newStringValue:(NSString *)newStringValue
{
//    NSLog(@"********** keyPathUpdatedInReactiveCocoa:newStringValue: %@", keyPath);
    // If some of components in path is NSDictionary that object has to be manually updated in JSContext
    // This only applies if object should be available in JSContext (value in JSExport or in JSPlugin)

    NSRange range;
    NSString *firstParentPath;
    NSString *variableName;
    JSContext *jsContext;
    NSString *stringToEvaluate;
    JSValue *jsValue;
    NSArray *firstParentPathComponents;
    NSString *vcPropertyName;

    range = [keyPath rangeOfString:@"." options:NSBackwardsSearch];

    if (range.location != NSNotFound) {
        firstParentPath = [keyPath substringToIndex:range.location];
        variableName = [keyPath substringFromIndex:range.location+1];
        jsContext = [IRDataController sharedInstance].globalJSContext;
        stringToEvaluate = [NSString stringWithFormat:@"typeof %@.%@ === 'undefined'", self.key, firstParentPath];
        jsValue = [jsContext evaluateScript:stringToEvaluate];
        if ([jsValue toBool] == YES) {
//            NSLog(@"do NOT do anything");
        } else {
            jsValue = jsContext[self.key];

            firstParentPathComponents = [firstParentPath componentsSeparatedByString:@"."];
            if ([firstParentPathComponents count] > 0) {
                vcPropertyName = firstParentPathComponents[0];
            }
            for (NSString *pathComponent in firstParentPathComponents) {
                jsValue = jsValue[pathComponent];
            }

            if ([[jsValue toObject] isKindOfClass:[NSDictionary class]]) {
//                NSLog(@"update JSContext, keyPath=%@, value=%@", keyPath, newStringValue);
                // -- update JS value
                jsValue[variableName] = newStringValue;
                // -- notify ReactiveCocoa that value is changed
                // (not necessary if VC's property is changed, BUT is mandatory if sub-property is changed)
                if ([[keyPath componentsSeparatedByString:@"."] count] > 1) {
                    [self updateComponentsWithDataBindingKey:vcPropertyName];
                }
            }
        }
    }
}

- (void) addViewForOrientationRestriction:(IRView *)irView
{
    if (self.viewsArrayForOrientationRestriction == nil) {
        self.viewsArrayForOrientationRestriction = [NSMutableArray array];
    }

    if ([self.viewsArrayForOrientationRestriction containsObject:irView] == NO) {
        [self.viewsArrayForOrientationRestriction addObject:irView];
    }
}

- (void) addViewForKeyboardResize:(IRView *)aView
                 bottomConstraint:(NSLayoutConstraint *)constraint
{
    if (self.viewsArrayForKeyboardResize == nil) {
        self.viewsArrayForKeyboardResize = [NSMutableArray array];
    }

    if ([self.viewsArrayForKeyboardResize containsObject:aView] == NO) {
        IRKeyboardAutoResizeData *keyboardAutoResizeData = [[IRKeyboardAutoResizeData alloc] init];
        keyboardAutoResizeData.view = aView;
        keyboardAutoResizeData.constraint = constraint;
        if ([aView isKindOfClass:[UIScrollView class]]) {
            keyboardAutoResizeData.scrollViewOriginalEdgeInsets = ((UIScrollView *)aView).contentInset;
        } else {
            keyboardAutoResizeData.constraintOriginalConstant = constraint.constant;
        }
        [self.viewsArrayForKeyboardResize addObject:keyboardAutoResizeData];
    }
}

- (void) cleanWatchJSObserversAndVC
{
//    NSLog(@"cleanWatchJSObserversAndVC - %@", self.key);
    JSContext *jsContext = [IRDataController sharedInstance].globalJSContext;
    NSString *propertyName;
    for (uint i = 0; i<[self.jsValueNamesWatchForDataBindingArray count]; i++) {
        propertyName = self.jsValueNamesWatchForDataBindingArray[i];
        @try {
            NSString *method = [NSString stringWithFormat:@
#if ENABLE_SAFARI_DEBUGGING == 1
                                                            "setZeroTimeout( function() { "
#endif
                                                                "if (typeof %@ !== 'undefined') { "
                                                                    "unwatch(%@, '%@'); "
                                                                    "delete %@ ; "
                                                                "}"
#if ENABLE_SAFARI_DEBUGGING == 1
                                                            " } );"
#endif
                                                           , self.key, self.key, propertyName, self.key];
            [jsContext evaluateScript:method];
        }
        @catch (NSException *exception) {
            NSLog(@"Exception occurred: %@, %@", exception, [exception userInfo]);
        }
    }
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Orientation handling

-(NSUInteger)supportedInterfaceOrientations
{
    UIInterfaceOrientationMask supportedInterfaceOrientations = 0;

    NSArray *supportedInterfaceOrientationsArray = ((IRViewControllerDescriptor *)self.descriptor).supportedInterfaceOrientationsArray;
    for (NSNumber *anInterfaceOrientation in supportedInterfaceOrientationsArray) {
        supportedInterfaceOrientations |= (1<<anInterfaceOrientation.integerValue);
    }

    return supportedInterfaceOrientations;
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    UIInterfaceOrientation preferredInterfaceOrientation = 0;

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([self viewControllerSupportsOrientation:UIInterfaceOrientationPortrait]) {
            preferredInterfaceOrientation = UIInterfaceOrientationPortrait;
        } else if ([self viewControllerSupportsOrientation:UIInterfaceOrientationLandscapeRight]) {
            preferredInterfaceOrientation = UIInterfaceOrientationLandscapeRight;
        }
    } else {
        if ([self viewControllerSupportsOrientation:UIInterfaceOrientationLandscapeRight]) {
            preferredInterfaceOrientation = UIInterfaceOrientationLandscapeRight;
        } else if ([self viewControllerSupportsOrientation:UIInterfaceOrientationPortrait]) {
            preferredInterfaceOrientation = UIInterfaceOrientationPortrait;
        }
    }
    return preferredInterfaceOrientation;
}
-(BOOL)shouldAutorotate
{
    return YES;
}
// --------------------------------------------------------------------------------------------------------------------
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    [self updateViewWithOrientation:toInterfaceOrientation animated:YES duration:duration];
}
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];


}
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];


}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Keyboard showing/hiding notification methods

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info;
    NSValue *kbFrame;
    CGRect keyboardFrame;
    BOOL isPortrait;
    CGFloat height;

    info = [notification userInfo];
    kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    keyboardFrame = [kbFrame CGRectValue];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        height = keyboardFrame.size.height;
    } else {
        isPortrait = UIDeviceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation);
        height = isPortrait ? keyboardFrame.size.height : keyboardFrame.size.width;
    }

    if ([self.viewsArrayForKeyboardResize count] > 0) {
        IRView *anView;
        IRScrollView *anScrollView;
        UIEdgeInsets contentInsets;
        CGRect frameRelativeToRoot;
        CGFloat bottomPosition;
        CGFloat resizeHeight;
        NSLayoutConstraint *anConstraint;
        for (IRKeyboardAutoResizeData *keyboardAutoResizeData in self.viewsArrayForKeyboardResize) {
            anView = keyboardAutoResizeData.view;
            frameRelativeToRoot = [anView convertRect:anView.bounds toView:nil];
            bottomPosition = frameRelativeToRoot.origin.y + frameRelativeToRoot.size.height;
            if (bottomPosition < self.view.frame.size.height) {
                resizeHeight = height - (self.view.frame.size.height - bottomPosition);
            } else {
                resizeHeight = height;
            }
//            NSLog(@"vc-key:%@ ,view:%p, frame:%@, resizeHeight:%f", self.key,
//              anView, NSStringFromCGRect(frameRelativeToRoot), resizeHeight);
            if ([anView isKindOfClass:[UIScrollView class]]) {
                anScrollView = anView;
                contentInsets = UIEdgeInsetsMake(0.0, 0.0, resizeHeight, 0.0);
                anScrollView.contentInset = contentInsets;
                anScrollView.scrollIndicatorInsets = contentInsets;
            } else {
                anConstraint = keyboardAutoResizeData.constraint;
                anConstraint.constant = -resizeHeight;
            }
        }
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    if ([self.viewsArrayForKeyboardResize count] > 0) {
        IRView *anView;
        IRScrollView *anScrollView;
        NSLayoutConstraint *anConstraint;
        for (IRKeyboardAutoResizeData *keyboardAutoResizeData in self.viewsArrayForKeyboardResize) {
            anView = keyboardAutoResizeData.view;
//            NSLog(@"vc-key:%@ ,view:%p", self.key, anView);
            if ([anView isKindOfClass:[UIScrollView class]]) {
                anScrollView = anView;
                NSLog(@"   - contentInset:%@", NSStringFromUIEdgeInsets(keyboardAutoResizeData.scrollViewOriginalEdgeInsets));
                anScrollView.contentInset = keyboardAutoResizeData.scrollViewOriginalEdgeInsets;
                anScrollView.scrollIndicatorInsets = keyboardAutoResizeData.scrollViewOriginalEdgeInsets;
            } else {
                anConstraint = keyboardAutoResizeData.constraint;
                anConstraint.constant = keyboardAutoResizeData.constraintOriginalConstant;
            }
        }
    }
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - UIScrollView delegate methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView
  clickedButtonAtIndex:(NSInteger)buttonIndex
{
    IRAlertView *irAlertView = (IRAlertView *) alertView;
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"alertView"] = alertView;
    dictionary[@"buttonIndex"] = @(buttonIndex);
    if (irAlertView.data) {
        dictionary[@"data"] = irAlertView.data;
    }
    [IRBaseBuilder executeAction:irAlertView.action withDictionary:dictionary sourceView:irAlertView];
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet
  clickedButtonAtIndex:(NSInteger)buttonIndex
{
    IRActionSheet *irActionSheet = (IRActionSheet *) actionSheet;
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"actionSheet"] = actionSheet;
    dictionary[@"buttonIndex"] = @(buttonIndex);
    if (irActionSheet.data) {
        dictionary[@"data"] = irActionSheet.data;
    }
    [IRBaseBuilder executeAction:irActionSheet.action withDictionary:dictionary sourceView:irActionSheet];
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - RESideMenuDelegate

- (void)sideMenu:(RESideMenu *)sideMenu didRecognizePanGesture:(UIPanGestureRecognizer *)recognizer
{

    [self callJSEquivalentMethod:NSStringFromSelector(@selector(sideMenu:didRecognizePanGesture:))
                       arguments:@[sideMenu, recognizer]];
}
- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{

    [self callJSEquivalentMethod:NSStringFromSelector(@selector(sideMenu:willShowMenuViewController:))
                       arguments:@[sideMenu, menuViewController]];
}
- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{

    [self callJSEquivalentMethod:NSStringFromSelector(@selector(sideMenu:didShowMenuViewController:))
                       arguments:@[sideMenu, menuViewController]];
}
- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{

    [self callJSEquivalentMethod:NSStringFromSelector(@selector(sideMenu:willHideMenuViewController:))
                       arguments:@[sideMenu, menuViewController]];
}
- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{

    [self callJSEquivalentMethod:NSStringFromSelector(@selector(sideMenu:didHideMenuViewController:))
                       arguments:@[sideMenu, menuViewController]];
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - KVO/KVC

- (id)valueForUndefinedKey:(NSString *)key
{
    id value = nil;
    JSContext *jsContext;
    JSValue *jsValue;

    // Line below commented to allow visibility of changes done in JS - (1)
//    value = [self jsMapUsedInDataBindingForKey:key];
    if (value == nil) {
//        NSLog(@"valueForUndefinedKey - access JSValue '%@'", key);
        jsContext = [IRDataController sharedInstance].globalJSContext;
        jsValue = jsContext[self.key][key]; // jsContext[self.key][@"inviteUserArray"]
        if (jsValue) {
            if ([jsValue isString]) {
                value = [jsValue toString];
            } else if ([jsValue isNumber]) {
                value = [jsValue toNumber];
            } else if ([jsValue isBoolean]) {
                value = @([jsValue toBool]);
            } else if ([jsValue isObject]) {
                value = [jsValue toObject];
//                if ([value isKindOfClass:[NSMutableDictionary class]]
//                  || [value isKindOfClass:[NSMutableArray class]])
//                {
//                    [self setJsMapUsedInDataBindingForKey:key currentValue:value];
//                    jsContext[self.key][key] = value;
//                }
            }
            [self addWatchMethodToJSValueWithName:key numberOfLevels:@(0)];
        }
    }
//    NSLog(@"valueForUndefinedKey: key=%@, value=%@", key, value);
    return value;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
//    NSLog(@"*** %@ - setValue:%@, forUndefinedKey:%@", self.key, value, key);
    JSContext *jsContext = [IRDataController sharedInstance].globalJSContext;
    jsContext[self.key][key] = value;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Private methods

- (BOOL) viewControllerSupportsOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    BOOL viewControllerSupportsOrientation = NO;
    IRViewControllerDescriptor *descriptor = self.descriptor;
    for (NSNumber *anInterfaceOrientation in descriptor.supportedInterfaceOrientationsArray) {
        if (anInterfaceOrientation.integerValue == interfaceOrientation) {
            viewControllerSupportsOrientation = YES;
            break;
        }
    }
    return viewControllerSupportsOrientation;
}
- (BOOL) view:(IRView *)irView supportsOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    BOOL viewSupportsOrientation = NO;
    IRViewDescriptor *descriptor = irView.descriptor;
    for (NSNumber *anInterfaceOrientation in descriptor.restrictToOrientationsArray) {
        if (anInterfaceOrientation.integerValue == interfaceOrientation) {
            viewSupportsOrientation = YES;
            break;
        }
    }
    return viewSupportsOrientation;
}
- (void) updateViewWithOrientation:(UIInterfaceOrientation)orientation
                          animated:(BOOL)animated
                          duration:(NSTimeInterval)duration
{
    if (animated) {
        [UIView animateWithDuration:duration
                         animations:^{
                             for (IRView *irView in self.viewsArrayForOrientationRestriction) {
                                 if ([self view:irView supportsOrientation:orientation]) {
                                     irView.hidden = NO;
                                 } else {
                                     irView.hidden = YES;
                                 }
                             }
                         }];
    } else {
        for (IRView *irView in self.viewsArrayForOrientationRestriction) {
            if ([self view:irView supportsOrientation:orientation]) {
                irView.hidden = NO;
            } else {
                irView.hidden = YES;
            }
        }
    }
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

// INFO:
//      - number of levels is limited because of JavaScriptCore bug - nested "call" methods
//      - in future ,when bug is resolved, this limit should be removed
//      - more information:
//          - http://dev.clojure.org/jira/browse/CLJS-910
//          - http://stackoverflow.com/questions/27568249/javascriptcore-nested-call-performance-issue
- (void) addWatchMethodToJSValueWithName:(NSString *)name
                          numberOfLevels:(NSNumber *)numberOfLevels
{
    JSContext *jsContext;
    if (self.jsValueNamesWatchForDataBindingArray == nil) {
        self.jsValueNamesWatchForDataBindingArray = [NSMutableArray array];
    }
    if ([self.jsValueNamesWatchForDataBindingArray containsObject:name] == NO) {
//        NSLog(@"addWatcher: -VC=%@, -property=%@", self.key, name);

        [self.jsValueNamesWatchForDataBindingArray addObject:name];

        jsContext = [IRDataController sharedInstance].globalJSContext;
        NSString *method = [NSString stringWithFormat:@
#if ENABLE_SAFARI_DEBUGGING == 1
                                                        "setZeroTimeout( function() { "
#endif
                                                            "watch(%@, '%@', IR.watchJSCallback, 0); "
                                                            "callWatchers(%@, '%@');"
#if ENABLE_SAFARI_DEBUGGING == 1
                                                        " } );"
#endif
                                                        , self.key, name, self.key, name];
        [jsContext evaluateScript:method];
    }
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
- (void) pushVCFromScreenDescriptor:(IRScreenDescriptor *)screenDescriptor animated:(BOOL)animated withData:(id)data
{
    IRViewController *viewController;
    IRViewControllerDescriptor *descriptor;
    if (screenDescriptor) {
        descriptor = screenDescriptor.viewControllerDescriptor;
        // -- backIndicatorNoText
        if (descriptor.navigationController.backIndicatorNoText) {
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                                     style:UIBarButtonItemStylePlain
                                                                                    target:nil action:nil];
        }

        viewController = [IRViewControllerBuilder buildViewControllerFromScreenDescriptor:screenDescriptor
                                                                                     data:data];
        [self.navigationController pushViewController:viewController animated:animated];
    }
}
// --------------------------------------------------------------------------------------------------------------------
- (void) presentVCFromScreenDescriptor:(IRScreenDescriptor *)screenDescriptor animated:(BOOL)animated withData:(id)data
{
    IRViewController *viewController;
    if (screenDescriptor) {
        // -- set data and ui
        viewController = [IRViewControllerBuilder buildViewControllerFromScreenDescriptor:screenDescriptor
                                                                                     data:data];
        // -- wrap if needed
        viewController = [IRViewControllerBuilder wrapInTabBarControllerAndNavigationControllerAndSideMenuIfNeeded:viewController];
        [self presentViewController:viewController animated:animated completion:nil];
    }

}
// --------------------------------------------------------------------------------------------------------------------
- (void) callJSEquivalentMethod:(NSString *)methodName
                      arguments:(NSArray *)arguments
{
    JSContext *jsContext = [[IRDataController sharedInstance] globalJSContext];
    JSValue *irViewControllerJSValue = jsContext[self.key];
    NSArray *methodNamePartsArray = [methodName componentsSeparatedByString:@":"];
    NSString *methodNameJSEquivalent = @"";
    NSString *methodNamePart;
    NSString *wrapperMethod;
    for (int i=0; i<[methodNamePartsArray count]; i++) {
        methodNamePart = methodNamePartsArray[i];
        if ([methodNamePart length] > 0) {
            if (i > 0) {
                methodNamePart = [NSString stringWithFormat:@"%@%@",
                                                            [[methodNamePart substringToIndex:1] capitalizedString],
                                                            [methodNamePart substringFromIndex:1]];
            }
            methodNameJSEquivalent = [methodNameJSEquivalent stringByAppendingString:methodNamePart];
        }
    }
    JSValue *method = irViewControllerJSValue[methodNameJSEquivalent];
    if ([method isObject]
        && [[method toObject] isKindOfClass:[NSDictionary class]]
        && [[method toString] hasPrefix:@"function"])
    {
//        NSLog(@"implements VC-equivalent js-method: '%@'", methodName);
#if ENABLE_SAFARI_DEBUGGING == 1
        wrapperMethod = [NSString stringWithFormat:@
                                                     "%@_%@ = function() { "
                                                     "    setZeroTimeout( %@.%@.bind(%@, arguments) ) "
                                                     "}"
                                                    , methodNameJSEquivalent, self.key,
                                  self.key, methodNameJSEquivalent, self.key];
        JSValue *wrapperMethodJSValue = [jsContext evaluateScript:wrapperMethod];
        [wrapperMethodJSValue callWithArguments:arguments];
#else
        [method callWithArguments:arguments];
#endif
    }
}
// --------------------------------------------------------------------------------------------------------------------
- (void) unregisterViewControllerAndItsNavigationStack:(IRViewController *)viewController
{
    if (viewController.navigationController) {
        NSArray *viewControllers = viewController.navigationController.viewControllers;
        for (IRViewController *anVC in viewControllers) {
//            NSLog(@"unregisterViewControllerAndItsNavigationStack - unregisterViewController - key:%@", anVC.key);
            [[IRDataController sharedInstance] unregisterViewController:anVC];
        }
    } else {
//        NSLog(@"unregisterViewControllerAndItsNavigationStack - unregisterViewController - key:%@", viewController.key);
        [[IRDataController sharedInstance] unregisterViewController:viewController];
    }
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc. that aren't in use.
    NSLog(@"IRViewController - didReceiveMemoryWarning - key:%@", self.key);
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - dealloc

- (void) dealloc
{
    // IMPORTANT: key in 'dealloc' is with VC-id (prefix is 'VC__id__'), not SCREEN-id
//    NSLog(@"IRViewController - dealloc - key:%@", self.key);

    // IMPORTANT: leave line below as commented
    // [super dealloc]; // (provided by the compiler)
}

@end