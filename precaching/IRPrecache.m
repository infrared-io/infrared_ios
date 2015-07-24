//
//  IRPrecache.m
//  infrared_ios
//
//  Created by Uros Milivojevic on 7/22/15.
//  Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRPrecache.h"
#import "IRAppDescriptor.h"
#import "IRFileLoadingUtil.h"
#import "IRUtil.h"
#import "IRI18NDescriptor.h"
#import "IRDataController.h"
#import "IRViewControllerDescriptor.h"
#import "IRActivityIndicatorViewDescriptor.h"
#import "IRButtonDescriptor.h"
#import "IRCollectionViewDescriptor.h"
#import "IRCollectionViewCellDescriptor.h"
#import "IRDatePickerDescriptor.h"
#import "IRImageViewDescriptor.h"
#import "IRLabelDescriptor.h"
#import "IRMapViewDescriptor.h"
#import "IRCollectionReusableViewDescriptor.h"
#import "IRAnnotationViewDescriptor.h"
#import "IRPinAnnotationViewDescriptor.h"
#import "IRNavigationBarDescriptor.h"
#import "IRCalloutAnnotationViewDescriptor.h"
#import "IRNavigationItemDescriptor.h"
#import "IRPageControlDescriptor.h"
#import "IRPickerViewDescriptor.h"
#import "IRProgressViewDescriptor.h"
#import "IRSearchBarDescriptor.h"
#import "IRSegmentedControlDescriptor.h"
#import "IRSliderDescriptor.h"
#import "IRStepperDescriptor.h"
#import "IRSwitchDescriptor.h"
#import "IRTableViewDescriptor.h"
#import "IRTableViewCellDescriptor.h"
#import "IRTextFieldDescriptor.h"
#import "IRTextViewDescriptor.h"
#import "IRToolbarDescriptor.h"
#import "IRBarButtonItemDescriptor.h"
#import "IRWebViewDescriptor.h"
#import "Main.h"

#define PROCESSING_DIRECTORY_NAME      @"Processing"

@implementation IRPrecache

+ (void) precacheInfraredAppFromPath:(NSString *)path
       withExtraComponentDescriptors:(NSArray *)descriptorClassedArray
{
    // 1) register internal components
    [IRPrecache registerComponents];
    // 2) register additional components
    for (Class anDescriptorClass in descriptorClassedArray) {
        [[IRDataController sharedInstance] registerComponentDescriptor:anDescriptorClass];
    }
    // 3) precache app
    [IRPrecache precacheInfraredAppFromPath:path registerComponents:NO];
}

+ (void) precacheInfraredAppFromPath:(NSString *)path
{
    [IRPrecache precacheInfraredAppFromPath:path registerComponents:YES];
}

