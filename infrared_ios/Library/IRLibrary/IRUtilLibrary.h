//
// Created by Uros Milivojevic on 8/27/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "IRBaseLibrary.h"

@class IRView;
@class IRViewController;

@protocol IRInternalLibraryExport <JSExport>

- (IRView *) viewWithId:(NSString *)viewId
         viewController:(IRViewController *)viewController;
- (NSArray *) controllersWithId:(NSString *)controllerId;
- (NSArray *) controllersWithScreenId:(NSString *)screenId;

- (void) showViewWithId:(NSString *)componentId
         viewController:(IRViewController *)viewController;

- (void) hideViewWithId:(NSString *)componentId
         viewController:(IRViewController *)viewController;

- (NSString *) prefixFilePathWithBaseUrlIfNeeded:(NSString *)filePath;

- (void) setUserDefaultsValue:(NSString *)value forKey:(NSString *)key;
- (NSString *) userDefaultsValueForKey:(NSString *)key;
- (void) removeDefaultsValueForKey:(NSString *)key;
- (void) setUserDefaultsValue:(NSString *)value forKey:(NSString *)key withSuitedName:(NSString *)name;
- (NSString *) userDefaultsValueForKey:(NSString *)key withSuitedName:(NSString *)name;
- (void) removeDefaultsValueForKey:(NSString *)key withSuitedName:(NSString *)name;

- (void) setKeychainPassword:(NSString *)password
                      forKey:(NSString *)key
                  andAccount:(NSString *)account;
- (NSString *) keychainPasswordForKey:(NSString *)key
                           andAccount:(NSString *)account;
- (void) removeKeychainPasswordForKey:(NSString *)key
                           andAccount:(NSString *)account;

- (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title;
- (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title mode:(MBProgressHUDMode)mode;
- (void)dismissGlobalHUD;

@end

@interface IRUtilLibrary : IRBaseLibrary <IRInternalLibraryExport>

+ (IRUtilLibrary *)sharedInstance;

@end