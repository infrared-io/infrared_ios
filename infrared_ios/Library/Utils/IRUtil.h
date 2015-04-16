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
+ (NSDictionary *) screenDictionaryFromPath:(NSString *)path
                                      label:(NSString *)label
                                    version:(NSInteger)version;

+ (NSDictionary *) dictionaryFromPath:(NSString *)path;

+ (NSString *) resourcesPathForAppDescriptor:(IRAppDescriptor *)appDescriptor;
+ (NSString *) resourcesPathForAppDescriptorLabel:(NSString *)label
                                          version:(NSInteger)version;
+ (NSString *) jsonAndjsPathForAppDescriptor:(IRAppDescriptor *)appDescriptor;
+ (NSString *) jsonAndjsPathForAppDescriptorLabel:(NSString *)label
                                          version:(NSInteger)version;
+ (NSString *) basePathAppDescriptorLabel:(NSString *)label
                                   varion:(NSInteger)version;
+ (NSString *) documentsBasePathForInfrared;

+ (NSString *) fileNameFromPath:(NSString *)path;

+ (NSString *) prefixFilePathWithBaseUrlIfNeeded:(NSString *)filePath;
+ (NSString *) prefixFilePathWithBaseUrlIfNeeded:(NSString *)filePath
                                   appDescriptor:(IRAppDescriptor *)appDescriptor;

+ (NSData *) dataFromPath:(NSString *)path;
+ (NSString *) stringFromPath:(NSString *)path;

+ (NSURL *) ulrForPath:(NSString *)path;

+ (BOOL) hasHTTPPrefix:(NSString *)path;

+ (BOOL) isLocalFile:(NSString *)path;
+ (NSData *) localFileData:(NSString *)path;

+ (IRBaseDescriptor *) buildUIDescriptorFromDictionary:(NSDictionary *)sourceDictionary;

+ (UIColor *) transformHexColorToUIColor:(NSString *)hexColor;
+ (UIColor *) transformHexTripletToUIColor:(NSString *)hexTriplet;
+ (UIColor *) transformHexTripletToUIColor:(NSString *)hexTriplet
                                 withAlpha:(CGFloat)alpha;

+ (NSString *) createKeyFromVCAddress:(IRViewController *)irViewController;
+ (NSString *) createKeyFromObjectAddress:(NSObject *)object;

@end