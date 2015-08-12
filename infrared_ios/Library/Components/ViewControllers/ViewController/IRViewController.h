//
// Created by Uros Milivojevic on 8/30/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <RESideMenu/RESideMenu.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "IRComponentInfoProtocol.h"
#import "UIViewControllerExport.h"

@class IRView;
@class IRScrollView;
@class IRViewController;
@class MBProgressHUD;

@protocol IRViewControllerExport <JSExport>

@property (nonatomic, strong) id data;

@property (nonatomic, strong) IRView *rootView;

@property (nonatomic, strong) NSString *jsPlugin;

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

- (void) pushViewControllerWithScreenId:(NSString *)screenId animated:(BOOL)animated;
- (void) pushViewControllerWithScreenId:(NSString *)screenId animated:(BOOL)animated withData:(id)data;
- (void) pushViewControllerWithId:(NSString *)viewControllerId animated:(BOOL)animated;
- (void) pushViewControllerWithId:(NSString *)viewControllerId animated:(BOOL)animated withData:(id)data;
- (void) popViewControllerAnimated:(BOOL)animated;
- (void) popToRootViewControllerAnimated:(BOOL)animated;

- (void) presentViewControllerWithScreenId:(NSString *)screenId animated:(BOOL)animated;
- (void) presentViewControllerWithScreenId:(NSString *)screenId animated:(BOOL)animated withData:(id)data;
- (void) presentViewControllerWithId:(NSString *)viewControllerId animated:(BOOL)animated;
- (void) presentViewControllerWithId:(NSString *)viewControllerId animated:(BOOL)animated withData:(id)data;
- (void) dismissViewControllerAnimated:(BOOL)animated;

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

- (void) buildAndSetRootViewControllerWithScreenId:(NSString *)screenId andData:(id)data;
- (void) cleanAndBuildInfraredAppFromPath:(NSString *)path withUpdateJSONPath:(NSString *)updateUIPath;

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

- (void) showAlertView:(NSString *)title
         :(NSString *)message
         :(NSString *)action
         :(NSString *)cancelTitle
         :(NSArray *)otherTitlesArray
         :(id)data;

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

- (void) showActionSheet:(NSString *)title
         :(NSString *)action
         :(NSString *)cancelTitle
         :(NSString *)destructiveTitle
         :(NSArray *)otherTitlesArray
         :(id)data;

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

- (void) copyToPasteboard:(NSString *)text;
- (NSString *) pasteFromPasteboard;

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

- (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title;
- (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title mode:(MBProgressHUDMode)mode;
- (void)dismissGlobalHUD;

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

- (IRView *) viewWithId:(NSString *)viewId;
- (void) showViewWithId:(NSString *)componentId;
- (void) hideViewWithId:(NSString *)componentId;

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

- (NSArray *) controllersWithId:(NSString *)controllerId;
- (NSArray *) controllersWithScreenId:(NSString *)screenId;

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

#pragma mark - NSUserDefaults

- (void) setUserDefaultsValue:(NSString *)value forKey:(NSString *)key;
- (NSString *) userDefaultsValueForKey:(NSString *)key;
- (void) removeDefaultsValueForKey:(NSString *)key;
- (void) setUserDefaultsValue:(NSString *)value forKey:(NSString *)key withSuitedName:(NSString *)name;
- (NSString *) userDefaultsValueForKey:(NSString *)key withSuitedName:(NSString *)name;
- (void) removeDefaultsValueForKey:(NSString *)key withSuitedName:(NSString *)name;

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

#pragma mark - Keychain

- (void) setKeychainPassword:(NSString *)password
                      forKey:(NSString *)key
                  andAccount:(NSString *)account;
- (NSString *) keychainPasswordForKey:(NSString *)key
                           andAccount:(NSString *)account;
- (void) removeKeychainPasswordForKey:(NSString *)key
                           andAccount:(NSString *)account;

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

- (void) updateComponentsWithDataBindingKey:(NSString *)dataBindingKey;

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

- (NSString *) key;

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

- (void) watchJSCallbackToObjC:(id)prop :(id)action :(id)newValue :(id)oldValue;

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

#pragma mark - RESideMenu

- (void)presentLeftMenuViewController:(id)sender;
- (void)presentRightMenuViewController:(id)sender;

- (void)hideMenuViewController;
- (void)setContentViewControllerWithScreenId:(NSString *)screenId animated:(BOOL)animated;

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRViewController : UIViewController <IRComponentInfoProtocol, UIViewControllerExport, IRViewControllerExport, RESideMenuDelegate, UIActionSheetDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *viewsArrayForOrientationRestriction;
@property (nonatomic, strong) NSMutableArray *viewsArrayForKeyboardResize;
@property (nonatomic, strong) NSMutableDictionary *imageLoadingDataDictionary;

@property (nonatomic) BOOL shouldUnregisterVC;
@property (nonatomic) BOOL shouldUnregisterVCStack;

//@property (nonatomic, strong) JSContext *pluginInjectionJsContext;

- (void) keyPathUpdatedInReactiveCocoa:(NSString *)keyPath
                        newStringValue:(NSString *)newStringValue;

- (void) addViewForOrientationRestriction:(IRView *)irView;

- (void) addViewForKeyboardResize:(IRView *)aView
                 bottomConstraint:(NSLayoutConstraint *)constraint;

- (void) cleanWatchJSObserversAndVC;

//void runOnMainQueueWithoutDeadlocking(void (^block)(void));

@end