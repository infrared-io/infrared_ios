//
// Created by Uros Milivojevic on 8/27/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "Infrared.h"
#import "IRGlobal.h"
#import "IRUtilLibrary.h"
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
#import "IRCollectionViewDescriptor.h"
#import "IRCollectionViewCellDescriptor.h"
#import "IRCollectionReusableViewDescriptor.h"
#import "IRWebViewDescriptor.h"
#import "Main.h"
#import "IRNavigationController.h"
#import "IRRefreshControlDescriptor.h"
#import "IRTableViewHeaderOrFooterDescriptor.h"
#import <CoreText/CoreText.h>

@interface Infrared ()

@property (nonatomic) BOOL setRootViewController;

@property (nonatomic, strong) NSString *previousAppName;

@property (nonatomic) InfraredContextReadyBlock infraredContextReadyBlock;

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@implementation Infrared

static Infrared *sharedInfraRed = nil;

- (id) init {
    self = [super init];
    if (self) {
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRViewControllerDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRActivityIndicatorViewDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRButtonDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRCollectionViewDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRCollectionViewCellDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRCollectionReusableViewDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRDatePickerDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRImageViewDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRLabelDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRMapViewDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRAnnotationViewDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRPinAnnotationViewDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRCalloutAnnotationViewDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRNavigationBarDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRNavigationItemDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRPageControlDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRPickerViewDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRProgressViewDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRRefreshControlDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRScrollViewDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRSearchBarDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRSegmentedControlDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRSliderDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRStepperDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRSwitchDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRTableViewDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRTableViewCellDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRTableViewHeaderOrFooterDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRTextFieldDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRTextViewDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRToolbarDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRBarButtonItemDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRViewDescriptor class]];
        [[IRDataController sharedInstance] registerComponentDescriptor:[IRWebViewDescriptor class]];

        self.infraredContextReadyBlock = nil;
        self.updateJsonTransitionInProgress = NO;
    }

    return self;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Public methods

