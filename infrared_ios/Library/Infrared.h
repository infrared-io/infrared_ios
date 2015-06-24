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

- (void) buildInfraredAppFromPath:(NSString *)path
    withExtraComponentDescriptors:(NSArray *)descriptorClassedArray;
- (void) buildInfraredAppFromPath:(NSString *)path;

- (void) buildInfraredAppFromPath2ndPhase;

- (void) updateCurrentInfraredApp;
- (void) updateCurrentInfraredAppWithUpdateJSONPath:(NSString *)updateUIPath;

- (void) cleanAndBuildInfraredAppFromPath:(NSString *)path;
- (void) cleanAndBuildInfraredAppFromPath:(NSString *)path withUpdateJSONPath:(NSString *)updateUIPath;

- (void) deleteCacheFolderForAppWithApp:(NSString *)app
                                version:(NSInteger)version;

- (void) buildViewControllerAndSetRootViewControllerScreenDescriptor:(IRScreenDescriptor *)screenDescriptor
                                                                data:(id)data;

- (void) registerComponentDescriptor:(Class)descriptorClass;
- (void) registerExtraComponentDescriptors:(NSArray *)descriptorClassedArray;

- (IRViewController *) mainScreenViewController;

- (JSContext *)contextForLibraryClass:(Class)libraryClass;

@end