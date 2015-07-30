//
// Created by Uros Milivojevic on 10/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRFileLoadingUtil.h"
#import "IRSimpleCache.h"
#import "IRUtil.h"


@implementation IRFileLoadingUtil

+ (void) downloadOrCopyFilesFromPathsArrayIfNeeded:(NSArray *)filePathsArray
                                   destinationPath:(NSString *)destinationPath
                                      preserveName:(BOOL)preserverName
                                failedLoadingPaths:(NSMutableArray *)failedPaths
{
    BOOL failedLoadingPaths;
    for (NSString *anFilePath in filePathsArray) {
        failedLoadingPaths = [IRFileLoadingUtil downloadOrCopyFileWithPathIfNeeded:anFilePath
                                                                   destinationPath:destinationPath
                                                                      preserveName:preserverName];
        if (failedLoadingPaths) {
            [failedPaths addObject:anFilePath];
        }
    }
}

+ (BOOL) downloadOrCopyFileWithPathIfNeeded:(NSString *)filePath
                            destinationPath:(NSString *)destinationPath
                               preserveName:(BOOL)preserverName
{
    BOOL failedLoadingPaths = NO;
    BOOL folderAvailable = NO;
    NSString *fileSourcePath;
    NSString *fileDestinationPath;
    NSData *fileData;
    NSError *error;
    folderAvailable = [IRFileLoadingUtil crateNoSyncFolderIfNeeded:destinationPath];
    if (folderAvailable == NO) {
        failedLoadingPaths = YES;
        return failedLoadingPaths;
    }
    if ([IRUtil isLocalFile:filePath]) { // [IRUtil isValidURLWithHostAndPath:filePath]
//        fileDestinationPath = [destinationPath stringByAppendingFormat:@"/%@", filePath];
        if (preserverName) {
            fileDestinationPath = [destinationPath stringByAppendingFormat:@"/%@", [IRUtil fileNameFromPath:filePath]];
        } else {
            fileDestinationPath = [destinationPath stringByAppendingFormat:@"/%@", [[IRSimpleCache sharedInstance] fileIdForURI:filePath]];
        }
        if ([[NSFileManager defaultManager] fileExistsAtPath:fileDestinationPath]) {
//            NSLog(@"IRFileLoadingUtil-downloadOrCopyFilesFromPathsArray - copyItemAtURL '%@': file already exist - NO copying", filePath);
        } else {
            fileSourcePath = [[NSBundle mainBundle] pathForResource:filePath ofType:@""];
            if (fileSourcePath && fileDestinationPath) {
                [[NSFileManager defaultManager] copyItemAtURL:[NSURL fileURLWithPath:fileSourcePath]
                                                        toURL:[NSURL fileURLWithPath:fileDestinationPath]
                                                        error:&error];
            }
        }
        if (error) {
            NSLog(@"IRFileLoadingUtil-downloadOrCopyFilesFromPathsArray - copyItemAtURL '%@': %@", filePath, [error localizedDescription]);
            failedLoadingPaths = YES;
        }
    } else {
        if (preserverName) {
            fileDestinationPath = [destinationPath stringByAppendingFormat:@"/%@", [IRUtil fileNameFromPath:filePath]];
        } else {
            fileDestinationPath = [destinationPath stringByAppendingFormat:@"/%@", [[IRSimpleCache sharedInstance] fileIdForURI:filePath]];
        }
        if ([[NSFileManager defaultManager] fileExistsAtPath:fileDestinationPath]) {
//            NSLog(@"IRFileLoadingUtil-downloadOrCopyFilesFromPathsArray - writeToFile '%@': file already exist - NO copying", filePath);
        } else {
            fileData = [IRFileLoadingUtil downloadFile:filePath];
            // -- ***** If download failed try one more time *****
            if (fileData == nil) {
                fileData = [IRFileLoadingUtil downloadFile:filePath];
            }
            // -- save data
            if (fileData) {
                [fileData writeToFile:fileDestinationPath atomically:YES];
            } else {
                failedLoadingPaths = YES;
            }
        }
    }
    return failedLoadingPaths;
}

+ (BOOL) crateNoSyncFolderIfNeeded:(NSString *)folderPath
{
    BOOL successful = YES;
    NSError *error;
    if ([[NSFileManager defaultManager] fileExistsAtPath:folderPath] == NO) {
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:&error];
        [IRFileLoadingUtil addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:folderPath]];
        if (error) {
            NSLog(@"IRFileLoadingUtil-crateNoSyncFolderIfNeeded: %@", [error localizedDescription]);
            successful = NO;
        }
    }
    return successful;
}


+ (NSData *) dataForFileWithPath:(NSString *)filePath
                 destinationPath:(NSString *)destinationPath
                    preserveName:(BOOL)preserverName
{
    NSData *fileData = nil;
    NSString *fileDestinationPath = nil;
    if ([IRUtil isLocalFile:filePath]) {
        fileDestinationPath = [destinationPath stringByAppendingFormat:@"/%@", filePath];
    } else {
        if (preserverName) {
            fileDestinationPath = [destinationPath stringByAppendingFormat:@"/%@", [IRUtil fileNameFromPath:filePath]];
        } else {
            fileDestinationPath = [destinationPath stringByAppendingFormat:@"/%@", [[IRSimpleCache sharedInstance] fileIdForURI:filePath]];
        }
    }
    if (fileDestinationPath) {
        fileData = [NSData dataWithContentsOfFile:fileDestinationPath];
    }
    return fileData;
}

#pragma mark - Private methods

+ (NSData *) downloadFile:(NSString *)filePath
{
    return [IRUtil dataFromPath:filePath];
}

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    BOOL success = NO;
    NSError *error = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]) {
        success = [URL setResourceValue:@YES
                                 forKey:NSURLIsExcludedFromBackupKey
                                  error:&error];
        if(!success){
            NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
        }
    } else {
        NSLog(@"addSkipBackupAttributeToItemAtURL: - can't set skip-attribute for not existing folder");
    }
    return success;
}

@end