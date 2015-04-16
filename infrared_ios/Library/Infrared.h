//
// Created by Uros Milivojevic on 8/27/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@class IRViewController;
@class IRBaseDescriptor;
@class IRScreenDescriptor;


@interface Infrared : NSObject <UIAlertViewDelegate>

+ (Infrared *)sharedInstance;

- (void) buildInfraredAppFromPath:(NSString *)path;

- (void) buildInfraredAppFromPath2ndPhase;

- (void) updateCurrentInfraredApp;

- (void) cleanAndBuildInfraredAppFromPath:(NSString *)path;

- (void) deleteCacheFolderForAppWithLabel:(NSString *)label
                                  version:(NSInteger)version;

- (void) buildViewControllerAndSetRootViewControllerScreenDescriptor:(IRScreenDescriptor *)screenDescriptor
                                                                data:(id)data;

- (void) registerComponent:(Class)baseDescriptorClass;

- (IRViewController *) mainScreenViewController;

- (JSContext *)contextForLibraryClass:(Class)libraryClass;

@end