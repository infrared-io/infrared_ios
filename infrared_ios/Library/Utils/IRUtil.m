//
// Created by Uros Milivojevic on 10/3/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRUtil.h"
#import "IRGlobal.h"
#import "IRViewControllerDescriptor.h"
#import "IRBaseDescriptor.h"
#import "IRViewDescriptor.h"
#import "IRLabelDescriptor.h"
#import "IRDataController.h"
#import "IRSimpleCache.h"
#import "IRFileLoadingUtil.h"
#import "IRAppDescriptor.h"
#if TARGET_OS_IPHONE
#import "IRViewController.h"
#endif

#define FILE_PREFIX     @"file://"

@implementation IRUtil

+ (NSDictionary *) appDictionaryFromPath:(NSString *)path
{
    NSDictionary *dictionary = nil;
    NSString *app;
    NSInteger version;
    NSArray *paths;
    NSString *documentsDirectory;
    NSString *jsonImagesPathComponent;
    NSString *destinationPath;
    NSData *fileData;
    IRAppDescriptor *tempAppDescriptor;
    NSString *fileDestinationPath;

    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:APP_AND_VERSION_SUITED_NAME];
#if PREVENT_JSON_CACHE == 1
    // -- clear user-defaults
    [IRUtil cleanAppAndVersionInUserDefaults];
#endif
    app = [defaults stringForKey:appKEY];
    version = [defaults integerForKey:appVersionKEY];

    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectory = [paths firstObject];

    if ([app length] > 0) {
        // -- create path
        jsonImagesPathComponent = [IRUtil jsonAndJsPathForAppDescriptorApp:app version:version];

        // -- load json and build dictionary from it
        fileData = [IRFileLoadingUtil dataForFileWithPath:path
                                          destinationPath:[documentsDirectory stringByAppendingPathComponent:jsonImagesPathComponent]
                                             preserveName:YES];
    }

    if (fileData) {
        dictionary = [NSJSONSerialization JSONObjectWithData:fileData
                                                     options:kNilOptions
                                                       error:nil];

        // -- file is in cache - system should CHECK for new label/version
        [IRDataController sharedInstance].checkForNewAppDescriptorSource = YES;
    } else {
        // -- load json and build dictionary from it
        fileData = [IRUtil dataFromPath:path];
        if (fileData) {
            dictionary = [NSJSONSerialization JSONObjectWithData:fileData
                                                         options:kNilOptions
                                                           error:nil];
        }

        // -- create temp descriptor
        tempAppDescriptor = [[IRAppDescriptor alloc] initDescriptorForVersionWithDictionary:dictionary];
        app = tempAppDescriptor.app;
        version = tempAppDescriptor.version;

        // -- create path
        jsonImagesPathComponent = [IRUtil jsonAndJsPathForAppDescriptorApp:app version:version];
        destinationPath = [documentsDirectory stringByAppendingPathComponent:jsonImagesPathComponent];

        // -- crate folder
        BOOL folderExists = [IRFileLoadingUtil crateNoSyncFolderIfNeeded:destinationPath];
        // -- save file
        if (folderExists) {
            if ([IRUtil isLocalFile:path]) {
                fileDestinationPath = [destinationPath stringByAppendingFormat:@"/%@", path];
            } else {
                fileDestinationPath = [destinationPath stringByAppendingFormat:@"/%@", [IRUtil fileNameFromPath:path]];
            }
            [fileData writeToFile:fileDestinationPath
                       atomically:YES];
        }

        // -- save user-defaults
        [defaults setObject:app forKey:appKEY];
        [defaults setInteger:version forKey:appVersionKEY];
        [defaults synchronize];
    }

    return dictionary;
}

+ (void) cleanAppAndVersionInUserDefaults
{
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:APP_AND_VERSION_SUITED_NAME];
    [defaults removeObjectForKey:appKEY];
    [defaults removeObjectForKey:appVersionKEY];
    [defaults synchronize];
}

