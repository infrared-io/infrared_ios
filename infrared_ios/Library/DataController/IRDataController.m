//
// Created by Uros Milivojevic on 10/5/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRDataController.h"
#import "IRAppDescriptor.h"
#import "IRViewController.h"
#import "IRScreenDescriptor.h"
#import "IRView.h"
#import "IRIdsAndComponentsForScreen.h"
#import "IRLayoutConstraintMetricsDescriptor.h"
#import "IRJSContextUtil.h"
#import "IRBaseDescriptor.h"
#import "IRViewDescriptor.h"
#import "IRUtil.h"
#import "Infrared.h"
#import "IRInternalLibrary.h"

@interface IRDataController ()

@property(nonatomic, strong) NSMutableDictionary *componentsDictionary;

//@property(nonatomic, strong) JSVirtualMachine *jsVirtualMachine;
@property(nonatomic, strong) JSContext *jsContext;

@property(nonatomic, strong) UIWebView *webView;

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

- (void) registerComponent:(Class)baseDescriptorClass
{
    NSString *componentName;
    if ([baseDescriptorClass respondsToSelector:@selector(componentName)]) {
        componentName = [baseDescriptorClass componentName];
//        NSLog(@"registerComponent: componentName=%@", componentName);
        self.componentsDictionary[componentName] = baseDescriptorClass;
    }
}

- (Class) componentDescriptorClassByName:(NSString *)componentName
{
    Class baseDescriptor = self.componentsDictionary[componentName];
    return baseDescriptor;
}

- (void) addComponentConstructorsToJSContext:(JSContext *)context
{
    NSString *capitalizedName;
    Class descriptorClass;
    for (NSString *componentName in self.componentsDictionary) {
        capitalizedName = [NSString stringWithFormat:@"%@%@",
                                    [[componentName substringToIndex:1] capitalizedString],
                                    [componentName substringFromIndex:1]];
        descriptorClass = self.componentsDictionary[componentName];
        context[[IRInternalLibrary parent]][capitalizedName] = [descriptorClass componentClass];
    }
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

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
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *jsonImagesPathComponent = [IRUtil jsonAndjsPathForAppDescriptor:[IRDataController sharedInstance].appDescriptor];
    NSString *fullBaseUrlPath = [documentsDirectory stringByAppendingPathComponent:jsonImagesPathComponent];

    NSMutableArray *jsPluginPathsArray = [NSMutableArray array];
    [jsPluginPathsArray addObjectsFromArray:[IRDataController sharedInstance].appDescriptor.jsLibrariesArray];
    [jsPluginPathsArray addObjectsFromArray:[IRBaseDescriptor allJSFilesPaths]];
    NSString *jsPluginNameFromPath;
    NSString *scriptTags = @"";
    for (NSString *anPluginPath in jsPluginPathsArray) {
        if ([IRUtil isLocalFile:anPluginPath]) {
            scriptTags = [scriptTags stringByAppendingFormat:@"<script src='%@'></script>", anPluginPath];
        } else {
            jsPluginNameFromPath = [IRUtil fileNameFromPath:anPluginPath];
            scriptTags = [scriptTags stringByAppendingFormat:@"<script src='%@'></script>", jsPluginNameFromPath];
        }
    }
    [self.webView loadHTMLString:[NSString stringWithFormat:@""
                                                           "<html><head>"
                                                           "<script src='infrared.js'></script>"
                                                           "<script src='zeroTimeout.js'></script>"
                                                           "<script src='watch.js'></script>"
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

- (JSContext *) vcPluginExtensionJSContext
{
//    JSContext *temporaryJSContext = [[JSContext alloc] initWithVirtualMachine:self.jsVirtualMachine];
    JSContext *temporaryJSContext = [[JSContext alloc] init];
//    [IRJSContextUtil addConsoleNSLogToJSContext:temporaryJSContext];
    [IRJSContextUtil addInfraredJSExtensionToJSContext:temporaryJSContext];
    return temporaryJSContext;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - UIWebViewDelegate

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
    [IRJSContextUtil exposeUIColor:self.jsContext];
    [IRJSContextUtil exposeUIImage:self.jsContext];
    [IRJSContextUtil exposeUINavigationItem:self.jsContext];
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

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (void) registerViewController:(id <IRComponentInfoProtocol>)component
{
    if ([self.viewControllersArray containsObject:component] == NO) {
        [self.viewControllersArray addObject:component];
    }
}
- (void) unregisterViewController:(IRViewController *)viewController
{
    NSString *vcAddress = viewController.key;

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

    // 2) remove all gesture recognizers from viewController
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

    // 3) remove from viewControllersArray
    [self.viewControllersArray removeObject:viewController];

    // 4) clean Watch.JS observers and VC
    [viewController cleanWatchJSObserversAndVC];
}

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

- (void) registerGlobalLayoutConstraintMetrics:(IRLayoutConstraintMetricsDescriptor *)descriptor
{
    if (descriptor.componentId) {
        self.globalLayoutConstraintMetricsDictionary[descriptor.componentId] = descriptor;
    }
}

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

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

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

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

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

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (UIGestureRecognizer *) gestureRecognizerWithId:(NSString *)gestureRecognizerId
                                   viewController:(IRViewController *)viewController
{
    UIGestureRecognizer *gestureRecognizer = [[IRDataController sharedInstance] objectWithId:gestureRecognizerId
                                                                              viewController:viewController
                                                                 insideIdsAndComponentsArray:self.idsAndGestureRecognizersPerScreenArray];
    return gestureRecognizer;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (IRLayoutConstraintMetricsDescriptor *) layoutConstraintMetricsWithId:(NSString *)metricsId;
{
    IRLayoutConstraintMetricsDescriptor *descriptor = self.globalLayoutConstraintMetricsDictionary[metricsId];

    return descriptor;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

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