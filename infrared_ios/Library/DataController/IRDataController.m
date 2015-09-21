//
// Created by Uros Milivojevic on 10/5/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRDataController.h"
#import "IRAppDescriptor.h"
#import "IRScreenDescriptor.h"
#import "IRIdsAndComponentsForScreen.h"
#import "IRLayoutConstraintMetricsDescriptor.h"
#import "IRBaseDescriptor.h"
#import "IRViewDescriptor.h"
#import "IRUtil.h"
#if TARGET_OS_IPHONE
#import "Infrared.h"
#import "IRUtilLibrary.h"
#import "IRJSContextUtil.h"
#import "IRView.h"
#import "IRViewController.h"
#import "IRNavigationController.h"
#import "IRTabBarController.h"
#import "IRSideMenu.h"
#endif

@interface IRDataController ()

@property(nonatomic, strong) NSMutableDictionary *componentsDictionary;

//@property(nonatomic, strong) JSVirtualMachine *jsVirtualMachine;
@property(nonatomic, strong) JSContext *jsContext;

#if TARGET_OS_IPHONE
@property(nonatomic, strong) UIWebView *webView;
#endif

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@implementation IRDataController

static IRDataController *sharedDataController = nil;

- (id) init
{
    self = [super init];
    if (self) {
        self.componentsDictionary = [NSMutableDictionary dictionary];
        self.librariesArray = [NSMutableArray array];

        self.defaultUpdateJSONPath = UPDATE_JSON_PATH;
        self.updateJSONPath = [self defaultUpdateJSONPath];

        [self cleanData];
    }
    return self;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (void) cleanData
{
    self.i18n = nil;

    self.librariesArray = [NSMutableArray array];
    self.viewControllersArray = [NSMutableArray array];

    self.idsAndViewsPerScreenArray = [NSMutableArray array];
    self.globalLayoutConstraintMetricsDictionary = [NSMutableDictionary dictionary];

    self.idsAndGestureRecognizersPerScreenArray = [NSMutableArray array];
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (void) registerComponentDescriptor:(Class)baseDescriptorClass
{
    NSString *componentName;
    if ([baseDescriptorClass respondsToSelector:@selector(componentName)]) {
        componentName = [baseDescriptorClass componentName];
//        NSLog(@"registerComponentDescriptor: componentName=%@", componentName);
        self.componentsDictionary[componentName] = baseDescriptorClass;
    }
}

- (Class) componentDescriptorClassByName:(NSString *)componentName
{
    Class baseDescriptor = self.componentsDictionary[componentName];
    return baseDescriptor;
}

#if TARGET_OS_IPHONE
- (void) addComponentConstructorsToJSContext:(JSContext *)context
{
    NSString *capitalizedName;
    Class descriptorClass;
    for (NSString *componentName in self.componentsDictionary) {
        capitalizedName = [NSString stringWithFormat:@"%@%@",
                                    [[componentName substringToIndex:1] capitalizedString],
                                    [componentName substringFromIndex:1]];
        descriptorClass = self.componentsDictionary[componentName];
        context[IR_JS_LIBRARY_KEY][capitalizedName] = [descriptorClass componentClass];
    }
}

- (void) addAllJSExportProtocols
{
    Class descriptorClass;
    for (NSString *componentName in self.componentsDictionary) {
        descriptorClass = self.componentsDictionary[componentName];
        [descriptorClass addJSExportProtocol];
    }
}
#endif

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#if TARGET_OS_IPHONE
- (IRViewController *) mainScreenViewController
{
    IRViewController *mainScreenViewController = nil;
    NSString *mainScreenViewControllerId = [self mainScreenViewControllerId];
    for (IRViewController *thViewController in self.viewControllersArray) {
        if ([thViewController.descriptor.componentId isEqualToString:mainScreenViewControllerId]) {
            mainScreenViewController = thViewController;
            break;
        }
    }
    return mainScreenViewController;
}
#endif

- (NSString *) mainScreenViewControllerId
{
    NSString *mainScreenViewControllerId = nil;
    for (IRScreenDescriptor *anDescriptor in self.appDescriptor.screensArray) {
        if ([anDescriptor.componentId isEqualToString:self.appDescriptor.mainScreenId]) {
            mainScreenViewControllerId = anDescriptor.viewControllerDescriptor.componentId;
            break;
        }
    }
    return mainScreenViewControllerId;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (IRScreenDescriptor *) screenDescriptorWithId:(NSString *)screenId
{
    IRScreenDescriptor *screen = nil;
    for (IRScreenDescriptor *anScreenDescriptor in self.appDescriptor.screensArray) {
        if ([anScreenDescriptor.componentId isEqualToString:screenId]) {
            screen = anScreenDescriptor;
            break;
        }
    }
    return screen;
}

- (IRScreenDescriptor *) screenDescriptorWithControllerId:(NSString *)viewControllerId
{
    IRScreenDescriptor *screen = nil;
    for (IRScreenDescriptor *anScreenDescriptor in self.appDescriptor.screensArray) {
        if ([anScreenDescriptor.viewControllerDescriptor.componentId isEqualToString:viewControllerId]) {
            screen = anScreenDescriptor;
            break;
        }
    }
    return screen;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (NSString *) screenIdForControllerId:(NSString *)controllerId
{
    NSString *screenId = nil;
    for (IRScreenDescriptor *anScreenDescriptor in self.appDescriptor.screensArray) {
        if ([anScreenDescriptor.viewControllerDescriptor.componentId isEqualToString:controllerId]) {
            screenId = anScreenDescriptor.componentId;
            break;
        }
    }
    return screenId;
}

- (NSString *) controllerIdForScreenId:(NSString *)screenId
{
    NSString *controllerId = nil;
    for (IRScreenDescriptor *anScreenDescriptor in self.appDescriptor.screensArray) {
        if ([anScreenDescriptor.componentId isEqualToString:screenId]) {
            controllerId = anScreenDescriptor.viewControllerDescriptor.componentId;
            break;
        }
    }
    return controllerId;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#if TARGET_OS_IPHONE
- (void) initJSContext
{
    // -- create WebView
    if (self.webView == nil) {
        self.webView = [[UIWebView alloc] init];
        self.webView.delegate = self;
    }
    // -- clean previous jsContext
    if (self.jsContext) {
        self.jsContext.exception = nil;
        self.jsContext = nil;
    }

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSString *jsonImagesPathComponent = [IRUtil jsonAndJsPathForAppDescriptor:[IRDataController sharedInstance].appDescriptor];
    NSString *fullBaseUrlPath = [documentsDirectory stringByAppendingPathComponent:jsonImagesPathComponent];

    NSArray *jsPluginPathsArray;
    NSString *anEscapedPluginPath;
    NSString *jsPluginNameFromPath;
    NSString *scriptTags = @"";
    jsPluginPathsArray = [IRDataController sharedInstance].appDescriptor.jsLibrariesArray;
    for (NSString *anPluginPath in jsPluginPathsArray) {
        anEscapedPluginPath = [anPluginPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        jsPluginNameFromPath = [IRUtil scriptTagFileNameFromPath:anEscapedPluginPath];
        scriptTags = [scriptTags stringByAppendingFormat:@"<script src='%@'></script>", jsPluginNameFromPath];
    }
    jsPluginPathsArray = [IRBaseDescriptor allJSFilesPaths];
    for (NSString *anPluginPath in jsPluginPathsArray) {
        anEscapedPluginPath = [anPluginPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        jsPluginNameFromPath = [IRUtil scriptTagFileNameFromPath:anEscapedPluginPath];
        scriptTags = [scriptTags stringByAppendingFormat:@"<script>IR.nameForFollowingPlugin('%@');</script>", jsPluginNameFromPath];
        scriptTags = [scriptTags stringByAppendingFormat:@"<script src='%@'></script>", jsPluginNameFromPath];
    }
    [self.webView loadHTMLString:[NSString stringWithFormat:@""
                                                           "<html><title>App</title><head>"
//                                                           "<script src='http://jsconsole.com/remote.js?'></script>"
                                                           "<script src='infrared.js'></script>"
                                                           "<script src='infrared_md5.min.js'></script>"
#if DEBUG == 1
                                                           "<script src='zeroTimeout.js'></script>"
                                                           "<script src='zeroTimeoutWorker.js'></script>"
#endif
                                                           "<script src='infrared_watch.js'></script>"
                                                           "%@"
                                                           "</head><body>"
                                                           "</body></html>", scriptTags]
                         baseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/", fullBaseUrlPath]]];

    // NEXT STEP
    // - method "webViewDidFinishLoad:" will be called after UIWebView is loaded
}

- (JSContext *) globalJSContext
{
    return self.jsContext;
}
#endif

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - UIWebViewDelegate

#if TARGET_OS_IPHONE
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.jsContext.exception = nil;
    self.jsContext = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    self.jsVirtualMachine = self.jsContext.virtualMachine;

    [self.jsContext setExceptionHandler:^(JSContext *context, JSValue *value) {
        NSLog(@"JSContext: --exception: %@ --value: %@", context.exception, value);
    }];
    [IRJSContextUtil exposeObjCStructureCreators:self.jsContext];
    [IRJSContextUtil exposeNSData:self.jsContext];
    [IRJSContextUtil exposeNSDate:self.jsContext];
    [IRJSContextUtil exposeUIFont:self.jsContext];
    [IRJSContextUtil exposeUIColor:self.jsContext];
    [IRJSContextUtil exposeUIImage:self.jsContext];
    [IRJSContextUtil exposeUIApplication:self.jsContext];
    [IRJSContextUtil exposeNSIndexPath:self.jsContext];
    [IRJSContextUtil exposeNSURL:self.jsContext];
    [IRJSContextUtil exposeCLLocationManager:self.jsContext];
    [IRJSContextUtil exposeMKUserLocation:self.jsContext];
    [IRJSContextUtil addConsoleNSLogToJSContext:self.jsContext];

    [[Infrared sharedInstance] buildInfraredAppFromPath2ndPhase];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Error for WEBVIEW: %@", [error description]);
}
#endif

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#if TARGET_OS_IPHONE
- (void) registerViewController:(id <IRComponentInfoProtocol>)component
{
    if ([self.viewControllersArray containsObject:component] == NO) {
        [self.viewControllersArray addObject:component];
    }
}
- (void) unregisterViewControllerAndItsNavigationStack:(IRViewController *)viewController
{
    NSArray *viewControllers = nil;
    UINavigationController *navigationController = nil;
    if ([viewController isKindOfClass:[IRNavigationController class]]) {
        viewControllers = ((IRNavigationController *)viewController).viewControllers;
    } else if ([viewController isKindOfClass:[IRViewController class]]) {
        if (viewController.navigationController) {
            navigationController = viewController.navigationController;
            viewControllers = navigationController.viewControllers;
        } else {
            viewControllers = @[viewController];
        }
    }
    // TODO: improve to recognise SideMenu, TabBar, etc. (IRI - 231)
    else if ([viewController isKindOfClass:[IRTabBarController class]])
    {
        NSLog(@"##### Memory Leak - unregisterViewControllerAndItsNavigationStack - IRTabBarController");
    }
    else if ([viewController isKindOfClass:[IRSideMenu class]])
    {
        NSLog(@"##### Memory Leak - unregisterViewControllerAndItsNavigationStack - IRSideMenu");
    }

    // Next two steps must be is current order.
    // Otherwise methods like "viewDidDisappear" would not be called in JSPlugin,
    // because VC-JSContext-reference is deleted in "unregisterViewController" (step 2)
    // -- step 1
    //    (clean VCs and initiate "willMoveToParentViewController")
    if (navigationController) {
        navigationController.viewControllers = @[];
    }
    // -- step 2
    //    (unregister VCs)
    if (viewControllers) {
        for (IRViewController *anVC in viewControllers) {
            [[IRDataController sharedInstance] unregisterViewController:anVC];
        }
    }
}
- (void) unregisterViewController:(IRViewController *)viewController
{
    NSString *vcAddress;

    if ([viewController conformsToProtocol:@protocol(IRComponentInfoProtocol)] == NO) {
        return;
    }

    vcAddress = viewController.key;

//    NSLog(@"IRDataController - unregisterViewController: %@", vcAddress);

    // 1) remove all views from viewController
    IRIdsAndComponentsForScreen *idsAndComponentsForScreen = nil;
    for (IRIdsAndComponentsForScreen *anObject in self.idsAndViewsPerScreenArray) {
        if ([anObject.viewControllerAddress isEqualToString:vcAddress]) {
            idsAndComponentsForScreen = anObject;
            break;
        }
    }
    if (idsAndComponentsForScreen) {
        [self.idsAndViewsPerScreenArray removeObject:idsAndComponentsForScreen];
    }

    // 2) unbind ReactiveCocoa DataBinding
    // NO need for it - the way it's setup things are de-allocated automatically

    // 3) remove all gesture recognizers from viewController
    IRIdsAndComponentsForScreen *idsAndGestureRecognizersForScreen = nil;
    for (IRIdsAndComponentsForScreen *anObject in self.idsAndGestureRecognizersPerScreenArray) {
        if ([anObject.viewControllerAddress isEqualToString:vcAddress]) {
            idsAndGestureRecognizersForScreen = anObject;
            break;
        }
    }
    if (idsAndGestureRecognizersForScreen) {
        [self.idsAndGestureRecognizersPerScreenArray removeObject:idsAndGestureRecognizersForScreen];
    }

    // 4) remove from viewControllersArray
    [self.viewControllersArray removeObject:viewController];

    // 5) clean Watch.JS observers and VC
    [viewController cleanWatchJSObserversAndVC];
    [self performSelector:@selector(nilJSContextVCWithName:) withObject:viewController.key afterDelay:5];

    // 6) clean views with restricted orientations
    viewController.viewsArrayForOrientationRestriction = nil;

    // 7) clean view with auto keyboard handling
    viewController.viewsArrayForKeyboardResize = nil;

    // 8) clean temp data
    viewController.data = nil;
}

- (void) nilJSContextVCWithName:(NSString *)vcName
{
//    NSLog(@"nilJSContextVCWithName: %@", vcName);

    JSContext *jsContext = [IRDataController sharedInstance].globalJSContext;
    // -- nil to release object reference
    jsContext[vcName] = nil;
    // -- delete variable in JS (to avoid leaving unused variables)
    @try {
        NSString *method = [NSString stringWithFormat:@
//#if ENABLE_SAFARI_DEBUGGING == 1
//                                                        "setZeroTimeout( function() { "
//#endif
//                                                        "if (typeof %@ !== 'undefined') { "
                                                        "delete %@;"
//                                                        "}"
//#if ENABLE_SAFARI_DEBUGGING == 1
//                                                        " } );"
//#endif
          , vcName /*, vcName*/];
        [jsContext evaluateScript:method];
    }
    @catch (NSException *exception) {
        NSLog(@"nilJSContextVCWithName - Exception occurred: %@, %@", exception, [exception userInfo]);
    }
}
#endif

#if TARGET_OS_IPHONE
- (void) registerView:(id <IRComponentInfoProtocol>)component
       viewController:(IRViewController *)viewController
{
    IRIdsAndComponentsForScreen *idsAndComponentsForScreen = nil;
    NSString *vcAddress = viewController.key;
    for (IRIdsAndComponentsForScreen *anObject in self.idsAndViewsPerScreenArray) {
        if ([anObject.viewControllerAddress isEqualToString:vcAddress]) {
            idsAndComponentsForScreen = anObject;
            break;
        }
    }
    if (idsAndComponentsForScreen == nil) {
        idsAndComponentsForScreen = [[IRIdsAndComponentsForScreen alloc] init];
        idsAndComponentsForScreen.viewControllerAddress = vcAddress;
        [self.idsAndViewsPerScreenArray addObject:idsAndComponentsForScreen];
    }
    [idsAndComponentsForScreen registerComponent:component];
}
#endif

- (void) registerGlobalLayoutConstraintMetrics:(IRLayoutConstraintMetricsDescriptor *)descriptor
{
    if (descriptor.componentId) {
        self.globalLayoutConstraintMetricsDictionary[descriptor.componentId] = descriptor;
    }
}

#if TARGET_OS_IPHONE
- (void) registerGestureRecognizer:(id <IRComponentInfoProtocol>)component
                    viewController:(IRViewController *)viewController
{
    IRIdsAndComponentsForScreen *idsAndGestureRecognizersForScreen = nil;
    NSString *vcAddress = viewController.key;
    for (IRIdsAndComponentsForScreen *anObject in self.idsAndGestureRecognizersPerScreenArray) {
        if ([anObject.viewControllerAddress isEqualToString:vcAddress]) {
            idsAndGestureRecognizersForScreen = anObject;
            break;
        }
    }
    if (idsAndGestureRecognizersForScreen == nil) {
        idsAndGestureRecognizersForScreen = [[IRIdsAndComponentsForScreen alloc] init];
        idsAndGestureRecognizersForScreen.viewControllerAddress = vcAddress;
        [self.idsAndGestureRecognizersPerScreenArray addObject:idsAndGestureRecognizersForScreen];
    }
    [idsAndGestureRecognizersForScreen registerComponent:component];
}
#endif

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#if TARGET_OS_IPHONE
- (void) registerViewsArray:(NSArray *)viewsArray
   inSameScreenAsParentView:(id<IRComponentInfoProtocol>)parentView
{
    NSMutableDictionary *viewIdAndComponents = [self viewIdAndComponentsDictionaryForView:parentView];
    [self registerViewsArray:viewsArray inViewIdAndComponentsDictionary:viewIdAndComponents];
}

- (void)    registerView:(id <IRComponentInfoProtocol>)irView
inSameScreenAsParentView:(id<IRComponentInfoProtocol>)parentView
{
    NSMutableDictionary *viewIdAndComponents = [self viewIdAndComponentsDictionaryForView:parentView];
    [self registerView:irView inViewIdAndComponentsDictionary:viewIdAndComponents];
}

- (NSMutableDictionary *) viewIdAndComponentsDictionaryForView:(id<IRComponentInfoProtocol>)irView
{
    NSMutableDictionary *viewIdAndComponents = nil;
    for (IRIdsAndComponentsForScreen *anObject in self.idsAndViewsPerScreenArray) {
        for (IRView *component in [anObject.viewIdAndComponents allValues]) {
            if (component == irView) {
                viewIdAndComponents = anObject.viewIdAndComponents;
                break;
            }
        }
        if (viewIdAndComponents) {
            break;
        }
    }
    return viewIdAndComponents;
}

- (void) registerViewsArray:(NSArray*)viewsArray
  inViewIdAndComponentsDictionary:(NSMutableDictionary *)viewIdAndComponents
{
    for (IRView *irView in viewsArray) {
        if ([irView conformsToProtocol:@protocol(IRComponentInfoProtocol)]) {
            [self registerView:irView inViewIdAndComponentsDictionary:viewIdAndComponents];
        }
    }
}

- (void) registerView:(id<IRComponentInfoProtocol>)irView
  inViewIdAndComponentsDictionary:(NSMutableDictionary *)viewIdAndComponents
{
    if (viewIdAndComponents) {
        if (viewIdAndComponents[irView.descriptor.componentId] == nil) {
            viewIdAndComponents[irView.descriptor.componentId] = irView;
        } else {
            NSLog(@"IRDataController - registerView:inSameScreenAsParentView:"
              " > Trying to register component with exsisting componentId: %@", irView.descriptor.componentId);
        }
    }

    [self registerViewsArray:((UIView *)irView).subviews inViewIdAndComponentsDictionary:viewIdAndComponents];
}

// --------------------------------------------------------------------------------------------------------------------

- (void) unregisterView:(id<IRComponentInfoProtocol>)irView
{
    NSMutableDictionary *viewIdAndComponents = [self viewIdAndComponentsDictionaryForView:irView];
    [viewIdAndComponents removeObjectForKey:irView.descriptor.componentId];
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (IRView *) viewWithId:(NSString *)viewId
         viewController:(IRViewController *)viewController
{
    IRView *view = [[IRDataController sharedInstance] objectWithId:viewId viewController:viewController
                                       insideIdsAndComponentsArray:self.idsAndViewsPerScreenArray];
    if (view == viewController.rootView) {
        view = viewController.view;
    }
    return view;
}
#endif

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#if TARGET_OS_IPHONE
- (NSArray *) controllersWithId:(NSString *)controllerId
{
    NSMutableArray *controllersArray = [NSMutableArray array];
    for (IRViewController *anViewController in self.viewControllersArray) {
        if ([anViewController.descriptor.componentId isEqualToString:controllerId]) {
            [controllersArray addObject:anViewController];
            break;
        }
    }
    return controllersArray;
}

- (IRViewController *) controllerWithKey:(NSString *)vcKey
{
    IRViewController *irViewController = nil;
    NSString *anVCKey;
    for (IRViewController *anViewController in self.viewControllersArray) {
        anVCKey = anViewController.key;
        if ([anVCKey isEqualToString:vcKey]) {
            irViewController = anViewController;
            break;
        }
    }
    return irViewController;
}
#endif

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#if TARGET_OS_IPHONE
- (UIGestureRecognizer *) gestureRecognizerWithId:(NSString *)gestureRecognizerId
                                   viewController:(IRViewController *)viewController
{
    UIGestureRecognizer *gestureRecognizer = [[IRDataController sharedInstance] objectWithId:gestureRecognizerId
                                                                              viewController:viewController
                                                                 insideIdsAndComponentsArray:self.idsAndGestureRecognizersPerScreenArray];
    return gestureRecognizer;
}
#endif

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (IRLayoutConstraintMetricsDescriptor *) layoutConstraintMetricsWithId:(NSString *)metricsId;
{
    IRLayoutConstraintMetricsDescriptor *descriptor = self.globalLayoutConstraintMetricsDictionary[metricsId];

    return descriptor;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#if TARGET_OS_IPHONE
- (id) objectWithId:(NSString *)objectId
             viewController:(IRViewController *)viewController
insideIdsAndComponentsArray:(NSArray *)idsAndComponentsArray
{
    id object = nil;
    IRIdsAndComponentsForScreen *idsAndComponentsForScreen = nil;
    NSString *vcAddress = viewController.key;
    for (IRIdsAndComponentsForScreen *anObject in idsAndComponentsArray) {
        if ([anObject.viewControllerAddress isEqualToString:vcAddress]) {
            idsAndComponentsForScreen = anObject;
            break;
        }
    }
    if (idsAndComponentsForScreen) {
        object = idsAndComponentsForScreen.viewIdAndComponents[objectId];
    }
    return object;
}
#endif

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

+ (IRDataController *) sharedInstance
{
    static dispatch_once_t pred;

    dispatch_once(&pred, ^{
        sharedDataController = [[IRDataController alloc] init];
    });
    return sharedDataController;
}

@end