+ (void) precacheInfraredAppFromPath:(NSString *)path
                  registerComponents:(BOOL)registerComponents
{
    NSDictionary *dictionary;
    IRAppDescriptor *appDescriptor;
    NSMutableArray *failedPathsArray;
    NSArray *pathsArray;
    NSString *resourcesPathComponent;
    NSString *jsonPathComponent;
    NSArray *paths;
    NSString *documentsDirectory;
    NSString *precacheDirectory;

    NSLog(@"#############################");
    NSLog(@"###  Precaching Started!  ###\n\n");

    if (registerComponents) {
        [IRPrecache registerComponents];
    }

    // clean precache folder
    [IRPrecache cleanPrecacheFolder];

    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectory = [paths firstObject];
    precacheDirectory = [documentsDirectory stringByAppendingPathComponent:@"IRPrecache"];

    // 1) cache App.json and build global App descriptor
    NSLog(@"1. Downloading JSON UI Files ...");
    dictionary = [IRUtil dictionaryFromPath:path];
    // -- build app descriptor
    appDescriptor = (IRAppDescriptor *) [IRBaseDescriptor newAppDescriptorWithDictionary:dictionary];
    [IRDataController sharedInstance].appDescriptor = appDescriptor;
    // -- cache app.json
    jsonPathComponent = [IRUtil jsonAndJsPathForAppDescriptor:appDescriptor];
    [IRFileLoadingUtil downloadOrCopyFileWithPath:path
                                  destinationPath:[precacheDirectory stringByAppendingPathComponent:jsonPathComponent]
                                     preserveName:YES];
    NSLog(@"    ... Done\n\n");

    // ------------------------------------------------------------------------
    // ------------------------------------------------------------------------
    // Downloading/Copying resources

    // 2) cache Fonts
    NSLog(@"2. Downloading Fonts ...");
    resourcesPathComponent = [IRUtil resourcesPathForAppDescriptor:appDescriptor];
    pathsArray = appDescriptor.fontsArray;
    pathsArray = [IRPrecache processFilePathsArray:pathsArray appDescriptor:appDescriptor];
    failedPathsArray = [NSMutableArray array];
    [IRFileLoadingUtil downloadOrCopyFilesFromPathsArray:pathsArray
                                         destinationPath:[precacheDirectory stringByAppendingPathComponent:resourcesPathComponent]
                                            preserveName:YES
                                      failedLoadingPaths:failedPathsArray];
    NSLog(@"    ... Done\n\n");

    // 3) download and cache all images
    NSLog(@"3. Donwloading Images ...");
    resourcesPathComponent = [IRUtil resourcesPathForAppDescriptor:appDescriptor];
    NSArray *imagePathsArray = [IRBaseDescriptor allImagePaths];
    imagePathsArray = [IRPrecache processFilePathsArray:imagePathsArray appDescriptor:appDescriptor];
    NSMutableArray *failedImagePathsArray = [NSMutableArray array];
    [IRFileLoadingUtil downloadOrCopyFilesFromPathsArray:imagePathsArray
                                         destinationPath:[precacheDirectory stringByAppendingPathComponent:resourcesPathComponent]
                                            preserveName:NO
                                      failedLoadingPaths:failedImagePathsArray];
    NSLog(@"    ... Done\n\n");
    
    // 4) download and cache JS files
//    // 4.1)  internal JS libraries
    NSLog(@"4. Copying Internal JS Libaries ...");
    pathsArray = @[@"infrared.js", @"infrared_md5.min.js", @"zeroTimeout.js", @"zeroTimeoutWorker.js", @"watch.js"];
    failedPathsArray = [NSMutableArray array];
    [IRFileLoadingUtil downloadOrCopyFilesFromPathsArray:pathsArray
                                         destinationPath:[precacheDirectory stringByAppendingPathComponent:jsonPathComponent]
                                            preserveName:YES
                                      failedLoadingPaths:failedPathsArray];
    NSLog(@"    ... Done\n\n");
    // 4.2) all JSPlugin files
    NSLog(@"5. Downloading JSPlugin Files ...");
    pathsArray = [IRBaseDescriptor allJSFilesPaths];
    pathsArray = [IRPrecache processFilePathsArray:pathsArray appDescriptor:appDescriptor];
    failedPathsArray = [NSMutableArray array];
    [IRFileLoadingUtil downloadOrCopyFilesFromPathsArray:pathsArray
                                         destinationPath:[precacheDirectory stringByAppendingPathComponent:jsonPathComponent]
                                            preserveName:YES
                                      failedLoadingPaths:failedPathsArray];
    NSLog(@"    ... Done\n\n");
    // 4.3) all JSLibrary files
    NSLog(@"6. Downloading JS Libraries ...");
    pathsArray = appDescriptor.jsLibrariesArray;
    pathsArray = [IRPrecache processFilePathsArray:pathsArray appDescriptor:appDescriptor];
    failedPathsArray = [NSMutableArray array];
    [IRFileLoadingUtil downloadOrCopyFilesFromPathsArray:pathsArray
                                         destinationPath:[precacheDirectory stringByAppendingPathComponent:jsonPathComponent]
                                            preserveName:YES
                                      failedLoadingPaths:failedPathsArray];
    NSLog(@"    ... Done\n\n");
    // 4.4) all I18N files
    NSLog(@"7. Downloading I18N Files ...");
    pathsArray = [appDescriptor.i18n.languagesArray allValues];
    pathsArray = [IRPrecache processFilePathsArray:pathsArray appDescriptor:appDescriptor];
    failedPathsArray = [NSMutableArray array];
    [IRFileLoadingUtil downloadOrCopyFilesFromPathsArray:pathsArray
                                         destinationPath:[precacheDirectory stringByAppendingPathComponent:jsonPathComponent]
                                            preserveName:YES
                                      failedLoadingPaths:failedPathsArray];
    NSLog(@"    ... Done\n\n");

    // 5) Zip all files
    NSLog(@"8. Createing Zip Archive ...");
    BOOL folderAvailable = [IRFileLoadingUtil crateNoSyncFolderIfNeeded:
                                                [precacheDirectory stringByAppendingPathComponent:PROCESSING_DIRECTORY_NAME]];
    if (folderAvailable == NO) {
        NSAssert(false, [NSString stringWithFormat:@"Directory \"%@\" can NOT be created!", PROCESSING_DIRECTORY_NAME]);
    }
    // -- compress app data
    NSString *zipDataDestinationPath = [precacheDirectory stringByAppendingFormat:@"/%@/IRPrecacheData_%@_%d.zip",
                                                                                  PROCESSING_DIRECTORY_NAME,
                                                                                  appDescriptor.app,
                                                                                  appDescriptor.version];
    NSString *irDataDictionary = [precacheDirectory stringByAppendingPathComponent:[IRUtil documentsBasePathForInfrared]];
    [Main createZipFileAtPath:zipDataDestinationPath
      withContentsOfDirectory:irDataDictionary];
    // -- add App/Version data
    NSString *appAndVersionJson = [NSString stringWithFormat:@"{\"%@\": \"%@\", \"%@\": %d}",
                                            appKEY, appDescriptor.app,
                                            appVersionKEY, appDescriptor.version];
    NSString *appAndVersionDataPath = [precacheDirectory stringByAppendingFormat:@"/%@/AppAndVersion.txt", PROCESSING_DIRECTORY_NAME];
    NSError *error;
    BOOL succeed = [appAndVersionJson writeToFile:appAndVersionDataPath
                                       atomically:YES
                                         encoding:NSUTF8StringEncoding
                                            error:&error];
    if (!succeed){
        NSAssert(false, @"App and Version file could NOT be saved!");
    }
    // -- create final zip
    NSString *precacheFileName = [NSString stringWithFormat:@"IRPrecache_%@_%d.zip",
                                                            appDescriptor.app,
                                                            appDescriptor.version];
    NSString *finalZipDestinationPath = [precacheDirectory stringByAppendingFormat:@"/%@", precacheFileName];
    NSString *processingDictionary = [irDataDictionary stringByAppendingPathComponent:PROCESSING_DIRECTORY_NAME];
    [Main createZipFileAtPath:finalZipDestinationPath
      withContentsOfDirectory:processingDictionary];
    NSLog(@"    ... Done\n\n");

    NSLog(@"\n\n\n"
           "#####################################################################################################\n"
           "########################                Precaching Completed!                ########################"
           "\n\n\n"
           "Copy zip archive from path \"%@\" and paste it to your Infrared project. \n"
           "(Don't forget to add it to Xcode project)\n\n"
           "In your Infrared project init app with following method: \n"
           "[Infrared buildInfraredAppFromPath:@\"PATH_HERE\" precacheFileName:@\"%@\"]"
           "\n\n\n"
           "#####################################################################################################"
           "",
           finalZipDestinationPath, precacheFileName);
//    NSLog(@"In your Infrared project use method ``[Infrared buildInfraredAppFromPath:@\"PATH_HERE\" precacheFileName:@\"%@\"]`` to init app.\n", finalZipDestinationPath);
//    NSLog(@"Example:\n");
//    NSLog(@"\n");
//    NSLog(@"\n\n");

//    NSLog(@"### Precaching Completed! ###");
//    NSLog(@"#############################");
}

