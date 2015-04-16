//
// Created by Uros Milivojevic on 3/10/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol UIApplicationExport <JSExport>

+ (UIApplication *)sharedApplication NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.");

@property(nonatomic,assign) id<UIApplicationDelegate> delegate;

- (void)beginIgnoringInteractionEvents NS_EXTENSION_UNAVAILABLE_IOS("");               // nested. set should be set during animations & transitions to ignore touch and other events
- (void)endIgnoringInteractionEvents NS_EXTENSION_UNAVAILABLE_IOS("");
- (BOOL)isIgnoringInteractionEvents;                  // returns YES if we are at least one deep in ignoring events

@property(nonatomic,getter=isIdleTimerDisabled)       BOOL idleTimerDisabled;	  // default is NO

- (BOOL)openURL:(NSURL*)url NS_EXTENSION_UNAVAILABLE_IOS("");
- (BOOL)canOpenURL:(NSURL *)url NS_AVAILABLE_IOS(3_0);

- (void)sendEvent:(UIEvent *)event;

@property(nonatomic,readonly) UIWindow *keyWindow;
@property(nonatomic,readonly) NSArray  *windows;

- (BOOL)sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event;

@property(nonatomic,getter=isNetworkActivityIndicatorVisible) BOOL networkActivityIndicatorVisible; // showing network spinning gear in status bar. default is NO

// Setting the statusBarStyle does nothing if your application is using the default UIViewController-based status bar system.
@property(nonatomic) UIStatusBarStyle statusBarStyle; // default is UIStatusBarStyleDefault
- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle animated:(BOOL)animated;

// Setting statusBarHidden does nothing if your application is using the default UIViewController-based status bar system.
@property(nonatomic,getter=isStatusBarHidden) BOOL statusBarHidden;
- (void)setStatusBarHidden:(BOOL)hidden withAnimation:(UIStatusBarAnimation)animation NS_AVAILABLE_IOS(3_2);

// Rotate to a specific orientation.  This only rotates the status bar and updates the statusBarOrientation property.
// This does not change automatically if the device changes orientation.
// Explicit setting of the status bar orientation is more limited in iOS 6.0 and later.
@property(nonatomic) UIInterfaceOrientation statusBarOrientation;
- (void)setStatusBarOrientation:(UIInterfaceOrientation)interfaceOrientation animated:(BOOL)animated;

// The system only calls this method if the application delegate has not
// implemented the delegate equivalent. It returns the orientations specified by
// the application's info.plist. If no supported interface orientations were
// specified it will return UIInterfaceOrientationMaskAll on an iPad and
// UIInterfaceOrientationMaskAllButUpsideDown on a phone.  The return value
// should be one of the UIInterfaceOrientationMask values which indicates the
// orientations supported by this application.
- (NSUInteger)supportedInterfaceOrientationsForWindow:(UIWindow *)window NS_AVAILABLE_IOS(6_0);

@property(nonatomic,readonly) NSTimeInterval statusBarOrientationAnimationDuration; // Returns the animation duration for the status bar during a 90 degree orientation change.  It should be doubled for a 180 degree orientation change.
@property(nonatomic,readonly) CGRect statusBarFrame; // returns CGRectZero if the status bar is hidden

@property(nonatomic) NSInteger applicationIconBadgeNumber;  // set to 0 to hide. default is 0. In iOS 8.0 and later, your application must register for user notifications using -[UIApplication registerUserNotificationSettings:] before being able to set the icon badge.

@property(nonatomic) BOOL applicationSupportsShakeToEdit NS_AVAILABLE_IOS(3_0);

@property(nonatomic,readonly) UIApplicationState applicationState NS_AVAILABLE_IOS(4_0);
@property(nonatomic,readonly) NSTimeInterval backgroundTimeRemaining NS_AVAILABLE_IOS(4_0);

- (UIBackgroundTaskIdentifier)beginBackgroundTaskWithExpirationHandler:(void(^)(void))handler  NS_AVAILABLE_IOS(4_0);
- (UIBackgroundTaskIdentifier)beginBackgroundTaskWithName:(NSString *)taskName expirationHandler:(void(^)(void))handler NS_AVAILABLE_IOS(7_0);
- (void)endBackgroundTask:(UIBackgroundTaskIdentifier)identifier NS_AVAILABLE_IOS(4_0);

/*! The system guarantees that it will not wake up your application for a background fetch more
    frequently than the interval provided. Set to UIApplicationBackgroundFetchIntervalMinimum to be
    woken as frequently as the system desires, or to UIApplicationBackgroundFetchIntervalNever (the
    default) to never be woken for a background fetch.

    This setter will have no effect unless your application has the "fetch"
    UIBackgroundMode. See the UIApplicationDelegate method
    `application:performFetchWithCompletionHandler:` for more. */
- (void)setMinimumBackgroundFetchInterval:(NSTimeInterval)minimumBackgroundFetchInterval NS_AVAILABLE_IOS(7_0);

/*! When background refresh is available for an application, it may launched or resumed in the background to handle significant
    location changes, remote notifications, background fetches, etc. Observe UIApplicationBackgroundRefreshStatusDidChangeNotification to
    be notified of changes. */
