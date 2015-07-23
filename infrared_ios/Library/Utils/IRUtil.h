//
// Created by Uros Milivojevic on 10/3/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IRBaseDescriptor;
@class IRViewController;
@class IRAppDescriptor;

@interface IRUtil : NSObject

+ (NSDictionary *) appDictionaryFromPath:(NSString *)path;

+ (void) cleanAppAndVersionInUserDefaults;

+ (NSDictionary *) screenDictionaryFromPath:(NSString *)path
                                        app:(NSString *)app
                                    version:(NSInteger)version;

+ (NSDictionary *) dictionaryFromPath:(NSString *)path;

+ (NSString *) resourcesPathForAppDescriptor:(IRAppDescriptor *)appDescriptor;

+ (NSString *) resourcesPathForAppDescriptorApp:(NSString *)app
                                        version:(NSInteger)version;
+ (NSString *) jsonAndJsPathForAppDescriptor:(IRAppDescriptor *)appDescriptor;

+ (NSString *) jsonAndJsPathForAppDescriptorApp:(NSString *)app
                                        version:(NSInteger)version;


+ (NSString *) basePathAppDescriptorApp:(NSString *)app
                                version:(NSInteger)version;
+ (NSString *) basePathAppDescriptorApp:(NSString *)app;
+ (NSString *) documentsBasePathForInfrared;

+ (NSString *) fileNameFromPath:(NSString *)path;

+ (NSString *) prefixFilePathWithBaseUrlIfNeeded:(NSString *)filePath;
+ (NSString *) prefixFilePathWithBaseUrlIfNeeded:(NSString *)filePath
                                   appDescriptor:(IRAppDescriptor *)appDescriptor;
+ (NSString *) prefixFilePathWithBaseUrlIfNeeded:(NSString *)filePath
                                         baseUrl:(NSString *)baseUrl;

#if TARGET_OS_IPHONE
+(UIImage *) imagePrefixedWithBaseUrlIfNeeded:(NSString *)path;
#endif

+ (NSData *) dataFromPath:(NSString *)path;
+ (NSString *) stringFromPath:(NSString *)path;

+ (NSURL *) ulrForPath:(NSString *)path;

+ (BOOL) hasFilePrefix:(NSString *)path;
+ (BOOL) hasHTTPPrefix:(NSString *)path;

+ (BOOL) isFileForDownload:(NSString *)path;

+ (BOOL) isLocalFile:(NSString *)path;
+ (NSData *) localFileData:(NSString *)path;

+ (IRBaseDescriptor *) buildUIDescriptorFromDictionary:(NSDictionary *)sourceDictionary;

#if TARGET_OS_IPHONE
+ (UIColor *) transformHexColorToUIColor:(NSString *)hexColor;
+ (UIColor *) transformHexTripletToUIColor:(NSString *)hexTriplet;
+ (UIColor *) transformHexTripletToUIColor:(NSString *)hexTriplet
                                 withAlpha:(CGFloat)alpha;

+ (NSString *) createKeyFromVCAddress:(IRViewController *)irViewController;
#endif
+ (NSString *) createKeyFromObjectAddress:(NSObject *)object;

@end