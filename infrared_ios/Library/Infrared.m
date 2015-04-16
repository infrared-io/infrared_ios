//
// Created by Uros Milivojevic on 8/27/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "Infrared.h"
#import "IRGlobal.h"
#import "IRInternalLibrary.h"
#import "IRView.h"
#import "IRBaseDescriptor.h"
#import "IRUtil.h"
#import "IRViewController.h"
#import "IRAppDescriptor.h"
#import "IRDataController.h"
#import "IRScreenDescriptor.h"
#import "IRBaseBuilder.h"
#import "IRViewControllerBuilder.h"
#import "IRFileLoadingUtil.h"
#import "IRViewDescriptor.h"
#import "IRLabelDescriptor.h"
#import "IRButtonDescriptor.h"
#import "IRImageViewDescriptor.h"
#import "IRScrollViewDescriptor.h"
#import "IRTextFieldDescriptor.h"
#import "IRTextViewDescriptor.h"
#import "IRSegmentedControlDescriptor.h"
#import "IRSliderDescriptor.h"
#import "IRStepperDescriptor.h"
#import "IRSwitchDescriptor.h"
#import "IRProgressViewDescriptor.h"
#import "IRToolbarDescriptor.h"
#import "IRBarButtonItemDescriptor.h"
#import "IRPageControlDescriptor.h"
#import "IRPickerViewDescriptor.h"
#import "IRDatePickerDescriptor.h"
#import "IRActivityIndicatorViewDescriptor.h"
#import "IRTableViewDescriptor.h"
#import "IRTableViewCellDescriptor.h"
#import "IRSearchBarDescriptor.h"
#import "IRNavigationBarDescriptor.h"
#import "IRNavigationItemDescriptor.h"
#import "IRMapViewDescriptor.h"
#import "IRPinAnnotationViewDescriptor.h"
#import "IRCalloutAnnotationViewDescriptor.h"
#import "IRAnnotationViewDescriptor.h"
#import "IRI18NDescriptor.h"
#import "IRSimpleCache.h"
#import <CoreText/CoreText.h>

@interface Infrared ()

@property (nonatomic, strong) NSString *appJsonPath;

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@implementation Infrared

static Infrared *sharedInfraRed = nil;