- (void) setCustomHTTPHeaderAttributes:(NSDictionary *)customHTTPHeaderAttributes
{
    [IRDataController sharedInstance].customHTTPHeaderAttributesDictionary = customHTTPHeaderAttributes;
}
- (void) setUpIRServerWithAccountKey:(NSString *)accountKey
                          projectKey:(NSString *)projectKey
{
    [IRDataController sharedInstance].irServerAccountKey = accountKey;
    [IRDataController sharedInstance].irServerProjectKey = projectKey;
}
- (void) buildInfraredAppWithAccountKey:(NSString *)accountKey
                             projectKey:(NSString *)projectKey
              extraComponentDescriptors:(NSArray *)descriptorClassedArray
                  setRootViewController:(BOOL)setRootViewController
                     handleContextReady:(InfraredContextReadyBlock)block
{
    [self setUpIRServerWithAccountKey:accountKey
                           projectKey:projectKey];

    [self registerExtraComponentDescriptors:descriptorClassedArray];

    self.infraredContextReadyBlock = block;

    NSString *path = @"https://dev.infrared.io/appJson";
    [self buildInfraredAppFromPath:path setRootViewController:setRootViewController];
}
- (void) buildInfraredAppWithAccountKey:(NSString *)accountKey
                             projectKey:(NSString *)projectKey
              extraComponentDescriptors:(NSArray *)descriptorClassedArray
{
    [self buildInfraredAppWithAccountKey:accountKey projectKey:projectKey
               extraComponentDescriptors:descriptorClassedArray
                   setRootViewController:YES
                      handleContextReady:nil];
}
// --------------------------------------------------------------------------------------------------------------------
- (void) buildInfraredAppFromPath:(NSString *)path
        extraComponentDescriptors:(NSArray *)descriptorClassedArray
                 precacheFileName:(NSString *)precacheFileName
{
    NSAssert(false, @"This is not fully supported yet. Precaching does NOT work with extra components at the moment");
    [self buildInfraredAppFromPath:path
         extraComponentDescriptors:descriptorClassedArray];
}
- (void) buildInfraredAppFromPath:(NSString *)path
                 precacheFileName:(NSString *)precacheFileName
{
    // -- unzip IRPrecache
    NSString *precachePath = [[NSBundle mainBundle] pathForResource:precacheFileName ofType:@""];
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = [cachePaths firstObject];
    NSString *precacheDestinationPath = [cacheDirectory stringByAppendingPathComponent:@"Precache"];
    [Main unzipFileAtPath:precachePath
            toDestination:precacheDestinationPath];

    // -- read AppAndVersion.txt
    NSString *appAndVersionDataPath = [precacheDestinationPath stringByAppendingPathComponent:@"AppAndVersion.txt"];
    NSData *fileData = [NSData dataWithContentsOfFile:appAndVersionDataPath];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:fileData
                                                               options:kNilOptions
                                                                 error:nil];
    IRAppDescriptor *appDescriptor = [[IRAppDescriptor alloc] initDescriptorForVersionWithDictionary:dictionary];
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:APP_AND_VERSION_SUITED_NAME];
    BOOL copyPrecacheFiles = YES;
    NSString *app = [defaults objectForKey:appKEY];
    double versionDouble = [defaults doubleForKey:appVersionKEY];
    long long version = [NSNumber numberWithDouble:versionDouble].longLongValue;
    if ([app length] > 0
         && [app isEqualToString:appDescriptor.app]
         && version >= appDescriptor.version)
    {
        copyPrecacheFiles = NO;
    }
    if (copyPrecacheFiles) {
        // -- set app/value in user-defaults
        [defaults setObject:appDescriptor.app forKey:appKEY];
        [defaults setDouble:[NSNumber numberWithLongLong:appDescriptor.version].doubleValue forKey:appVersionKEY];
        [defaults synchronize];

        // -- unzip IRPrecacheData and copy to Documents dictionary
        NSArray *documentsPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [documentsPaths firstObject];
        NSString *irDocumentsDirectory = [documentsDirectory stringByAppendingPathComponent:[IRUtil documentsBasePathForInfrared]];
        NSString *precacheDataFilePath = [precacheDestinationPath stringByAppendingPathComponent:@"IRPrecacheData.zip"];
        [Main unzipFileAtPath:precacheDataFilePath
                toDestination:irDocumentsDirectory];
    }

    // -- build app
    [self buildInfraredAppFromPath:path];
}
- (void) buildInfraredAppFromPath:(NSString *)path
        extraComponentDescriptors:(NSArray *)descriptorClassedArray
{
    [self buildInfraredAppFromPath:path
         extraComponentDescriptors:descriptorClassedArray
             setRootViewController:YES];
}
- (void) buildInfraredAppFromPath:(NSString *)path
        extraComponentDescriptors:(NSArray *)descriptorClassedArray
            setRootViewController:(BOOL)setRootViewController
{
    [self registerExtraComponentDescriptors:descriptorClassedArray];
    [self buildInfraredAppFromPath:path setRootViewController:setRootViewController];
}
- (void) buildInfraredAppFromPath:(NSString *)path
{
    [self buildInfraredAppFromPath:path setRootViewController:YES];
}
- (void) buildInfraredAppFromPath:(NSString *)path
            setRootViewController:(BOOL)setRootViewController
{
    NSDictionary *dictionary;
    IRAppDescriptor *appDescriptor;
    NSMutableArray *failedPathsArray;
    NSArray *pathsArray;
    NSString *resourcesPathComponent;
    NSString *jsonPathComponent;

    self.appJsonPath = path;
    self.setRootViewController = setRootViewController;

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];

#if PREVENT_JSON_CACHE == 1
    dictionary = [IRUtil dictionaryFromPath:path];
    // -- clean cacheFolder
    [self cleanCacheFolderForApp:dictionary];
#endif

    // 1) clean and build
    dictionary = [IRUtil appDictionaryFromPath:path];
    // -- clean not used data
    [self cleanOtherAppsCacheFolderForApp:dictionary];
    [self cleanOlderVersionsCacheFolderForApp:dictionary];
    // -- check should app be silently updated
    appDescriptor = [[IRAppDescriptor alloc] initDescriptorForVersionWithDictionary:dictionary];
    if (appDescriptor.silentUpdate && [IRDataController sharedInstance].checkForNewAppDescriptorSource) {
        // -- reset check flag
        [IRDataController sharedInstance].checkForNewAppDescriptorSource = NO;
        // -- do update if needed
        BOOL offerAppUpdate = [self shouldOfferAppUpdate:path baseAppDescriptor:appDescriptor];
        if (offerAppUpdate) {
            NSLog(@"#@#@#@#@#@ Silent Update #@#@#@#@#@");
            [self cleanCacheAndRebuildAppWithPath:path];
            return;
        }
    }

    // -- descriptor for fonts and screens
    appDescriptor = [[IRAppDescriptor alloc] initDescriptorForFontsAndScreensWithDictionary:dictionary];
    // -- cache and load Fonts
    // ---- copy Fonts
    [[NSNotificationCenter defaultCenter] postNotificationName:IR_LOADING_TITLE_NOTIFICATION object:@"Fonts"];
    resourcesPathComponent = [IRUtil resourcesPathForAppDescriptor:appDescriptor];
