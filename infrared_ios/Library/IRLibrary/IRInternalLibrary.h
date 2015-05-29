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

- (void) showComponentWithId:(NSString *)componentId
              viewController:(IRViewController *)viewController;

- (void) hideComponentWithId:(NSString *)componentId
              viewController:(IRViewController *)viewController;

- (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title;
- (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title mode:(MBProgressHUDMode)mode;
- (void)dismissGlobalHUD;

@end

@interface IRInternalLibrary : IRBaseLibrary <IRInternalLibraryExport>

+ (IRInternalLibrary *)sharedInstance;

@end