+ (void) registerComponents
{
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
    [[IRDataController sharedInstance] registerComponentDescriptor:[IRScrollViewDescriptor class]];
    [[IRDataController sharedInstance] registerComponentDescriptor:[IRSearchBarDescriptor class]];
    [[IRDataController sharedInstance] registerComponentDescriptor:[IRSegmentedControlDescriptor class]];
    [[IRDataController sharedInstance] registerComponentDescriptor:[IRSliderDescriptor class]];
    [[IRDataController sharedInstance] registerComponentDescriptor:[IRStepperDescriptor class]];
    [[IRDataController sharedInstance] registerComponentDescriptor:[IRSwitchDescriptor class]];
    [[IRDataController sharedInstance] registerComponentDescriptor:[IRTableViewDescriptor class]];
    [[IRDataController sharedInstance] registerComponentDescriptor:[IRTableViewCellDescriptor class]];
    [[IRDataController sharedInstance] registerComponentDescriptor:[IRTextFieldDescriptor class]];
    [[IRDataController sharedInstance] registerComponentDescriptor:[IRTextViewDescriptor class]];
    [[IRDataController sharedInstance] registerComponentDescriptor:[IRToolbarDescriptor class]];
    [[IRDataController sharedInstance] registerComponentDescriptor:[IRBarButtonItemDescriptor class]];
    [[IRDataController sharedInstance] registerComponentDescriptor:[IRViewDescriptor class]];
    [[IRDataController sharedInstance] registerComponentDescriptor:[IRWebViewDescriptor class]];
}

+ (NSArray *) processFilePathsArray:(NSArray *)filePathsArray
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

+ (void) cleanPrecacheFolder
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSString *finalPath = [documentsDirectory stringByAppendingPathComponent:@"IRPrecache"];
    NSError *error;
    if ([[NSFileManager defaultManager] fileExistsAtPath:finalPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:finalPath error:&error];
        if (error) {
            NSLog(@"IRPrecache-cleanPrecacheFolder Error: %@", [error localizedDescription]);
        }
    }
};

@end