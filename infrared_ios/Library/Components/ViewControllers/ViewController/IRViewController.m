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
#import "IRBarButtonItem.h"
#import "IRBaseBuilder+DataBinding.h"
#import "IRBaseBuilder+GestureRecognizer.h"
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

    [IRBaseBuilder executeAction:@"this.viewDidLoad();"
                  withDictionary:@{}
                  viewController:self
                    functionName:@"this.viewDidLoad"];
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
    IRView *titleView;
    IRBarButtonItem *barButtonItem;
    // -- titleView
    if (descriptor.navigationController.titleView
        && (self.navigationItem.titleView == nil
            || [self.navigationItem.titleView conformsToProtocol:@protocol(IRComponentInfoProtocol)] == NO))
    {
        titleView = (id) [IRBaseBuilder buildComponentFromDescriptor:descriptor.navigationController.titleView
                                                      viewController:self
                                                               extra:nil];
        [self.navigationItem setTitleView:titleView];
        // -- add constraints
        [IRBaseBuilder addAutoLayoutConstraintsForView:titleView
                                            descriptor:titleView.descriptor
                                        viewController:self];
        // -- set data-binding
        [IRBaseBuilder addDataBindingsForView:titleView
                               viewController:self
                                 dataBindings:((IRViewDescriptor *) titleView.descriptor).dataBindingsArray];
        // -- add gesture-recognizers
        [IRBaseBuilder setRequireGestureRecognizerToFailForView:titleView
                                                 viewController:self];
    }
    // -- leftBarButtonItem
    if (descriptor.navigationController.leftBarButtonItem
        && (self.navigationItem.leftBarButtonItem == nil
            || [self.navigationItem.leftBarButtonItem conformsToProtocol:@protocol(IRComponentInfoProtocol)] == NO))
    {
        barButtonItem = (id) [IRBaseBuilder buildComponentFromDescriptor:descriptor.navigationController.leftBarButtonItem
                                                          viewController:self
                                                                   extra:nil];
        [self.navigationItem setLeftBarButtonItem:barButtonItem animated:NO];
        // -- add constraints
        [IRBaseBuilder addAutoLayoutConstraintsForView:barButtonItem.customView
                                            descriptor:((IRView *) barButtonItem.customView).descriptor
                                        viewController:self];
        // -- set data-binding
        [IRBaseBuilder addDataBindingsForView:barButtonItem
                               viewController:self
                                 dataBindings:((IRViewDescriptor *) barButtonItem.descriptor).dataBindingsArray];
        [IRBaseBuilder addDataBindingsForView:barButtonItem.customView
                               viewController:self
                                 dataBindings:((IRViewDescriptor *) ((IRView *) barButtonItem.customView).descriptor).dataBindingsArray];
        // -- add gesture-recognizers
        [IRBaseBuilder setRequireGestureRecognizerToFailForView:barButtonItem.customView
                                                 viewController:self];
    }
    // -- rightBarButtonItem
    if (descriptor.navigationController.rightBarButtonItem
        && (self.navigationItem.rightBarButtonItem == nil
            || [self.navigationItem.rightBarButtonItem conformsToProtocol:@protocol(IRComponentInfoProtocol)] == NO))
    {
        barButtonItem = (id) [IRBaseBuilder buildComponentFromDescriptor:descriptor.navigationController.rightBarButtonItem
                                                          viewController:self
                                                                   extra:nil];
        [self.navigationItem setRightBarButtonItem:barButtonItem animated:NO];
        // -- add constraints
        [IRBaseBuilder addAutoLayoutConstraintsForView:barButtonItem.customView
                                            descriptor:((IRView *) barButtonItem.customView).descriptor
                                        viewController:self];
        // -- set data-binding
        [IRBaseBuilder addDataBindingsForView:barButtonItem
                               viewController:self
                                 dataBindings:((IRViewDescriptor *) barButtonItem.descriptor).dataBindingsArray];
        [IRBaseBuilder addDataBindingsForView:barButtonItem.customView
                               viewController:self
                                 dataBindings:((IRViewDescriptor *) ((IRView *) barButtonItem.customView).descriptor).dataBindingsArray];
        // -- add gesture-recognizers
        [IRBaseBuilder setRequireGestureRecognizerToFailForView:barButtonItem.customView
                                                 viewController:self];
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
        UIImage *image = [IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.navigationController.backIndicatorImage];
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

    [IRBaseBuilder executeAction:@"this.viewWillAppear(animated);"
                  withDictionary:@{@"animated": @(animated)}
                  viewController:self
                    functionName:@"this.viewWillAppear"];
}