#if DEBUG == 1
    NSLog(@"resources-path: %@", [documentsDirectory stringByAppendingPathComponent:resourcesPathComponent]);
#endif
    pathsArray = appDescriptor.fontsArray;
    pathsArray = [self processFilePathsArray:pathsArray appDescriptor:appDescriptor];
    failedPathsArray = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] postNotificationName:IR_FILES_TO_PROCESS_NOTIFICATION
                                                        object:@{IR_FILES_TO_PROCESS_COUNT:@([pathsArray count]),
                                                                 IR_FILES_TO_PROCESS_PERCENTAGE:@(10)}];
    [IRFileLoadingUtil downloadOrCopyFilesFromPathsArrayIfNeeded:pathsArray
                                                 destinationPath:[documentsDirectory stringByAppendingPathComponent:resourcesPathComponent]
                                                    preserveName:YES
                                              failedLoadingPaths:failedPathsArray];
    // ---- load Fonts
    [self loadFonts:appDescriptor];

    // -- download all screen files
    [[NSNotificationCenter defaultCenter] postNotificationName:IR_LOADING_TITLE_NOTIFICATION object:@"Screens"];
    jsonPathComponent = [IRUtil jsonAndJsPathForAppDescriptor:appDescriptor];
    pathsArray = [self screenPathsArray:appDescriptor.screensArray];
    pathsArray = [self processFilePathsArray:pathsArray appDescriptor:appDescriptor];
    failedPathsArray = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] postNotificationName:IR_FILES_TO_PROCESS_NOTIFICATION
                                                        object:@{IR_FILES_TO_PROCESS_COUNT:@([pathsArray count]),
                                                                 IR_FILES_TO_PROCESS_PERCENTAGE:@(20)}];
    [IRFileLoadingUtil downloadOrCopyFilesFromPathsArrayIfNeeded:pathsArray
                                                 destinationPath:[documentsDirectory stringByAppendingPathComponent:jsonPathComponent]
                                                    preserveName:YES
                                              failedLoadingPaths:failedPathsArray];
    // -- build complete global App descriptor
    appDescriptor = (IRAppDescriptor *) [IRBaseDescriptor newAppDescriptorWithDictionary:dictionary];
