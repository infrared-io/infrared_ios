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

typedef void (^InfraredContextReadyBlock)();


@protocol InfraredDelegate <NSObject>

@optional
- (void) willSetRootViewController;
- (void) didSetRootViewController;

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface Infrared : NSObject <UIAlertViewDelegate>

@property (nonatomic, assign) <InfraredDelegate> delegate;

@property (nonatomic, strong) NSString *appJsonPath;
@property (nonatomic) BOOL updateJsonTransitionInProgress;

+ (Infrared *)sharedInstance;

- (void) setCustomHTTPHeaderAttributes:(NSDictionary *)customHTTPHeaderAttributes;
- (void) setUpIRServerWithAccountKey:(NSString *)accountKey
                        projectKey:(NSString *)projectKey;

- (void) buildInfraredAppFromPath:(NSString *)path
        extraComponentDescriptors:(NSArray *)descriptorClassedArray
                 precacheFileName:(NSString *)precacheFileName;
- (void) buildInfraredAppFromPath:(NSString *)path
                 precacheFileName:(NSString *)precacheFileName;
- (void) buildInfraredAppFromPath:(NSString *)path
        extraComponentDescriptors:(NSArray *)descriptorClassedArray;
- (void) buildInfraredAppFromPath:(NSString *)path
        extraComponentDescriptors:(NSArray *)descriptorClassedArray
            setRootViewController:(BOOL)setRootViewController;
- (void) buildInfraredAppFromPath:(NSString *)path;
- (void) buildInfraredAppFromPath:(NSString *)path
            setRootViewController:(BOOL)setRootViewController;

- (void) buildInfraredAppFromPath2ndPhase;

- (void) updateCurrentInfraredApp;
- (void) updateCurrentInfraredAppWithUpdateJSONPath:(NSString *)updateUIPath
                                 handleContextReady:(InfraredContextReadyBlock)block;
- (void) updateCurrentInfraredAppWithUpdateJSONPath:(NSString *)updateUIPath;

- (void) cleanAndBuildInfraredAppFromPath:(NSString *)path;
- (void) cleanAndBuildInfraredAppFromPath:(NSString *)path
                       withUpdateJSONPath:(NSString *)updateUIPath
                       handleContextReady:(InfraredContextReadyBlock)block;
- (void) cleanAndBuildInfraredAppFromPath:(NSString *)path withUpdateJSONPath:(NSString *)updateUIPath;

- (void) deleteCacheFolderForAppWithApp:(NSString *)app
                                version:(long long)version;

- (void) buildViewControllerAndSetRootViewControllerScreenDescriptor:(IRScreenDescriptor *)screenDescriptor
                                                                data:(id)data;

- (void) registerComponentDescriptor:(Class)descriptorClass;
- (void) registerExtraComponentDescriptors:(NSArray *)descriptorClassedArray;

- (IRViewController *) mainScreenViewController;

- (JSContext *)contextForLibraryClass:(Class)libraryClass;

- (void) cleanCacheAndRebuildAppWithPath:(NSString *)path
                      handleContextReady:(InfraredContextReadyBlock)block;

@end