-(void)viewDidAppear:(BOOL)animated // Called when the view has been fully transitioned onto the screen. Default does nothing
{
    [super viewDidAppear:animated];

//    NSLog(@"%@", [[UIWindow keyWindow] _autolayoutTrace]);

    [IRBaseBuilder executeAction:@"this.viewDidAppear(animated);"
                  withDictionary:@{@"animated": @(animated)}
                  viewController:self
                    functionName:@"this.viewDidAppear"];
}

- (void)viewWillDisappear:(BOOL)animated // Called when the view is dismissed, covered or otherwise hidden. Default does nothing
{
    [super viewWillDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification
                                                  object:nil];

    [IRBaseBuilder executeAction:@"this.viewWillDisappear(animated);"
                  withDictionary:@{@"animated": @(animated)}
                  viewController:self
                    functionName:@"this.viewWillDisappear"];
}

- (void)viewDidDisappear:(BOOL)animated  // Called after the view was dismissed, covered or otherwise hidden. Default does nothing
{
    [super viewDidDisappear:animated];

    [IRBaseBuilder executeAction:@"this.viewDidDisappear(animated);"
                  withDictionary:@{@"animated": @(animated)}
                  viewController:self
                    functionName:@"this.viewDidDisappear"];

    if (self.shouldUnregisterVC) {
//        NSLog(@"viewDidDisappear - unregisterViewController - key:%@", self.key);
        [[IRDataController sharedInstance] unregisterViewController:self];
    }

    if (self.shouldUnregisterVCStack) {
//        NSLog(@"viewDidDisappear - unregisterViewController ***STACK*** - key:%@", self.key);
        [[IRDataController sharedInstance] unregisterViewControllerAndItsNavigationStack:self];
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

    NSDictionary *dictionary;
    if (parent) {
        dictionary = @{@"parent": parent};
    } else {
        dictionary = @{@"parent": [NSNull null]};
    }
    [IRBaseBuilder executeAction:@"this.willMoveToParentViewController(parent);"
                  withDictionary:dictionary
                  viewController:self
                    functionName:@"this.willMoveToParentViewController"];
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
    // TODO: method not available at the time of execution (JSContext reference cleaned before this is called)
//    NSDictionary *dictionary;
//    if (parent) {
//        dictionary = @{@"parent": parent};
//    } else {
//        dictionary = @{@"parent": [NSNull null]};
//    }
//    [IRBaseBuilder executeAction:@"this.didMoveToParentViewController(parent);"
//                  withDictionary:dictionary
//                  viewController:self
//                    functionName:@"this.didMoveToParentViewController"];
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
//    [self pushVCFromScreenDescriptor:screenDescriptor animated:animated withData:data];
    __weak IRViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf pushVCFromScreenDescriptor:screenDescriptor animated:animated withData:data];
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
//    [self pushVCFromScreenDescriptor:screenDescriptor animated:animated withData:data];
    __weak IRViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf pushVCFromScreenDescriptor:screenDescriptor animated:animated withData:data];
    });
}
// --------------------------------------------------------------------------------------------------------------------
- (void) popViewControllerAnimated:(BOOL)animated
{
    __weak IRViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.navigationController popViewControllerAnimated:animated];
    });
}
// --------------------------------------------------------------------------------------------------------------------
- (void) popToRootViewControllerAnimated:(BOOL)animated
{
    __weak IRViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.navigationController popToRootViewControllerAnimated:animated];
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
//    __weak IRViewController *weakSelf = self;
//    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentVCFromScreenDescriptor:screenDescriptor animated:animated withData:data];
//    });
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
//    __weak IRViewController *weakSelf = self;
//    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentVCFromScreenDescriptor:screenDescriptor animated:animated withData:data];
//    });
}
- (void)dismissViewControllerAnimated:(BOOL)animated
{
    __weak IRViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf dismissViewControllerAnimated:animated
                                 completion:^{
//                                     [weakSelf unregisterViewControllerAndItsNavigationStack:weakSelf];
                                     [[IRDataController sharedInstance] unregisterViewControllerAndItsNavigationStack:weakSelf];
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
- (void) cleanAndBuildInfraredAppFromPath:(NSString *)path
                       withUpdateJSONPath:(NSString *)updateUIPath
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[Infrared sharedInstance] cleanAndBuildInfraredAppFromPath:path withUpdateJSONPath:updateUIPath];
    });
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
- (void) showAlertView:(NSString *)title
         :(NSString *)message
         :(NSString *)action
         :(NSString *)cancelTitle
         :(NSArray *)otherTitlesArray
         :(id)data
{
    IRAlertView * alert = [[IRAlertView alloc ] initWithTitle:title
                                                      message:message
                                                     delegate:self
                                            cancelButtonTitle:cancelTitle
                                            otherButtonTitles:nil];
    alert.action = action;
    alert.data = data;
    alert.componentInfo = self.key;
    for (NSString* otherButtonTitle in otherTitlesArray) {
        [alert addButtonWithTitle:otherButtonTitle];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [alert show];
    });
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
- (void) showActionSheet:(NSString *)title
         :(NSString *)action
         :(NSString *)cancelTitle
         :(NSString *)destructiveTitle
         :(NSArray *)otherTitlesArray
         :(id)data
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
    actionSheet.componentInfo = self.key;
    for (NSString* otherButtonTitle in otherTitlesArray) {
        [actionSheet addButtonWithTitle:otherButtonTitle];
    }
    if (cancelTitle && [cancelTitle length] > 0 && [cancelTitle isEqualToString:@"null"] == NO) {
        [actionSheet addButtonWithTitle:cancelTitle];
        [actionSheet setCancelButtonIndex:[actionSheet numberOfButtons] - 1];
    }
    __weak IRViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [actionSheet showInView:weakSelf.view];
    });
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
- (void) copyToPasteboard:(NSString *)text
{
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    [pb setString:text];
}
- (NSString *) pasteFromPasteboard
{
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    return [pb string];
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
- (void) showViewWithId:(NSString *)componentId
{
    [[IRUtilLibrary sharedInstance] showViewWithId:componentId viewController:self];
}
- (void) hideViewWithId:(NSString *)componentId
{
    [[IRUtilLibrary sharedInstance] hideViewWithId:componentId viewController:self];
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

#pragma mark - NSUserDefaults

- (void) setUserDefaultsValue:(NSString *)value forKey:(NSString *)key
{
    [[IRUtilLibrary sharedInstance] setUserDefaultsValue:value forKey:key];
}
- (NSString *) userDefaultsValueForKey:(NSString *)key
{
    return [[IRUtilLibrary sharedInstance] userDefaultsValueForKey:key];
}
- (void) removeDefaultsValueForKey:(NSString *)key
{
    [[IRUtilLibrary sharedInstance] removeDefaultsValueForKey:key];
}
// --------------------------------------------------------------------------------------------------------------------
- (void) setUserDefaultsValue:(NSString *)value forKey:(NSString *)key withSuitedName:(NSString *)name
{
    [[IRUtilLibrary sharedInstance] setUserDefaultsValue:value forKey:key withSuitedName:name];
}
- (NSString *) userDefaultsValueForKey:(NSString *)key withSuitedName:(NSString *)name
{
    return [[IRUtilLibrary sharedInstance] userDefaultsValueForKey:key withSuitedName:name];
}
- (void) removeDefaultsValueForKey:(NSString *)key withSuitedName:(NSString *)name
{
    [[IRUtilLibrary sharedInstance] removeDefaultsValueForKey:key withSuitedName:name];
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Keychain

- (void) setKeychainPassword:(NSString *)password
                      forKey:(NSString *)key
                  andAccount:(NSString *)account
{
    [[IRUtilLibrary sharedInstance] setKeychainPassword:password forKey:key andAccount:account];
}
- (NSString *) keychainPasswordForKey:(NSString *)key
                           andAccount:(NSString *)account
{
    return [[IRUtilLibrary sharedInstance] keychainPasswordForKey:key andAccount:account];
}
- (void) removeKeychainPasswordForKey:(NSString *)key
                           andAccount:(NSString *)account
{
    [[IRUtilLibrary sharedInstance] removeKeychainPasswordForKey:key andAccount:account];
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (void) updateComponentsWithDataBindingKey:(NSString *)dataBindingKey
{
    // KVO related triggering (ReactiveCocoa uses KVO as base)
    __weak IRViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
//        [self setJsMapUsedInDataBindingForKey:dataBindingKey currentValue:nil];
        [weakSelf willChangeValueForKey:dataBindingKey];
        [weakSelf didChangeValueForKey:dataBindingKey];
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
    __weak IRViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.sideMenuViewController presentLeftMenuViewController];
    });
}

- (void)presentRightMenuViewController:(id)sender
{
    __weak IRViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.sideMenuViewController presentLeftMenuViewController];
    });
}