//    [IRDataController sharedInstance].appDescriptor = appDescriptor;

    // 2) download and cache all images
    [[NSNotificationCenter defaultCenter] postNotificationName:IR_LOADING_TITLE_NOTIFICATION object:@"Images"];
    resourcesPathComponent = [IRUtil resourcesPathForAppDescriptor:/*[IRDataController sharedInstance].*/appDescriptor];
    NSArray *imagePathsArray = [IRBaseDescriptor allImagePaths:appDescriptor];
    imagePathsArray = [self processFilePathsArray:imagePathsArray appDescriptor:appDescriptor];
    NSMutableArray *failedImagePathsArray = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] postNotificationName:IR_FILES_TO_PROCESS_NOTIFICATION
                                                        object:@{IR_FILES_TO_PROCESS_COUNT:@([imagePathsArray count]),
                                                                 IR_FILES_TO_PROCESS_PERCENTAGE:@(30)}];
    [IRFileLoadingUtil downloadOrCopyFilesFromPathsArrayIfNeeded:imagePathsArray
                                                 destinationPath:[documentsDirectory stringByAppendingPathComponent:resourcesPathComponent]
                                                    preserveName:NO
                                              failedLoadingPaths:failedImagePathsArray];
    // 2.1) set second cache path
    [[IRSimpleCache sharedInstance] setAdditionalCacheFolderPath:[documentsDirectory stringByAppendingPathComponent:resourcesPathComponent]];

    // 3) download and cache JS files
    [[NSNotificationCenter defaultCenter] postNotificationName:IR_LOADING_TITLE_NOTIFICATION object:@"Controllers"];
    // 3.1)  internal JS libraries
    pathsArray = @[@"infrared.js", @"infrared_md5.min.js", @"zeroTimeout.js", @"zeroTimeoutWorker.js", @"infrared_watch.js"];
    failedPathsArray = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] postNotificationName:IR_FILES_TO_PROCESS_NOTIFICATION
                                                        object:@{IR_FILES_TO_PROCESS_COUNT:@([pathsArray count]),
                                                                 IR_FILES_TO_PROCESS_PERCENTAGE:@(5)}];
    [IRFileLoadingUtil downloadOrCopyFilesFromPathsArrayIfNeeded:pathsArray
                                                 destinationPath:[documentsDirectory stringByAppendingPathComponent:jsonPathComponent]
                                                    preserveName:YES
                                              failedLoadingPaths:failedPathsArray];
    // 3.2) all JSPlugin files
    pathsArray = [IRBaseDescriptor allJSFilesPaths:appDescriptor];
    pathsArray = [self processFilePathsArray:pathsArray appDescriptor:appDescriptor];
    failedPathsArray = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] postNotificationName:IR_FILES_TO_PROCESS_NOTIFICATION
                                                        object:@{IR_FILES_TO_PROCESS_COUNT:@([pathsArray count]),
                                                                 IR_FILES_TO_PROCESS_PERCENTAGE:@(15)}];
    [IRFileLoadingUtil downloadOrCopyFilesFromPathsArrayIfNeeded:pathsArray
                                                 destinationPath:[documentsDirectory stringByAppendingPathComponent:jsonPathComponent]
                                                    preserveName:YES
                                              failedLoadingPaths:failedPathsArray];
    // 3.3) all JSLibrary files
    pathsArray = /*[IRDataController sharedInstance].*/appDescriptor.jsLibrariesArray;
    pathsArray = [self processFilePathsArray:pathsArray appDescriptor:appDescriptor];
    failedPathsArray = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] postNotificationName:IR_FILES_TO_PROCESS_NOTIFICATION
                                                        object:@{IR_FILES_TO_PROCESS_COUNT:@([pathsArray count]),
                                                                 IR_FILES_TO_PROCESS_PERCENTAGE:@(15)}];
    [IRFileLoadingUtil downloadOrCopyFilesFromPathsArrayIfNeeded:pathsArray
                                                 destinationPath:[documentsDirectory stringByAppendingPathComponent:jsonPathComponent]
                                                    preserveName:YES
                                              failedLoadingPaths:failedPathsArray];
    // 3.4) all I18N files
    [[NSNotificationCenter defaultCenter] postNotificationName:IR_LOADING_TITLE_NOTIFICATION object:@"Localisation"];
    pathsArray = [/*[IRDataController sharedInstance].*/appDescriptor.i18n.languagesArray allValues];
    pathsArray = [self processFilePathsArray:pathsArray appDescriptor:appDescriptor];
    failedPathsArray = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] postNotificationName:IR_FILES_TO_PROCESS_NOTIFICATION
                                                        object:@{IR_FILES_TO_PROCESS_COUNT:@([pathsArray count]),
                                                                 IR_FILES_TO_PROCESS_PERCENTAGE:@(5)}];
    [IRFileLoadingUtil downloadOrCopyFilesFromPathsArrayIfNeeded:pathsArray
                                                 destinationPath:[documentsDirectory stringByAppendingPathComponent:jsonPathComponent]
                                                    preserveName:YES
                                              failedLoadingPaths:failedPathsArray];

    self.previousAppName = [[[[IRDataController sharedInstance] globalJSContext] evaluateScript:@"IR.appName"] toString];
    NSLog(@"buildInfraredAppFromPath -previousAppName:%@", self.previousAppName);

    // -- clear cached data
    [[IRDataController sharedInstance] cleanData];

    [IRDataController sharedInstance].appDescriptor = appDescriptor;

    // 4) create JSContext from UIWebView
    [[IRDataController sharedInstance] initJSContext:appDescriptor];

    // 5) check for updated app json
    if ([IRDataController sharedInstance].checkForNewAppDescriptorSource) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // -- reset check flag
            [IRDataController sharedInstance].checkForNewAppDescriptorSource = NO;
            // -- offer update if needed
            BOOL offerAppUpdate = [self shouldOfferAppUpdate:path baseAppDescriptor:[IRDataController sharedInstance].appDescriptor];
            if (offerAppUpdate) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"App update"
                                                                    message:@"New verison is availalbe. Would you like to update?"
                                                                   delegate:self
                                                          cancelButtonTitle:@"Cancel"
                                                          otherButtonTitles:nil];
                    [alert addButtonWithTitle:@"Update"];
                    [alert show];
                });
            }
        });
    }

    // NEXT STEP
    // - method "buildInfraredAppFromPath2ndPhase" will be called after UIWebView in IRDataController is loaded
}