- (id) init {
    self = [super init];
    if (self) {
        [[IRDataController sharedInstance] registerComponent:[IRActivityIndicatorViewDescriptor class]];
        [[IRDataController sharedInstance] registerComponent:[IRButtonDescriptor class]];
        [[IRDataController sharedInstance] registerComponent:[IRDatePickerDescriptor class]];
        [[IRDataController sharedInstance] registerComponent:[IRImageViewDescriptor class]];
        [[IRDataController sharedInstance] registerComponent:[IRLabelDescriptor class]];
        [[IRDataController sharedInstance] registerComponent:[IRMapViewDescriptor class]];
        [[IRDataController sharedInstance] registerComponent:[IRAnnotationViewDescriptor class]];
        [[IRDataController sharedInstance] registerComponent:[IRPinAnnotationViewDescriptor class]];
        [[IRDataController sharedInstance] registerComponent:[IRCalloutAnnotationViewDescriptor class]];
        [[IRDataController sharedInstance] registerComponent:[IRNavigationBarDescriptor class]];
        [[IRDataController sharedInstance] registerComponent:[IRNavigationItemDescriptor class]];
        [[IRDataController sharedInstance] registerComponent:[IRPageControlDescriptor class]];
        [[IRDataController sharedInstance] registerComponent:[IRPickerViewDescriptor class]];
        [[IRDataController sharedInstance] registerComponent:[IRProgressViewDescriptor class]];
        [[IRDataController sharedInstance] registerComponent:[IRScrollViewDescriptor class]];
        [[IRDataController sharedInstance] registerComponent:[IRSearchBarDescriptor class]];
        [[IRDataController sharedInstance] registerComponent:[IRSegmentedControlDescriptor class]];
        [[IRDataController sharedInstance] registerComponent:[IRSliderDescriptor class]];
        [[IRDataController sharedInstance] registerComponent:[IRStepperDescriptor class]];
        [[IRDataController sharedInstance] registerComponent:[IRSwitchDescriptor class]];
        [[IRDataController sharedInstance] registerComponent:[IRTableViewDescriptor class]];
        [[IRDataController sharedInstance] registerComponent:[IRTableViewCellDescriptor class]];
        [[IRDataController sharedInstance] registerComponent:[IRTextFieldDescriptor class]];
        [[IRDataController sharedInstance] registerComponent:[IRTextViewDescriptor class]];
        [[IRDataController sharedInstance] registerComponent:[IRToolbarDescriptor class]];
        [[IRDataController sharedInstance] registerComponent:[IRBarButtonItemDescriptor class]];
        [[IRDataController sharedInstance] registerComponent:[IRViewDescriptor class]];
    }

    return self;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Public methods

- (void) buildInfraredAppFromPath:(NSString *)path
{
#ifdef DEBUG
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [NSClassFromString(@"WebView") performSelector:@selector(_enableRemoteInspector)];
#pragma clang diagnostic pop
#endif

    NSDictionary *dictionary;
    IRAppDescriptor *appDescriptor;
    NSMutableArray *failedPathsArray;
    NSArray *pathsArray;
    NSString *jsonPathComponent;

    self.appJsonPath = path;

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];

#if PREVENT_JSON_CACHE == 1
    dictionary = [IRUtil dictionaryFromPath:path];
    // -- clean cacheFolder
    [self cleanCacheFolderForApp:dictionary];
#endif

    // 1) clean and build
    dictionary = [IRUtil appDictionaryFromPath:path];
    // -- clean not used data
    [self cleanOtherLabelsCacheFolderForApp:dictionary];
    [self cleanOlderVersionsCacheFolderForApp:dictionary];
    // -- cache and load Fonts
    // ---- copy Fonts
    appDescriptor = [[IRAppDescriptor alloc] initDescriptorForFontsWithDictionary:dictionary];
    jsonPathComponent = [IRUtil resourcesPathForAppDescriptor:appDescriptor];
    pathsArray = appDescriptor.fontsArray;
    pathsArray = [self processFilePathsArray:pathsArray appDescriptor:appDescriptor];
    failedPathsArray = [NSMutableArray array];
    [IRFileLoadingUtil downloadOrCopyFilesFromPathsArray:pathsArray
                                         destinationPath:[documentsDirectory stringByAppendingPathComponent:jsonPathComponent]
                                            preserveName:YES
                                      failedLoadingPaths:failedPathsArray];
    // ---- load Fonts
    [self loadFonts:appDescriptor];
    // -- build global App descriptor
    appDescriptor = (IRAppDescriptor *) [IRBaseDescriptor newAppDescriptorWithDictionary:dictionary];
    [IRDataController sharedInstance].appDescriptor = appDescriptor;

    // 2) download and cache all images
    NSString *resourcesPathComponent = [IRUtil resourcesPathForAppDescriptor:[IRDataController sharedInstance].appDescriptor];
    NSArray *imagePathsArray = [IRBaseDescriptor allImagePaths];
    imagePathsArray = [self processFilePathsArray:imagePathsArray];
    NSMutableArray *failedImagePathsArray = [NSMutableArray array];
    [IRFileLoadingUtil downloadOrCopyFilesFromPathsArray:imagePathsArray
                                         destinationPath:[documentsDirectory stringByAppendingPathComponent:resourcesPathComponent]
                                            preserveName:NO
                                      failedLoadingPaths:failedImagePathsArray];
    // 2.1) set second cache path
    [[IRSimpleCache sharedInstance] setAdditionalCacheFolderPath:[documentsDirectory stringByAppendingPathComponent:resourcesPathComponent]];

    // 3) download and cache JS files
    jsonPathComponent = [IRUtil jsonAndjsPathForAppDescriptor:[IRDataController sharedInstance].appDescriptor];
    // 3.1)  watch.js and infrared.js
    pathsArray = @[@"infrared.js", @"zeroTimeout.js", @"watch.js"];
    failedPathsArray = [NSMutableArray array];
    [IRFileLoadingUtil downloadOrCopyFilesFromPathsArray:pathsArray
                                         destinationPath:[documentsDirectory stringByAppendingPathComponent:jsonPathComponent]
                                            preserveName:YES
                                      failedLoadingPaths:failedPathsArray];
    // 3.2) all JSPlugin files
    pathsArray = [IRBaseDescriptor allJSFilesPaths];
    pathsArray = [self processFilePathsArray:pathsArray];
    failedPathsArray = [NSMutableArray array];
    [IRFileLoadingUtil downloadOrCopyFilesFromPathsArray:pathsArray
                                         destinationPath:[documentsDirectory stringByAppendingPathComponent:jsonPathComponent]
                                            preserveName:YES
                                      failedLoadingPaths:failedPathsArray];
    // 3.3) all JSLibrary files
    pathsArray = [IRDataController sharedInstance].appDescriptor.jsLibrariesArray;
    pathsArray = [self processFilePathsArray:pathsArray];
    failedPathsArray = [NSMutableArray array];
    [IRFileLoadingUtil downloadOrCopyFilesFromPathsArray:pathsArray
                                         destinationPath:[documentsDirectory stringByAppendingPathComponent:jsonPathComponent]
                                            preserveName:YES
                                      failedLoadingPaths:failedPathsArray];
    // 3.4) all I18N files
    pathsArray = [[IRDataController sharedInstance].appDescriptor.i18n.languagesArray allValues];
    pathsArray = [self processFilePathsArray:pathsArray];
    failedPathsArray = [NSMutableArray array];
    [IRFileLoadingUtil downloadOrCopyFilesFromPathsArray:pathsArray
                                         destinationPath:[documentsDirectory stringByAppendingPathComponent:jsonPathComponent]
                                            preserveName:YES
                                      failedLoadingPaths:failedPathsArray];

      // 4) create JSContext from UIWebView
    [[IRDataController sharedInstance] initJSContext];

    // 5) check for updated app json
    if ([IRDataController sharedInstance].checkForNewAppDescriptorSource) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [IRDataController sharedInstance].checkForNewAppDescriptorSource = NO;

            NSDictionary *dictionary = [IRUtil dictionaryFromPath:path];
            IRAppDescriptor *appDescriptor = [[IRAppDescriptor alloc] initDescriptorForLabelAndVariantWithDictionary:dictionary];
            BOOL offerAppUpdate = NO;
            if ([[IRDataController sharedInstance].appDescriptor.label isEqualToString:appDescriptor.label] == NO
                || [IRDataController sharedInstance].appDescriptor.version < appDescriptor.version)
            {
                offerAppUpdate = YES;
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                if (offerAppUpdate) {
                    UIAlertView * alert = [[UIAlertView alloc ] initWithTitle:@"App update"
                                                                      message:@"New verison is availalbe. Would you like to update?"
                                                                     delegate:self
                                                            cancelButtonTitle:@"Cancel"
                                                            otherButtonTitles: nil];
                    [alert addButtonWithTitle:@"Update"];
                    [alert show];
                }
            });
        });
    }

    // NEXT STEP
    // - method "buildInfraredAppFromPath2ndPhase" will be called after UIWebView in IRDataController is loaded
}
// --------------------------------------------------------------------------------------------------------------------
- (void) buildInfraredAppFromPath2ndPhase
{
    // 6) register all libraries
    [IRInternalLibrary registerLibrary:[[IRDataController sharedInstance] globalJSContext]];

    // 7) add component constructors ("create" method) to globalJSContext
    [[IRDataController sharedInstance] addComponentConstructorsToJSContext:[[IRDataController sharedInstance] globalJSContext]];

    // 8) init I18N
    [self initI18NData];

    // 9) build main view-controller
    IRScreenDescriptor *mainScreenDescriptor = [[IRDataController sharedInstance].appDescriptor mainScreenDescriptor];
    [self buildViewControllerAndSetRootViewControllerScreenDescriptor:mainScreenDescriptor
                                                                 data:nil];
}
- (void) initI18NData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *jsonImagesPathComponent;
    NSData *fileData;
    NSDictionary *dictionary = nil;
    NSString *languageFilePath = [self currentLanguageFileName];
    JSContext *globalContext;
    if ([languageFilePath length] > 0) {
        // -- create path
        jsonImagesPathComponent = [IRUtil jsonAndjsPathForAppDescriptorLabel:[IRDataController sharedInstance].appDescriptor.label
                                                                     version:[IRDataController sharedInstance].appDescriptor.version];

        // -- load json and build dictionary from it
        fileData = [IRFileLoadingUtil dataForFileWithPath:languageFilePath
                                          destinationPath:[documentsDirectory stringByAppendingPathComponent:jsonImagesPathComponent]
                                             preserveName:YES];
        if (fileData) {
            dictionary = [NSJSONSerialization JSONObjectWithData:fileData
                                                         options:kNilOptions
                                                           error:nil];
        }
        if (dictionary) {
            [IRDataController sharedInstance].i18n = dictionary;
            globalContext = [IRDataController sharedInstance].globalJSContext;
            globalContext[@"i18n"] = [IRDataController sharedInstance].i18n;
        }
    }
}
- (NSString *) currentLanguageFileName
{
    NSString *currentLanguageFileName = nil;
    NSArray *preferredLocalizations = [[NSBundle mainBundle] preferredLocalizations];
    NSString *language = [preferredLocalizations objectAtIndex:0];
    IRI18NDescriptor *descriptor = [IRDataController sharedInstance].appDescriptor.i18n;
    currentLanguageFileName = descriptor.languagesArray[language];
    if (currentLanguageFileName == nil) {
        currentLanguageFileName = descriptor.languagesArray[descriptor.defaultLanguage];
    }
    return currentLanguageFileName;
}
- (void) loadFonts:(IRAppDescriptor *)appDescriptor
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *jsonImagesPathComponent = [IRUtil resourcesPathForAppDescriptor:appDescriptor];
    NSData *fontData;
    CFErrorRef error;
    CGDataProviderRef provider;
    CGFontRef font;
    CFStringRef errorDescription;
    for (NSString *anFontPath in appDescriptor.fontsArray) {
        fontData = [IRFileLoadingUtil dataForFileWithPath:anFontPath
                                          destinationPath:[documentsDirectory stringByAppendingPathComponent:jsonImagesPathComponent]
                                             preserveName:YES];
        if (fontData) {
            provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)fontData);
            font = CGFontCreateWithDataProvider(provider);
            if (! CTFontManagerRegisterGraphicsFont(font, &error)) {
                errorDescription = CFErrorCopyDescription(error);
                NSLog(@"Failed to load font: %@", errorDescription);
                CFRelease(errorDescription);
            } else {
//                NSString * newFontName = (__bridge NSString *)CGFontCopyPostScriptName(font);
//                NSLog(@"Registered font with name '%@'", newFontName);
            }
            CFRelease(font);
            CFRelease(provider);
        }
    }
}
- (void) cleanOtherLabelsCacheFolderForApp:(NSDictionary *)dictionary
{
    IRAppDescriptor *appDescriptor = [[IRAppDescriptor alloc] initDescriptorForLabelAndVariantWithDictionary:dictionary];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *irBaseDocPathComponent = [IRUtil documentsBasePathForInfrared];
    NSString *destinationPath = [documentsDirectory stringByAppendingPathComponent:irBaseDocPathComponent];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *filesArray = [fileManager contentsOfDirectoryAtPath:destinationPath error:&error];
    if (error) {
        NSLog(@"Infrared-cleanOtherLabelsCacheFolderForApp --1--: %@", [error localizedDescription]);
        return;
    }
    NSString *finalPath;
    for (NSString *lastPathComponent in filesArray) {
        if ([lastPathComponent isEqualToString:appDescriptor.label] == NO) {
            finalPath = [/*irBaseDocPathComponent*/destinationPath stringByAppendingPathComponent:lastPathComponent];
            [[NSFileManager defaultManager] removeItemAtPath:finalPath error:&error];
            if (error) {
                NSLog(@"Infrared-cleanOtherLabelsCacheFolderForApp --2--: %@", [error localizedDescription]);
            }
        }
    }
}
- (void) cleanOlderVersionsCacheFolderForApp:(NSDictionary *)dictionary
{
    IRAppDescriptor *appDescriptor;
    NSInteger version;
    appDescriptor = [[IRAppDescriptor alloc] initDescriptorForLabelAndVariantWithDictionary:dictionary];
    version = appDescriptor.version-1;
    for (; version >= 0; version--) {
        [self deleteCacheFolderForAppWithLabel:appDescriptor.label
                                       version:version];
    }
}
- (void) cleanCacheFolderForApp:(NSDictionary *)dictionary
{
    IRAppDescriptor *appDescriptor = [[IRAppDescriptor alloc] initDescriptorForLabelAndVariantWithDictionary:dictionary];
    [self deleteCacheFolderForAppWithLabel:appDescriptor.label
                                   version:appDescriptor.version];
}
// --------------------------------------------------------------------------------------------------------------------
- (void) updateCurrentInfraredApp
{
    @try {
        [self showAppUpdateUI];

        [self performSelector:@selector(cleanCacheAndRebuildAppWithPath:)
                   withObject:self.appJsonPath
                   afterDelay:0.02];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception occurred: %@, %@", exception, [exception userInfo]);
    }
}
// --------------------------------------------------------------------------------------------------------------------
- (void) cleanAndBuildInfraredAppFromPath:(NSString *)path
{
    @try {
        [self showAppLoadingUI];

        [self performSelector:@selector(cleanCacheAndRebuildAppWithPath:)
                   withObject:path
                   afterDelay:0.02];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception occurred: %@, %@", exception, [exception userInfo]);
    }
}
// --------------------------------------------------------------------------------------------------------------------
- (void) deleteCacheFolderForAppWithLabel:(NSString *)label
                                  version:(NSInteger)version
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *basePathComponent = [IRUtil basePathAppDescriptorLabel:label varion:version];
    NSString *finalPath = [documentsDirectory stringByAppendingPathComponent:basePathComponent];
    NSError *error;
    if ([[NSFileManager defaultManager] fileExistsAtPath:finalPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:finalPath error:&error];
        if (error) {
            NSLog(@"Infrared-deleteCacheFolderForAppWithLabel: %@", [error localizedDescription]);
        }
    }
}
// --------------------------------------------------------------------------------------------------------------------
- (void) buildViewControllerAndSetRootViewControllerScreenDescriptor:(IRScreenDescriptor *)screenDescriptor
                                                                data:(id)data
{
    IRViewController *rootViewController;
    id<UIApplicationDelegate> appDelegate;
    if (screenDescriptor) {
        rootViewController = [IRViewControllerBuilder buildAndWrapViewControllerFromScreenDescriptor:screenDescriptor
                                                                                                data:data];
        appDelegate = [UIApplication sharedApplication].delegate;
        @try {
            appDelegate.window.rootViewController = rootViewController;
            [appDelegate.window makeKeyAndVisible];
        }
        @catch (NSException *exception) {
            NSLog(@"Exception occurred: %@, %@", exception, [exception userInfo]);
        }
    }
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
- (NSArray *) processFilePathsArray:(NSArray *)filePathsArray
{
    return [self processFilePathsArray:filePathsArray
                         appDescriptor:[IRDataController sharedInstance].appDescriptor];
}
- (NSArray *) processFilePathsArray:(NSArray *)filePathsArray
                      appDescriptor:(IRAppDescriptor *)appDescriptor
{
    NSMutableArray *processedFilePathsArray = [[NSMutableArray alloc] init];
    NSString *processedFilePath;
    for (NSString *anFilePath in filePathsArray) {
        processedFilePath = [IRUtil prefixFilePathWithBaseUrlIfNeeded:anFilePath
                                                        appDescriptor:appDescriptor];
        [processedFilePathsArray addObject:processedFilePath];
    }

    return processedFilePathsArray;
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
- (void) registerComponent:(Class)baseDescriptorClass
{
    [[IRDataController sharedInstance] registerComponent:baseDescriptorClass];
}
// --------------------------------------------------------------------------------------------------------------------
- (IRViewController *) mainScreenViewController
{
    return [[IRDataController sharedInstance] mainScreenViewController];
}
// --------------------------------------------------------------------------------------------------------------------
- (JSContext *) contextForLibraryClass:(Class)libraryClass
{
    return [[IRDataController sharedInstance] globalJSContext];
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    NSLog(@"alertView: clickedButtonAtIndex:");
    if (buttonIndex == 1) { // "Update" selected
        [self updateCurrentInfraredApp];
    }
}

- (void) showAppUpdateUI
{
    id<UIApplicationDelegate> appDelegate = [UIApplication sharedApplication].delegate;

    appDelegate.window.rootViewController = nil;
    UILabel *label =[[UILabel alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    label.text = @"Update";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor blackColor];
    [appDelegate.window addSubview:label];
    [appDelegate.window bringSubviewToFront:label];
    [appDelegate.window makeKeyAndVisible];

    // -- clear cached data
    [[IRDataController sharedInstance] cleanData];
    // -- clear user-defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:appLabelKEY];
    [defaults removeObjectForKey:appVersionKEY];
    [defaults synchronize];
}

- (void) showAppLoadingUI
{
    id<UIApplicationDelegate> appDelegate = [UIApplication sharedApplication].delegate;
    @try {
        appDelegate.window.rootViewController = nil;
        UILabel *label =[[UILabel alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        label.text = @"Loading";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor blackColor];
        [appDelegate.window addSubview:label];
        [appDelegate.window bringSubviewToFront:label];
        [appDelegate.window makeKeyAndVisible];

        // -- clear cached data
        [[IRDataController sharedInstance] cleanData];
        // -- clear user-defaults
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:appLabelKEY];
        [defaults removeObjectForKey:appVersionKEY];
        [defaults synchronize];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception occurred: %@, %@", exception, [exception userInfo]);
    }
}

- (void) cleanCacheAndRebuildAppWithPath:(NSString *)path
{
    [self cleanCacheAndRebuildAppWithPath:path appDescriptor:[IRDataController sharedInstance].appDescriptor];
}
- (void) cleanCacheAndRebuildAppWithPath:(NSString *)path
                           appDescriptor:(IRAppDescriptor *)appDescriptor
{
    // -- clean cacheFolder
    [self deleteCacheFolderForAppWithLabel:appDescriptor.label
                                   version:appDescriptor.version];
    // -- start app building process
    [self buildInfraredAppFromPath:path];
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Singleton object methods

+ (Infrared *)sharedInstance {
    static dispatch_once_t pred;

    dispatch_once(&pred, ^{
        sharedInfraRed = [[Infrared alloc] init];
    });
    return sharedInfraRed;
}


@end