- (void)hideMenuViewController
{
    __weak IRViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.sideMenuViewController hideMenuViewController];
    });
}
- (void)setContentViewControllerWithScreenId:(NSString *)screenId animated:(BOOL)animated
{
    NSString *currentVCId;
    NSString *currentScreenId;
    IRScreenDescriptor *screenDescriptor;

    IRViewController *currentContentViewController = (IRViewController *) self.sideMenuViewController.contentViewController;
    // TODO: improve to support TabBar and others
    if ([currentContentViewController isKindOfClass:[IRNavigationController class]]) {
        currentContentViewController = [((IRNavigationController *) currentContentViewController).viewControllers firstObject];
    }
    currentVCId = currentContentViewController.descriptor.componentId;
    currentScreenId = [[IRDataController sharedInstance] screenIdForControllerId:currentVCId];
    if ([currentScreenId isEqualToString:screenId] == NO) {
        // -- prepare and set new VC
        screenDescriptor = [[IRDataController sharedInstance] screenDescriptorWithId:screenId];
        __weak IRViewController *weakSelf = self;
        if (screenDescriptor) {
            // -- mark old VC for clean-up
            currentContentViewController.shouldUnregisterVCStack = YES;
            // -- build new VC
//            IRViewController *contentViewController = [IRViewControllerBuilder buildViewControllerFromScreenDescriptor:screenDescriptor data:nil];
//            __weak IRViewController *weakContentViewController = contentViewController;
            dispatch_async(dispatch_get_main_queue(), ^{
                IRViewController *wrappedContentViewController;

                IRViewController *contentViewController = [IRViewControllerBuilder buildViewControllerFromScreenDescriptor:screenDescriptor data:nil];

                // -- navigation controller and tabBar controller
                // TODO: multiple tabs will leak here (additional tabs are created in wrapInTabBar...)
                wrappedContentViewController = [IRViewControllerBuilder wrapInTabBarControllerAndNavigationControllerIfNeeded:contentViewController/*weakContentViewController*/];

                // -- set delegate to content VC
                weakSelf.sideMenuViewController.delegate = contentViewController/*weakContentViewController*/;
                // -- set new wrapped content VC
                [weakSelf.sideMenuViewController setContentViewController:wrappedContentViewController animated:animated];
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
        if ([oldValue isKindOfClass:[NSArray class]]
            && [newValue isEqualToArray:oldValue])
        {
            valueChange = NO;
        }
    } else if ([newValue isKindOfClass:[NSDictionary class]]) {
        if ([oldValue isKindOfClass:[NSDictionary class]]
            && [newValue isEqualToDictionary:oldValue])
        {
            valueChange = NO;
        }
    } else if ([newValue isKindOfClass:[NSString class]]) {
        if ([oldValue isKindOfClass:[NSString class]]
            && [newValue isEqualToString:oldValue])
        {
            valueChange = NO;
        }
    } else if ([newValue isKindOfClass:[NSNumber class]]) {
        if ([oldValue isKindOfClass:[NSNumber class]]
            && [newValue isEqualToNumber:oldValue])
        {
            valueChange = NO;
        }
    }
    if (valueChange) {
//        NSLog(@"watch-ObjC-callback (value DID change): VCkey=%@, property=%@, action=%@, newValue=%@",
//          self.key, prop, action, newValue);
//        [self setJsMapUsedInDataBindingForKey:prop currentValue:newValue];

//        [self willChangeValueForKey:prop];
//        [self didChangeValueForKey:prop];
        __weak IRViewController *weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf willChangeValueForKey:prop];
            [weakSelf didChangeValueForKey:prop];
        });
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

    BOOL alreadyAdded = NO;
    for (IRKeyboardAutoResizeData *autoResizeData in self.viewsArrayForKeyboardResize) {
        if (autoResizeData.view == aView) {
            alreadyAdded = YES;
            break;
        }
    }
    if (alreadyAdded == NO) {
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
    NSString *unwatchProperties = @"";
    for (uint i = 0; i<[self.jsValueNamesWatchForDataBindingArray count]; i++) {
        propertyName = self.jsValueNamesWatchForDataBindingArray[i];
        unwatchProperties = [unwatchProperties stringByAppendingFormat:@"IR.WatchJS.unwatch(%@, '%@'); ", self.key, propertyName];
    }
    @try {
        NSString *method = [NSString stringWithFormat:@
#if ENABLE_SAFARI_DEBUGGING == 1
                                                        "setZeroTimeout( function() { "
#endif
                                                        "if (typeof %@ !== 'undefined') { "
                                                        "%@ "
                                                        "delete %@ ; "
                                                        "}"
#if ENABLE_SAFARI_DEBUGGING == 1
                                                        " } );"
#endif
          , self.key, unwatchProperties , self.key];
        [jsContext evaluateScript:method];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception occurred: %@, %@", exception, [exception userInfo]);
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
        UIEdgeInsets originalEdgeInsets;
        UIEdgeInsets contentInsets;
        CGRect frameRelativeToRoot = CGRectZero;
        CGFloat bottomPosition;
        CGFloat resizeHeight;
        NSLayoutConstraint *anConstraint;
        for (IRKeyboardAutoResizeData *keyboardAutoResizeData in self.viewsArrayForKeyboardResize) {
            anView = keyboardAutoResizeData.view;
            if (keyboardAutoResizeData.originalBottomPosition == CGFLOAT_UNDEFINED) {
                frameRelativeToRoot = [anView convertRect:anView.bounds toView:nil];
                bottomPosition = frameRelativeToRoot.origin.y + frameRelativeToRoot.size.height;

                keyboardAutoResizeData.originalBottomPosition = bottomPosition;
            } else  {
                bottomPosition = keyboardAutoResizeData.originalBottomPosition;
            }
            if (bottomPosition < self.view.frame.size.height)
            // this branch is needed if ui start with negative coordinate
            // e.g. whole UI is slided below navigationBar (starts with y = -64)
            {
                resizeHeight = height - (self.view.frame.size.height - bottomPosition);
            } else {
                resizeHeight = height;
            }
//            NSLog(@"**** show-keyboard - vc-key:%@ ,view-id:%@, frame:%@, resizeHeight:%f", self.key,
//              anView.descriptor.componentId, NSStringFromCGRect(frameRelativeToRoot), resizeHeight);
            if (resizeHeight > 0) {
                if ([anView isKindOfClass:[UIScrollView class]]) {
                    anScrollView = anView;
                    originalEdgeInsets = keyboardAutoResizeData.scrollViewOriginalEdgeInsets;
                    contentInsets = UIEdgeInsetsMake(originalEdgeInsets.top, originalEdgeInsets.left,
                                                     resizeHeight, originalEdgeInsets.right);
//                    contentInsets = UIEdgeInsetsMake(0.0, 0.0, resizeHeight, 0.0);
                    anScrollView.contentInset = contentInsets;
                    anScrollView.scrollIndicatorInsets = contentInsets;
                } else {
                    anConstraint = keyboardAutoResizeData.constraint;
//                    NSLog(@"original constraint constant: %f", anConstraint.constant);
                    anConstraint.constant = resizeHeight;
                }
            }
        }
    }

    [IRBaseBuilder executeAction:@"this.keyboardWillShow(notification);"
                  withDictionary:@{@"notification": notification}
                  viewController:self
                    functionName:@"this.keyboardWillShow"];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    if ([self.viewsArrayForKeyboardResize count] > 0) {
        IRView *anView;
        IRScrollView *anScrollView;
        NSLayoutConstraint *anConstraint;
        for (IRKeyboardAutoResizeData *keyboardAutoResizeData in self.viewsArrayForKeyboardResize) {
            anView = keyboardAutoResizeData.view;
//            NSLog(@"**** hide-keyboard - vc-key:%@ ,view:%@", self.key, anView.descriptor.componentId);
            if ([anView isKindOfClass:[UIScrollView class]]) {
                anScrollView = anView;
//                NSLog(@"   - contentInset:%@", NSStringFromUIEdgeInsets(keyboardAutoResizeData.scrollViewOriginalEdgeInsets));
                anScrollView.contentInset = keyboardAutoResizeData.scrollViewOriginalEdgeInsets;
                anScrollView.scrollIndicatorInsets = keyboardAutoResizeData.scrollViewOriginalEdgeInsets;
            } else {
                anConstraint = keyboardAutoResizeData.constraint;
                anConstraint.constant = keyboardAutoResizeData.constraintOriginalConstant;
                [anView setNeedsUpdateConstraints];
            }
            keyboardAutoResizeData.originalBottomPosition = CGFLOAT_UNDEFINED;
        }
    }

    [IRBaseBuilder executeAction:@"this.keyboardWillHide(notification);"
                  withDictionary:@{@"notification": notification}
                  viewController:self
                    functionName:@"this.keyboardWillHide"];
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
    [IRBaseBuilder executeAction:@"this.sideMenuDidRecognizePanGesture(sideMenu, recognizer);"
                  withDictionary:@{@"sideMenu": sideMenu, @"recognizer": recognizer}
                  viewController:self
                  functionName:@"this.sideMenuDidRecognizePanGesture"];
}
- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    [IRBaseBuilder executeAction:@"this.sideMenuWillShowMenuViewController(sideMenu, menuViewController);"
                  withDictionary:@{@"sideMenu": sideMenu, @"menuViewController": menuViewController}
                  viewController:self
                    functionName:@"this.sideMenuWillShowMenuViewController"];
}
- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
    [IRBaseBuilder executeAction:@"this.sideMenuDidShowMenuViewController(sideMenu, menuViewController);"
                  withDictionary:@{@"sideMenu": sideMenu, @"menuViewController": menuViewController}
                  viewController:self
                    functionName:@"this.sideMenuDidShowMenuViewController"];
}
- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
    [IRBaseBuilder executeAction:@"this.sideMenuWillHideMenuViewController(sideMenu, menuViewController);"
                  withDictionary:@{@"sideMenu": sideMenu, @"menuViewController": menuViewController}
                  viewController:self
                    functionName:@"this.sideMenuWillHideMenuViewController"];
}
- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
    [IRBaseBuilder executeAction:@"this.sideMenuDidHideMenuViewController(sideMenu, menuViewController);"
                  withDictionary:@{@"sideMenu": sideMenu, @"menuViewController": menuViewController}
                  viewController:self
                    functionName:@"this.sideMenuDidHideMenuViewController"];
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
//    if (value == nil) {
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
//    }
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
                                                            "IR.WatchJS.watch(%@, '%@', IR.watchJSCallback, 0); "
                                                            "IR.WatchJS.callWatchers(%@, '%@');"
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
//        __weak IRViewController *weakSelf = self;
//        __weak IRViewController *weakViewController = viewController;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [weakSelf.navigationController pushViewController:weakViewController animated:animated];
//        });
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
        __weak IRViewController *weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf presentViewController:viewController animated:animated completion:nil];
        });
    }
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

//    if (self.shouldUnregisterVC) {
////        NSLog(@"viewDidDisappear - unregisterViewController - key:%@", self.key);
//        [[IRDataController sharedInstance] unregisterViewController:self];
//    }
//
//    if (self.shouldUnregisterVCStack) {
////        NSLog(@"viewDidDisappear - unregisterViewController ***STACK*** - key:%@", self.key);
//        [self unregisterViewControllerAndItsNavigationStack:self];
//    }

    // Release any cached data, images, etc. that aren't in use.
    NSLog(@"IRViewController - didReceiveMemoryWarning - key:%@", self.key);
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - dealloc

- (void) dealloc
{
    // IMPORTANT: key in 'dealloc' is with VC-id (prefix is 'VC__id__'), not SCREEN-id
    NSLog(@"IRViewController - dealloc - key:%@", self.key);

    // IMPORTANT: leave line below as commented
    // [super dealloc]; // (provided by the compiler)
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------


//void runOnMainQueueWithoutDeadlocking(void (^block)(void))
//{
//    if ([NSThread isMainThread])
//    {
//        block();
//    }
//    else
//    {
//        dispatch_async(dispatch_get_main_queue(), block);
//    }
//}

@end