+ (NSDictionary *) screenDictionaryFromPath:(NSString *)path
                                        app:(NSString *)app
                                    version:(long long)version
{
    NSDictionary *dictionary = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSString *jsonAndJsPathComponent = [IRUtil jsonAndJsPathForAppDescriptorApp:app version:version];
    NSString *destinationPath;

#if TARGET_OS_IPHONE
    destinationPath = [documentsDirectory stringByAppendingPathComponent:jsonAndJsPathComponent];
#else
    destinationPath = [documentsDirectory stringByAppendingPathComponent:@"IRPrecache"];
    destinationPath = [destinationPath stringByAppendingPathComponent:jsonAndJsPathComponent];
#endif

    // -- download or copy JSON files ot cache folder (if needed)
    [IRFileLoadingUtil downloadOrCopyFileWithPathIfNeeded:path
                                          destinationPath:destinationPath
                                             preserveName:YES];

    // -- load json and build dictionary from it
    NSData *fileData = [IRFileLoadingUtil dataForFileWithPath:path
                                              destinationPath:destinationPath
                                                 preserveName:YES];
    if (fileData) {
        dictionary = [NSJSONSerialization JSONObjectWithData:fileData
                                                     options:kNilOptions
                                                       error:nil];
    }

    return dictionary;
}
+ (NSDictionary *) dictionaryFromPath:(NSString *)path
{
    NSDictionary *dictionary = nil;
    NSData *fileData = [IRUtil dataFromPath:path];
    if (fileData) {
        dictionary = [NSJSONSerialization JSONObjectWithData:fileData
                                                     options:kNilOptions
                                                       error:nil];
    }
    return dictionary;
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
+ (NSString *) resourcesPathForAppDescriptor:(IRAppDescriptor *)appDescriptor
{
    return [IRUtil resourcesPathForAppDescriptorApp:appDescriptor.app version:appDescriptor.version];
}

+ (NSString *) resourcesPathForAppDescriptorApp:(NSString *)app
                                        version:(long long)version
{
    NSString *jsonPathComponent = [NSString stringWithFormat:@"%@/resources",
                                            [IRUtil basePathAppDescriptorApp:app version:version]];
    return jsonPathComponent;
}
// --------------------------------------------------------------------------------------------------------------------
+ (NSString *) jsonAndJsPathForAppDescriptor:(IRAppDescriptor *)appDescriptor
{
    return [IRUtil jsonAndJsPathForAppDescriptorApp:appDescriptor.app version:appDescriptor.version];
}

+ (NSString *) jsonAndJsPathForAppDescriptorApp:(NSString *)app
                                        version:(long long)version
{
    NSString *jsonPathComponent = [NSString stringWithFormat:@"%@/App",
                                            [IRUtil basePathAppDescriptorApp:app version:version]];
    return jsonPathComponent;
}

// --------------------------------------------------------------------------------------------------------------------
+ (NSString *) basePathAppDescriptorApp:(NSString *)app
                                version:(long long)version
{
    NSString *basePathComponent = [NSString stringWithFormat:@"%@/%@/%lld",
                                                             [IRUtil documentsBasePathForInfrared],
                                                             app,
                                                             version];
    return basePathComponent;
}
+ (NSString *) basePathAppDescriptorApp:(NSString *)app
{
    NSString *basePathComponent = [NSString stringWithFormat:@"%@/%@",
                                                             [IRUtil documentsBasePathForInfrared],
                                                             app];
    return basePathComponent;
}
// --------------------------------------------------------------------------------------------------------------------
+ (NSString *) documentsBasePathForInfrared
{
    return @"IR";
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
+ (NSString *) scriptTagFileNameFromPath:(NSString *)path
{
    NSString *name = [IRUtil fileNameFromPath:path];
    NSURL *candidateURL = [NSURL URLWithString:path];
    if ([candidateURL.query length] > 0) {
        name = [name stringByAppendingFormat:@"?%@", candidateURL.query];
    }
    if ([candidateURL.fragment length] > 0) {
        name = [name stringByAppendingFormat:@"#%@", candidateURL.fragment];
    }
    return name;
}
+ (NSString *) fileNameFromPath:(NSString *)path
{
    NSString *name = @"";
    NSURL *candidateURL = [NSURL URLWithString:path];
    // -- construct name
    if (candidateURL.fileURL) {
        if ([candidateURL.lastPathComponent length] > 0) {
            name = candidateURL.lastPathComponent;
        } else if ([candidateURL.host length] > 0) {
            name = candidateURL.host; // resourceSpecifier
        }
    } else {
        if ([candidateURL.lastPathComponent length] > 0) {
            name = candidateURL.lastPathComponent;
        }
    }
    if ([candidateURL.query length] > 0) {
        name = [name stringByAppendingFormat:@"_%@", candidateURL.query];
    }
    if ([candidateURL.fragment length] > 0) {
        name = [name stringByAppendingFormat:@"_%@", candidateURL.fragment];
    }
    // -- remove illegal characters
    name = [name stringByReplacingOccurrencesOfString:@":" withString:@""];
    if ([name hasPrefix:@"."]) {
        name = [name substringFromIndex:1];
    }
    return name;
}
// --------------------------------------------------------------------------------------------------------------------
+ (NSString *) prefixFilePathWithBaseUrlIfNeeded:(NSString *)filePath
{
    return [IRUtil prefixFilePathWithBaseUrlIfNeeded:filePath
                                       appDescriptor:[IRDataController sharedInstance].appDescriptor];
}
+ (NSString *) prefixFilePathWithBaseUrlIfNeeded:(NSString *)filePath
                                   appDescriptor:(IRAppDescriptor *)appDescriptor
{
    return [IRUtil prefixFilePathWithBaseUrlIfNeeded:filePath baseUrl:appDescriptor.baseUrl];

}
+ (NSString *) prefixFilePathWithBaseUrlIfNeeded:(NSString *)filePath
                                         baseUrl:(NSString *)baseUrl
{
    NSString *processFilePath = filePath;
    if ([baseUrl length] > 0 && [filePath length] > 0) {
        if ([baseUrl hasSuffix:@"/"] == NO) {
            baseUrl = [baseUrl stringByAppendingString:@"/"];
        }
        if (/*[IRUtil isLocalFile:filePath]*/[IRUtil hasFilePrefix:filePath] == NO && [IRUtil hasHTTPPrefix:filePath] == NO) {
            processFilePath = [baseUrl stringByAppendingString:filePath];
        }
        processFilePath = [processFilePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    return processFilePath;
}
// --------------------------------------------------------------------------------------------------------------------
#if TARGET_OS_IPHONE
+(UIImage *) imagePrefixedWithBaseUrlIfNeeded:(NSString *)path
{
    UIImage *image = nil;
    NSString *imagePath;
    if (path) {
        imagePath = [IRUtil prefixFilePathWithBaseUrlIfNeeded:path];
        if ([imagePath length] > 0) {
            image = [[IRSimpleCache sharedInstance] imageForURI:imagePath];
        }
    }
    return image;
}
#endif
// --------------------------------------------------------------------------------------------------------------------
+ (NSData *) dataFromPath:(NSString *)path
{
    NSData *fileData = nil;
    NSURL *aURL;
    aURL = [IRUtil ulrForPath:path];
    NSURLRequest *request;
    NSHTTPURLResponse *response;
    NSError *error;
    if (aURL) {
        request = [NSURLRequest requestWithURL:aURL
                                   cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                               timeoutInterval:20];
        fileData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if (error) {
            NSLog(@"IRUtil-dataFromPath: path=\"%@\" error=%@", path, [error localizedDescription]);
            fileData = nil;
        }
    }
    return fileData;
}
+ (NSURL *) ulrForPath:(NSString *)path
{
    NSURL *aURL = nil;
    if ([IRUtil hasFilePrefix:path]) {
        aURL = [IRUtil localFileURL:path];
    } else if ([IRUtil hasHTTPPrefix:path]) {
        aURL = [NSURL URLWithString:path];
    } else {
        if ([IRUtil isValidURLWithHostAndPath:path]) {
            path = [NSString stringWithFormat:@"http://%@", path];
            aURL = [NSURL URLWithString:path];
        } else {
            aURL = [IRUtil localFileURL:path];
        }
    }
    return aURL;
}
+ (NSURL *) localFileURL:(NSString *)path
{
    NSURL *aURL = nil;
    NSRange range;
    NSString *adaptedPath;
    if ([path length] > 0) {
        adaptedPath = path;
        if ([adaptedPath hasPrefix:FILE_PREFIX]) {
            adaptedPath = [adaptedPath substringFromIndex:[FILE_PREFIX length]];
        }
        range = [adaptedPath rangeOfString:@"."]; // file.json
        if (range.location != NSNotFound) {
            aURL = [[NSBundle mainBundle] URLForResource:[adaptedPath substringToIndex:range.location]
                                           withExtension:[adaptedPath substringFromIndex:range.location+range.length]];
        } else {
            aURL = [[NSBundle mainBundle] URLForResource:adaptedPath withExtension:nil];
        }
    }
    return aURL;
}
+ (BOOL) hasFilePrefix:(NSString *)path
{
    BOOL hasFilePrefix = NO;
    if ([path hasPrefix:FILE_PREFIX]) {
        hasFilePrefix = YES;
    }
    return hasFilePrefix;
}
+ (BOOL) hasHTTPPrefix:(NSString *)path
{
    BOOL hasHTTPPrefix = NO;
    NSURL *candidateURL = [NSURL URLWithString:path];
    if ([candidateURL.scheme isEqualToString:@"http"]
        || [candidateURL.scheme isEqualToString:@"https"])
    {
        hasHTTPPrefix = YES;
    }
    return hasHTTPPrefix;
}
+ (BOOL) isValidURLWithHostAndPath:(NSString *)candidate
{
    BOOL isValidURL = NO;
    NSURL *candidateURL = [NSURL URLWithString:candidate];
    // WARNING > "test" is an URL according to RFCs, being just a path
    // so you still should check scheme and all other NSURL attributes you need
    if (candidateURL /*&& candidateURL.scheme*/ && candidateURL.host) {
        // candidate is a well-formed url with:
        //  - a host (like stackoverflow.com)
        // we don't care about scheme
        //  - a scheme (like http://)
        isValidURL = YES;
    }
    return isValidURL;
}
+ (NSString *) path:(NSString *)path withSuffix:(NSString *)suffix
{
    NSString *result = nil;
    if ([path length] > 0) {
        if ([suffix length] > 0) {
            result = [NSString stringWithFormat:@"%@#%@", path, suffix];
        } else {
            result = path;
        }
    }
    return result;
}
// --------------------------------------------------------------------------------------------------------------------
+ (NSString *) stringFromPath:(NSString *)path
{
    NSString *string = nil;
    NSData *fileData;
    fileData = [IRUtil dataFromPath:path];
    if (fileData) {
        string = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
    }
    return string;
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
+ (BOOL) isFileForDownload:(NSString *)path
{
    BOOL isFileForDownload = NO;
    BOOL hasFilePrefix = [IRUtil hasFilePrefix:path];
    NSString *baseUrl = [IRDataController sharedInstance].appDescriptor.baseUrl;
    BOOL isValidURLWithHostAndPath = [IRUtil isValidURLWithHostAndPath:path];
    if (hasFilePrefix == NO &&
        (([baseUrl length] > 0 && [path length] > 0) || isValidURLWithHostAndPath))
    {
        isFileForDownload = YES;
    }
    return isFileForDownload;
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
+ (BOOL) isLocalFile:(NSString *)path
{
    BOOL isLocalFile = NO;
    NSString *baseUrl = [IRDataController sharedInstance].appDescriptor.baseUrl;
    BOOL hasBaseUrl = (baseUrl && [baseUrl length] > 0);
    if ([IRUtil hasFilePrefix:path] ||
        (hasBaseUrl == NO && [IRUtil isValidURLWithHostAndPath:path] == NO))
    {
        isLocalFile = YES;
    }
    return isLocalFile;
}
+ (NSData *) localFileData:(NSString *)path
{
    NSURL *aURL;
    NSData *localFileData;
    if (path && [path length] > 0) {
        aURL = [IRUtil localFileURL:path];
        localFileData = [NSData dataWithContentsOfURL:aURL];
    } else {
        localFileData = nil;
    }
    return localFileData;
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
+ (IRBaseDescriptor *)buildUIDescriptorFromDictionary:(NSDictionary *)sourceDictionary
{
    IRBaseDescriptor *descriptor = [IRBaseDescriptor newViewDescriptorWithDictionary:sourceDictionary];
    return descriptor;
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
#if TARGET_OS_IPHONE
+ (UIColor *) transformHexColorToUIColor:(NSString *)hexColor {
    CGFloat alpha = 1.0;
    NSString *alphaString;
    NSScanner *scanner;
    unsigned alphaNumber;
    if ([hexColor length] == 9) {
        alphaString = [hexColor substringWithRange:NSMakeRange(7, 2)];
        scanner = [NSScanner scannerWithString:alphaString];
        [scanner scanHexInt:&alphaNumber];
        alpha = alphaNumber/255.0;
        hexColor = [hexColor substringToIndex:7];
    }
    return [IRUtil transformHexTripletToUIColor:hexColor
                                      withAlpha:alpha];
}
+ (UIColor *) transformHexTripletToUIColor:(NSString *)hexTriplet {
    return [IRUtil transformHexTripletToUIColor:hexTriplet
                                      withAlpha:1.0];
}
+ (UIColor *) transformHexTripletToUIColor:(NSString *)hexTriplet
                                 withAlpha:(CGFloat)alpha
{
    UIColor *color = nil;
    NSScanner *scanner;
    NSString *red, *green, *blue;
    unsigned redNumber, greenNumber, blueNumber;
    if ([hexTriplet hasPrefix:@"#"] && [hexTriplet length] == 7) {
        red = [hexTriplet substringWithRange:NSMakeRange(1, 2)];
        green = [hexTriplet substringWithRange:NSMakeRange(3, 2)];
        blue = [hexTriplet substringWithRange:NSMakeRange(5, 2)];
        scanner = [NSScanner scannerWithString:red];
        [scanner scanHexInt:&redNumber];
        scanner = [NSScanner scannerWithString:green];
        [scanner scanHexInt:&greenNumber];
        scanner = [NSScanner scannerWithString:blue];
        [scanner scanHexInt:&blueNumber];
        color = [UIColor colorWithRed:redNumber/255.0 green:greenNumber/255.0 blue:blueNumber/255.0 alpha:alpha];
    }
    return color;
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
+ (NSString *) createKeyFromVCAddress:(IRViewController *)irViewController
{
    NSString *key = nil;
    NSString *screenId;
    if (irViewController) {
        screenId = [[IRDataController sharedInstance] screenIdForControllerId:irViewController.descriptor.componentId];
        if (screenId == nil) {
            screenId = [NSString stringWithFormat:@"VC__id__%@", irViewController.descriptor.componentId];
        }
        key = [NSString stringWithFormat:@"%@_%@_%p", screenId, NSStringFromClass([irViewController class]), irViewController];
    }
    return key;
}
#endif
// --------------------------------------------------------------------------------------------------------------------
+ (NSString *) createKeyFromObjectAddress:(NSObject *)object
{
    NSString *key = nil;
    if (object) {
        key = [NSString stringWithFormat:@"%@_%p", NSStringFromClass([object class]), object];
    }
    return key;
}

@end