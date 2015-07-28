//
// Created by Uros Milivojevic on 10/5/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UPDATE_JSON_PATH            @"update.json"

@class IRAppDescriptor;
@class JSContext;
@protocol IRComponentInfoProtocol;
@class IRScreenDescriptor;
@class IRLayoutConstraintDescriptor;
@class IRLayoutConstraintMetricsDescriptor;
#if TARGET_OS_IPHONE
@class IRView;
@class IRViewController;
#endif

@class IRGestureRecognizerDescriptor;
@class IRBaseDescriptor;

@interface IRDataController : NSObject
#if TARGET_OS_IPHONE
  <UIWebViewDelegate>
#endif

@property (nonatomic, strong) IRAppDescriptor *appDescriptor;

@property (nonatomic, strong) NSDictionary *i18n;

@property (nonatomic, strong) NSMutableArray *librariesArray;
@property (nonatomic, strong) NSMutableArray *viewControllersArray;

@property (nonatomic, strong) NSMutableArray *idsAndViewsPerScreenArray;
@property (nonatomic, strong) NSMutableDictionary *globalLayoutConstraintMetricsDictionary;
@property (nonatomic, strong) NSMutableArray *idsAndGestureRecognizersPerScreenArray;

@property (nonatomic) BOOL checkForNewAppDescriptorSource;
@property (nonatomic, strong) NSString *updateJSONPath;
@property (nonatomic, strong) NSString *defaultUpdateJSONPath;

+ (IRDataController *)sharedInstance;

- (void) cleanData;

- (void) registerComponentDescriptor:(Class)baseDescriptorClass;
- (Class)componentDescriptorClassByName:(NSString *)componentName;
#if TARGET_OS_IPHONE
- (void) addComponentConstructorsToJSContext:(JSContext *)context;
- (void) addAllJSExportProtocols;
#endif

#if TARGET_OS_IPHONE
- (IRViewController *) mainScreenViewController;
#endif
- (NSString *) mainScreenViewControllerId;

- (IRScreenDescriptor *) screenDescriptorWithId:(NSString *)screenId;
- (IRScreenDescriptor *) screenDescriptorWithControllerId:(NSString *)viewControllerId;

- (NSString *) screenIdForControllerId:(NSString *)controllerId;
- (NSString *) controllerIdForScreenId:(NSString *)screenId;

#if TARGET_OS_IPHONE
- (void) initJSContext;
- (JSContext *) globalJSContext;
- (JSContext *) vcPluginExtensionJSContext;
#endif

#if TARGET_OS_IPHONE
- (void) registerViewController:(id <IRComponentInfoProtocol>)component;
- (void) unregisterViewController:(IRViewController *)viewController;
#endif

#if TARGET_OS_IPHONE
- (void) registerView:(id <IRComponentInfoProtocol>)component
       viewController:(IRViewController *)viewController;
#endif
- (void) registerGlobalLayoutConstraintMetrics:(IRLayoutConstraintMetricsDescriptor *)descriptor;

#if TARGET_OS_IPHONE
- (void) registerGestureRecognizer:(id <IRComponentInfoProtocol>)component
                    viewController:(IRViewController *)viewController;
#endif

#if TARGET_OS_IPHONE
- (void) registerViewsArray:(NSArray *)viewsArray
   inSameScreenAsParentView:(id<IRComponentInfoProtocol>)parentView;
- (void)    registerView:(id <IRComponentInfoProtocol>)irView
inSameScreenAsParentView:(id<IRComponentInfoProtocol>)parentView;
- (void) unregisterView:(id<IRComponentInfoProtocol>)irView;

- (IRView *) viewWithId:(NSString *)viewId
         viewController:(IRViewController *)viewController;
#endif

#if TARGET_OS_IPHONE
- (NSArray *) controllersWithId:(NSString *)controllerId;

- (IRViewController *) controllerWithKey:(NSString *)vcKey;
#endif

#if TARGET_OS_IPHONE
- (UIGestureRecognizer *) gestureRecognizerWithId:(NSString *)gestureRecognizerId
                                   viewController:(IRViewController *)viewController;
#endif

- (IRLayoutConstraintMetricsDescriptor *) layoutConstraintMetricsWithId:(NSString *)metricsId;

#if TARGET_OS_IPHONE
- (id) objectWithId:(NSString *)objectId
             viewController:(IRViewController *)viewController
insideIdsAndComponentsArray:(NSArray *)idsAndComponentsArray;
#endif

@end