- (NSArray *) screenPathsArray:(NSArray *)screenDictionariesArray
{
    NSMutableArray *screenDescriptorsArray = [[NSMutableArray alloc] init];
    NSDictionary *dictionary;
    NSString *anDeviceType;
    NSString *anScreenPath;
    for (NSDictionary *anScreenDictionary in screenDictionariesArray) {
        anDeviceType = anScreenDictionary[deviceTypeKEY];
        if ([IRBaseDescriptor isDeviceTypeMatchingDevice:anDeviceType])
        {
            anScreenPath = anScreenDictionary[pathKEY];
            [screenDescriptorsArray addObject:anScreenPath];
        }
    }
    return screenDescriptorsArray;
}

- (BOOL) shouldOfferAppUpdate:(NSString *)appJsonPath
            baseAppDescriptor:(IRAppDescriptor *)baseAppDescriptor
{
    NSDictionary *dictionary = [IRUtil dictionaryFromPath:appJsonPath];
    IRAppDescriptor *appDescriptor = [[IRAppDescriptor alloc] initDescriptorForVersionWithDictionary:dictionary];
    BOOL shouldOfferAppUpdate = NO;
    if ([baseAppDescriptor.app isEqualToString:appDescriptor.app] == NO
        || baseAppDescriptor.version < appDescriptor.version)
    {
        shouldOfferAppUpdate = YES;
    }
    return shouldOfferAppUpdate;
}
// --------------------------------------------------------------------------------------------------------------------
- (void) buildInfraredAppFromPath2ndPhase
{
    // 6) register all libraries
    [IRUtilLibrary registerLibrary:[[IRDataController sharedInstance] globalJSContext]];

    // 7) add JSExport protocols for all component
    // This step has to go before "8" (addComponentConstructorsToJSContext), otherwise protocols will not be registered properly
    // At time of writing this I was not able to figure out why is this happening
    [[IRDataController sharedInstance] addAllJSExportProtocols];

    // 8) add component constructors ("create" method) to globalJSContext
    [[IRDataController sharedInstance] addComponentConstructorsToJSContext:[[IRDataController sharedInstance] globalJSContext]];

    // 9) init I18N
    [self initI18NData];

    // 10) Setting current app's name and version number
    [[[IRDataController sharedInstance] globalJSContext] evaluateScript:[NSString stringWithFormat:@"IR.appName='%@'", [IRDataController sharedInstance].appDescriptor.app]];
    [[[IRDataController sharedInstance] globalJSContext] evaluateScript:[NSString stringWithFormat:@"IR.appVersion=%lld", [IRDataController sharedInstance].appDescriptor.version]];

    // 11) update HTML "sessionStorage" and "localStorage"
    // ### sessionStorage
    // -- clean session storage
    [[[IRDataController sharedInstance] globalJSContext] evaluateScript:@"window.sessionStorage.clear();"];
    // ### localStorage
    // -- clean local storage
    [[[IRDataController sharedInstance] globalJSContext] evaluateScript:@"IR.localStorageOriginalClear.call(localStorage)"];
    // -- restore local storage for appName
    NSString *localStorageDataJsonString = [[IRDataController sharedInstance] getLocalStorageItemsAsJsonStringForAppName:[IRDataController sharedInstance].appDescriptor.app];
    NSString *methodCall = [NSString stringWithFormat:@"IR.setLocalStorageItems(%@);", localStorageDataJsonString];
    [[[IRDataController sharedInstance] globalJSContext] evaluateScript:methodCall];

    // 12) dispatch JS Event that IR app is ready
    [[[IRDataController sharedInstance] globalJSContext] evaluateScript:@"window.dispatchEvent(new Event('ir_load'));"];

    // 13) build main view-controller
    if (self.setRootViewController) {
        if (/* ! self.infraredContextReadyBlock
            && */[self.delegate conformsToProtocol:@protocol(InfraredDelegate)]
            && [self.delegate respondsToSelector:@selector(willSetRootViewController)])
        {
            [self.delegate willSetRootViewController];
        }

        IRScreenDescriptor *mainScreenDescriptor = [[IRDataController sharedInstance].appDescriptor mainScreenDescriptor];
        [self buildViewControllerAndSetRootViewControllerScreenDescriptor:mainScreenDescriptor
                                                                     data:nil];

        if (/* ! self.infraredContextReadyBlock
            && */[self.delegate conformsToProtocol:@protocol(InfraredDelegate)]
            && [self.delegate respondsToSelector:@selector(didSetRootViewController)])
        {
            [self.delegate didSetRootViewController];
        }
    }

    // 14) add web-view to UI to improve jsContext
    UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
    UIWebView *webView = [[IRDataController sharedInstance] globalWebView];
    webView.frame = CGRectMake(0, 0, 1, 1);
    [currentWindow addSubview:webView];

    // 15) post-notification that informs about IR context being ready
    [[NSNotificationCenter defaultCenter] postNotificationName:IR_CONTEXT_READY_NOTIFICATION object:nil];

    if (self.infraredContextReadyBlock) {
        self.infraredContextReadyBlock();
    }

}
- (void) initI18NData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSString *jsonImagesPathComponent;
    NSData *fileData;
    NSDictionary *dictionary = nil;
    NSString *languageFilePath = [self currentLanguageFileName];
    JSContext *globalContext;
    if ([languageFilePath length] > 0) {
        // -- create path
        jsonImagesPathComponent = [IRUtil jsonAndJsPathForAppDescriptorApp:[IRDataController sharedInstance].appDescriptor.app
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
            globalContext[IR_JS_LIBRARY_KEY][I18N_JS_DATA_KEY] = [IRDataController sharedInstance].i18n;
        }
    }
}
- (NSString *) currentLanguageFileName
{
    NSString *currentLanguageFileName = nil;
    NSArray *preferredLocalizations = [[NSBundle mainBundle] preferredLocalizations];
    NSString *language = [preferredLocalizations firstObject];
    IRI18NDescriptor *descriptor = [IRDataController sharedInstance].appDescriptor.i18n;
    currentLanguageFileName = descriptor.languagesArray[language];
    if (currentLanguageFileName == nil) {
        currentLanguageFileName = descriptor.languagesArray[descriptor.defaultLanguage];
    }
    currentLanguageFileName = [currentLanguageFileName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    currentLanguageFileName = [IRUtil fileNameFromPath:currentLanguageFileName];
    return currentLanguageFileName;
}
- (void) loadFonts:(IRAppDescriptor *)appDescriptor
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSString *resourcesPathComponent = [IRUtil resourcesPathForAppDescriptor:appDescriptor];
    NSData *fontData;
    CFErrorRef error;
    CGDataProviderRef provider;
    CGFontRef font;
    CFStringRef errorDescription;
    for (NSString *anFontPath in appDescriptor.fontsArray) {
        fontData = [IRFileLoadingUtil dataForFileWithPath:anFontPath
                                          destinationPath:[documentsDirectory stringByAppendingPathComponent:resourcesPathComponent]
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
- (void) cleanOtherAppsCacheFolderForApp:(NSDictionary *)dictionary
{
    IRAppDescriptor *appDescriptor = [[IRAppDescriptor alloc] initDescriptorForVersionWithDictionary:dictionary];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSString *irBaseDocPathComponent = [IRUtil documentsBasePathForInfrared];
    NSString *destinationPath = [documentsDirectory stringByAppendingPathComponent:irBaseDocPathComponent];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *filesArray = [fileManager contentsOfDirectoryAtPath:destinationPath error:&error];
    if (error) {
        NSLog(@"Infrared-cleanOtherAppsCacheFolderForApp --1--: %@", [error localizedDescription]);
        return;
    }
    NSString *finalPath;
    for (NSString *lastPathComponent in filesArray) {
        if ([lastPathComponent isEqualToString:appDescriptor.app] == NO) {
            finalPath = [/*irBaseDocPathComponent*/destinationPath stringByAppendingPathComponent:lastPathComponent];
            [[NSFileManager defaultManager] removeItemAtPath:finalPath error:&error];
            if (error) {
                NSLog(@"Infrared-cleanOtherAppsCacheFolderForApp --2--: %@", [error localizedDescription]);
            }
        }
    }
}
- (void) cleanOlderVersionsCacheFolderForApp:(NSDictionary *)dictionary
{
    IRAppDescriptor *appDescriptor = [[IRAppDescriptor alloc] initDescriptorForVersionWithDictionary:dictionary];
//    NSInteger version;
//    version = appDescriptor.version-1;
//    for (; version >= 0; version--) {
//        [self deleteCacheFolderForAppWithApp:appDescriptor.app version:version];
//    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSString *basePathComponent = [IRUtil basePathAppDescriptorApp:appDescriptor.app];
    NSString *finalPath = [documentsDirectory stringByAppendingPathComponent:basePathComponent];
    NSError *error;
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:finalPath error:&error];
    NSString *fileToDeletePath;
    if (!error) {
        for (NSString * filename in directoryContent) {
            if ([filename isEqualToString:[@(appDescriptor.version) stringValue]] == NO) {
                error = nil;
                fileToDeletePath = [finalPath stringByAppendingPathComponent:filename];
                [[NSFileManager defaultManager] removeItemAtPath:fileToDeletePath error:&error];
                if (error) {
                    NSLog(@"Infrared-deleteCacheFolderForAppWithLabel --File:%@   --Error: %@", filename, [error localizedDescription]);
                }
            }
        }
    }
}
- (void) cleanCacheFolderForApp:(NSDictionary *)dictionary
{
    IRAppDescriptor *appDescriptor = [[IRAppDescriptor alloc] initDescriptorForVersionWithDictionary:dictionary];
    [self deleteCacheFolderForAppWithApp:appDescriptor.app version:appDescriptor.version];
}
// --------------------------------------------------------------------------------------------------------------------
- (void) updateCurrentInfraredApp
{
    [self updateCurrentInfraredAppWithUpdateJSONPath:[[IRDataController sharedInstance] defaultUpdateJSONPath]];
}
- (void) updateCurrentInfraredAppWithUpdateJSONPath:(NSString *)updateUIPath
                                 handleContextReady:(InfraredContextReadyBlock)block
{
    [self cleanAndBuildInfraredAppFromPath:self.appJsonPath
                        withUpdateJSONPath:updateUIPath
                        handleContextReady:block];
}
- (void) updateCurrentInfraredAppWithUpdateJSONPath:(NSString *)updateUIPath
{
    [self cleanAndBuildInfraredAppFromPath:self.appJsonPath
                        withUpdateJSONPath:updateUIPath];
}
// --------------------------------------------------------------------------------------------------------------------
- (void) cleanAndBuildInfraredAppFromPath:(NSString *)path
{
    [self cleanAndBuildInfraredAppFromPath:path
                        withUpdateJSONPath:[[IRDataController sharedInstance] defaultUpdateJSONPath]];
}
- (void) cleanAndBuildInfraredAppFromPath:(NSString *)path
                       withUpdateJSONPath:(NSString *)updateUIPath
                       handleContextReady:(InfraredContextReadyBlock)block
{
    @try {
        self.updateJsonTransitionInProgress = YES;

        [IRDataController sharedInstance].updateJSONPath = updateUIPath;

        if (block) {
            [self showAppUpdateUI:block];
        } else {
            [self showAppUpdateUI:^{
                NSLog(@"cleanCacheAndRebuildAppWithPath - when context ready (2)");
                [self cleanCacheAndRebuildAppWithPath:path
                      handleContextReady:^{
                          self.updateJsonTransitionInProgress = NO;
                      }];
            }];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception occurred: %@, %@", exception, [exception userInfo]);
    }
}
- (void) cleanAndBuildInfraredAppFromPath:(NSString *)path
                       withUpdateJSONPath:(NSString *)updateUIPath
{
    [self cleanAndBuildInfraredAppFromPath:path
                        withUpdateJSONPath:updateUIPath
                        handleContextReady:^{
                            NSLog(@"cleanCacheAndRebuildAppWithPath - when context ready (1)");
                            [self cleanCacheAndRebuildAppWithPath:path
                                               handleContextReady:^{
                                                   self.updateJsonTransitionInProgress = NO;
                                               }];
                        }];
}

// --------------------------------------------------------------------------------------------------------------------
- (void) deleteCacheFolderForAppWithApp:(NSString *)app
                                version:(long long)version
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSString *basePathComponent = [IRUtil basePathAppDescriptorApp:app version:version];
    NSString *finalPath = [documentsDirectory stringByAppendingPathComponent:basePathComponent];
    NSError *error;
    if ([[NSFileManager defaultManager] fileExistsAtPath:finalPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:finalPath error:&error];
        if (error) {
            NSLog(@"Infrared-deleteCacheFolderForAppWithLabel Error: %@", [error localizedDescription]);
        }
    }
}
// --------------------------------------------------------------------------------------------------------------------
- (void) buildViewControllerAndSetRootViewControllerScreenDescriptor:(IRScreenDescriptor *)screenDescriptor
                                                                data:(id)data
{
    if (screenDescriptor) {
        @try {
            IRViewController *rootViewController = [IRViewControllerBuilder buildAndWrapViewControllerFromScreenDescriptor:screenDescriptor
                                                                                                                      data:data];
            id<UIApplicationDelegate> appDelegate = [UIApplication sharedApplication].delegate;
            IRViewController *oldViewController = (IRViewController *) appDelegate.window.rootViewController;

            // -- set new root view controller
            appDelegate.window.rootViewController = rootViewController;
            [appDelegate.window makeKeyAndVisible];
            [[NSNotificationCenter defaultCenter] postNotificationName:IR_ROOT_VC_UPDATED_NOTIFICATION object:nil];

            // -- clean previous (old) view controller
            if (oldViewController) {
                [[IRDataController sharedInstance] unregisterViewControllerAndItsNavigationStack:oldViewController];
            }
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
- (void) registerComponentDescriptor:(Class)descriptorClass
{
    [[IRDataController sharedInstance] registerComponentDescriptor:descriptorClass];
}
- (void) registerExtraComponentDescriptors:(NSArray *)descriptorClassedArray
{
    for (Class anDescriptorClass in descriptorClassedArray) {
        [[IRDataController sharedInstance] registerComponentDescriptor:anDescriptorClass];
    }
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
    if (buttonIndex == 1) { // "Update" selected
        [self updateCurrentInfraredApp];
    }
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Private methods

- (void) showAppUpdateUI:(InfraredContextReadyBlock)block
{
    [self cleanCacheAndRebuildAppWithPath:[IRDataController sharedInstance].updateJSONPath
                       handleContextReady:block];
}
- (void) showAppUpdateUI
{
    [self showAppUpdateUI:nil];
}
- (void) cleanCacheAndRebuildAppWithPath:(NSString *)path
         handleContextReady:(InfraredContextReadyBlock)block
{
    [self cleanCacheAndRebuildAppWithPath:path
                            appDescriptor:[IRDataController sharedInstance].appDescriptor
                            handleContextReady:block];
}
- (void) cleanCacheAndRebuildAppWithPath:(NSString *)path
{
    [self cleanCacheAndRebuildAppWithPath:path handleContextReady:nil];
}
- (void) cleanCacheAndRebuildAppWithPath:(NSString *)path
                           appDescriptor:(IRAppDescriptor *)appDescriptor
                      handleContextReady:(InfraredContextReadyBlock)block
{
    self.infraredContextReadyBlock = block;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        // -- clear cached data
//        [[IRDataController sharedInstance] cleanData];
        // -- clear user-defaults
        [IRUtil cleanAppAndVersionInUserDefaults];
        // -- clean cacheFolder
        [self deleteCacheFolderForAppWithApp:appDescriptor.app version:appDescriptor.version];
        // -- start app building process
        [self buildInfraredAppFromPath:path];
    });
}
- (void) cleanCacheAndRebuildAppWithPath:(NSString *)path
                           appDescriptor:(IRAppDescriptor *)appDescriptor
{
    [self cleanCacheAndRebuildAppWithPath:path
                            appDescriptor:appDescriptor
                       handleContextReady:nil];
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