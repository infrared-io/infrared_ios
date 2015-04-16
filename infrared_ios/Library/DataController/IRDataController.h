//
// Created by Uros Milivojevic on 10/5/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define JS_DEBUG 1

@class IRAppDescriptor;
@class IRViewController;
@class JSContext;
@class IRView;
@protocol IRComponentInfoProtocol;
@class IRScreenDescriptor;
@class IRLayoutConstraintDescriptor;
@class IRLayoutConstraintMetricsDescriptor;

@class IRGestureRecognizerDescriptor;
@class IRBaseDescriptor;

@interface IRDataController : NSObject <UIWebViewDelegate>

@property (nonatomic, strong) IRAppDescriptor *appDescriptor;

@property (nonatomic, strong) NSDictionary *i18n;

@property (nonatomic, strong) NSMutableArray *librariesArray;
@property (nonatomic, strong) NSMutableArray *viewControllersArray;

@property (nonatomic, strong) NSMutableArray *idsAndViewsPerScreenArray;
@property (nonatomic, strong) NSMutableDictionary *globalLayoutConstraintMetricsDictionary;
@property (nonatomic, strong) NSMutableArray *idsAndGestureRecognizersPerScreenArray;

@property (nonatomic) BOOL checkForNewAppDescriptorSource;

+ (IRDataController *)sharedInstance;

- (void) cleanData;

- (void) registerComponent:(Class)baseDescriptorClass;
- (Class)componentDescriptorClassByName:(NSString *)componentName;
- (void) addComponentConstructorsToJSContext:(JSContext *)context;

- (IRViewController *) mainScreenViewController;
- (NSString *) mainScreenViewControllerId;

- (IRScreenDescriptor *) screenDescriptorWithId:(NSString *)screenId;
- (IRScreenDescriptor *) screenDescriptorWithControllerId:(NSString *)viewControllerId;

- (NSString *) screenIdForControllerId:(NSString *)controllerId;
- (NSString *) controllerIdForScreenId:(NSString *)screenId;

- (void) initJSContext;
- (JSContext *) globalJSContext;
- (JSContext *) vcPluginExtensionJSContext;

- (void) registerViewController:(id <IRComponentInfoProtocol>)component;
- (void) unregisterViewController:(IRViewController *)viewController;

- (void) registerView:(id <IRComponentInfoProtocol>)component
       viewController:(IRViewController *)viewController;
- (void) registerGlobalLayoutConstraintMetrics:(IRLayoutConstraintMetricsDescriptor *)descriptor;

- (void) registerGestureRecognizer:(id <IRComponentInfoProtocol>)component
                    viewController:(IRViewController *)viewController;

- (void) registerViewsArray:(NSArray *)viewsArray
   inSameScreenAsParentView:(id<IRComponentInfoProtocol>)parentView;
- (void)    registerView:(id <IRComponentInfoProtocol>)irView
inSameScreenAsParentView:(id<IRComponentInfoProtocol>)parentView;
- (void) unregisterView:(id<IRComponentInfoProtocol>)irView;

- (IRView *) viewWithId:(NSString *)viewId
         viewController:(IRViewController *)viewController;

- (NSArray *) controllersWithId:(NSString *)controllerId;

- (UIGestureRecognizer *) gestureRecognizerWithId:(NSString *)gestureRecognizerId
                                   viewController:(IRViewController *)viewController;

- (IRLayoutConstraintMetricsDescriptor *) layoutConstraintMetricsWithId:(NSString *)metricsId;

- (id) objectWithId:(NSString *)objectId
             viewController:(IRViewController *)viewController
insideIdsAndComponentsArray:(NSArray *)idsAndComponentsArray;

@end