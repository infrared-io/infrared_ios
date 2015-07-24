//
// Created by Uros Milivojevic on 10/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IRFileLoadingUtil : NSObject

+ (void) downloadOrCopyFilesFromPathsArrayIfNeeded:(NSArray *)filePathsArray
                                   destinationPath:(NSString *)destinationPath
                                      preserveName:(BOOL)preserverName
                                failedLoadingPaths:(NSMutableArray *)failedPaths;

+ (BOOL) downloadOrCopyFileWithPathIfNeeded:(NSString *)filePath
                            destinationPath:(NSString *)destinationPath
                               preserveName:(BOOL)preserverName;

+ (BOOL) crateNoSyncFolderIfNeeded:(NSString *)folderPath;

+ (NSData *) dataForFileWithPath:(NSString *)filePath
                 destinationPath:(NSString *)destinationPath
                    preserveName:(BOOL)preserverName;
@end