@property (nonatomic, readonly) UIBackgroundRefreshStatus backgroundRefreshStatus NS_AVAILABLE_IOS(7_0);

- (BOOL)setKeepAliveTimeout:(NSTimeInterval)timeout handler:(void(^)(void))keepAliveHandler NS_AVAILABLE_IOS(4_0);
- (void)clearKeepAliveTimeout NS_AVAILABLE_IOS(4_0);

@property(nonatomic,readonly,getter=isProtectedDataAvailable) BOOL protectedDataAvailable NS_AVAILABLE_IOS(4_0);

@property(nonatomic,readonly) UIUserInterfaceLayoutDirection userInterfaceLayoutDirection NS_AVAILABLE_IOS(5_0);

// Return the size category
@property(nonatomic,readonly) NSString *preferredContentSizeCategory NS_AVAILABLE_IOS(7_0);

@end

@interface UIApplication (UIRemoteNotifications)

// Calling this will result in either application:didRegisterForRemoteNotificationsWithDeviceToken: or application:didFailToRegisterForRemoteNotificationsWithError: to be called on the application delegate. Note: these callbacks will be made only if the application has successfully registered for user notifications with registerUserNotificationSettings:, or if it is enabled for Background App Refresh.
- (void)registerForRemoteNotifications NS_AVAILABLE_IOS(8_0);

- (void)unregisterForRemoteNotifications NS_AVAILABLE_IOS(3_0);

// Returns YES if the application is currently registered for remote notifications, taking into account any systemwide settings; doesn't relate to connectivity.
- (BOOL)isRegisteredForRemoteNotifications NS_AVAILABLE_IOS(8_0);

- (void)registerForRemoteNotificationTypes:(UIRemoteNotificationType)types NS_DEPRECATED_IOS(3_0, 8_0, "Please use registerForRemoteNotifications and registerUserNotificationSettings: instead");

// Returns the enabled types, also taking into account any systemwide settings; doesn't relate to connectivity.
- (UIRemoteNotificationType)enabledRemoteNotificationTypes NS_DEPRECATED_IOS(3_0, 8_0, "Please use -[UIApplication isRegisteredForRemoteNotifications], or -[UIApplication currentUserNotificationSettings] to retrieve user-enabled remote notification and user notification settings");

// ---------------------------------------------------------------------------

#pragma mark - UILocalNotifications

- (void)presentLocalNotificationNow:(UILocalNotification *)notification NS_AVAILABLE_IOS(4_0);

- (void)scheduleLocalNotification:(UILocalNotification *)notification NS_AVAILABLE_IOS(4_0);  // copies notification
- (void)cancelLocalNotification:(UILocalNotification *)notification NS_AVAILABLE_IOS(4_0);
- (void)cancelAllLocalNotifications NS_AVAILABLE_IOS(4_0);

@property(nonatomic,copy) NSArray *scheduledLocalNotifications NS_AVAILABLE_IOS(4_0);         // setter added in iOS 4.2

// ---------------------------------------------------------------------------

#pragma mark - UIUserNotificationSettings

// Registering UIUserNotificationSettings more than once results in previous settings being overwritten.
- (void)registerUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings NS_AVAILABLE_IOS(8_0);

// Returns the enabled user notification settings, also taking into account any systemwide settings.
- (UIUserNotificationSettings *)currentUserNotificationSettings NS_AVAILABLE_IOS(8_0);

// ---------------------------------------------------------------------------

#pragma mark - UIRemoteControlEvents

- (void)beginReceivingRemoteControlEvents NS_AVAILABLE_IOS(4_0);
- (void)endReceivingRemoteControlEvents NS_AVAILABLE_IOS(4_0);

// ---------------------------------------------------------------------------

#pragma mark - UINewsstand

- (void)setNewsstandIconImage:(UIImage *)image;

// ---------------------------------------------------------------------------

#pragma mark - UIStateRestoration

// These methods are used to inform the system that state restoration is occuring asynchronously after the application
// has processed its restoration archive on launch. In the even of a crash, the system will be able to detect that it may
// have been caused by a bad restoration archive and arrange to ignore it on a subsequent application launch.
- (void)extendStateRestoration  NS_AVAILABLE_IOS(6_0);
- (void)completeStateRestoration  NS_AVAILABLE_IOS(6_0);

// Indicate the application should not use the snapshot on next launch, even if there is a valid state restoration archive.
// This should only be called from methods invoked from State Preservation, else it is ignored.
- (void)ignoreSnapshotOnNextApplicationLaunch NS_AVAILABLE_IOS(7_0);

// Register non-View/ViewController objects for state restoration so other objects can reference them within state restoration archives.
// If the object implements encode/decode, those methods will be called during save/restore.
// Obj and identifier must not be nil, or will raise UIRestorationObjectRegistrationException.
// Objects do not need to be unregistered when they are deleted, the State Restoration system will notice and stop tracking the object.
+ (void)registerObjectForStateRestoration:(id<UIStateRestoring>)object restorationIdentifier:(NSString *)restorationIdentifier NS_AVAILABLE_IOS(7_0);

@end