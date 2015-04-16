//
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRSimpleCache.h"
#import "IRUtil.h"
#import <CommonCrypto/CommonHMAC.h>

@interface IRSimpleCache ()

@property (nonatomic, retain) NSString *cacheFolderPath;
@property (nonatomic, retain) NSString *extraCacheFolderPath;

- (NSString *) fileIdForURI:(NSString *)uri;

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@implementation IRSimpleCache

static IRSimpleCache *sharedCache;

- (id) init {
    self = [super init];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cacheDictionaryPath = paths[0];
		self.cacheFolderPath = [cacheDictionaryPath stringByAppendingPathComponent:@"AppFilesCache"];
        self.extraCacheFolderPath = nil;
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:self.cacheFolderPath] == NO) {
            [[NSFileManager defaultManager] createDirectoryAtPath:self.cacheFolderPath
                                      withIntermediateDirectories:NO 
                                                       attributes:nil 
                                                            error:NULL];
        }
    }
    return self;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Public methods

- (void) setAdditionalCacheFolderPath:(NSString *)anCacheFolderPath
{
    self.extraCacheFolderPath = anCacheFolderPath;
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
- (BOOL) hasDataForURI:(NSString *)uri {
    BOOL hasDataForURI = NO;
    NSData *fileData;
    NSString *fileId;
    NSString *filePath;

    if ([IRUtil isLocalFile:uri]) {
        fileData = [IRUtil localFileData:uri];
        if (fileData) {
            hasDataForURI = YES;
        }
    } else {
        fileId = [self fileIdForURI:uri];
        filePath = [self.cacheFolderPath stringByAppendingPathComponent:fileId];
        hasDataForURI = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
        if (hasDataForURI == NO) {
            fileId = [IRUtil fileNameFromPath:uri];
            filePath = [self.extraCacheFolderPath stringByAppendingPathComponent:fileId];
            hasDataForURI = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
        }
    }
    
    return hasDataForURI;
}
// --------------------------------------------------------------------------------------------------------------------
- (UIImage *) imageForURI:(NSString *)uri {
    UIImage *image = nil;
    NSData *data;
    if ([self hasDataForURI:uri]) {
        if ([IRUtil isLocalFile:uri]) {
            data = [IRUtil localFileData:uri];
        } else {
            data = [self cachedDataForURI:uri];
        }
        if (data) {
            image = [UIImage imageWithCGImage:[[UIImage imageWithData:data] CGImage]
                                        scale:[UIScreen mainScreen].scale
                                  orientation:UIImageOrientationUp];
        }
    }
    return image;
}
// --------------------------------------------------------------------------------------------------------------------
- (NSString *) dataStringForURI:(NSString *)uri {
    NSString *string = nil;
    NSData *data;
    if ([self hasDataForURI:uri]) {
        if ([IRUtil isLocalFile:uri]) {
            data = [IRUtil localFileData:uri];
        } else {
            data = [self cachedDataForURI:uri];
        }
        if (data) {
            string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }
    }
    return string;
}
// --------------------------------------------------------------------------------------------------------------------
- (NSData *) cachedDataForURI:(NSString *)uri {
    NSData *dataForURI = nil;
    NSString *fileId;
    NSString *filePath;
    if (uri) {
        fileId = [self fileIdForURI:uri];
        filePath = [self.cacheFolderPath stringByAppendingPathComponent:fileId];
        dataForURI = [NSData dataWithContentsOfFile:filePath];
        if (dataForURI == nil) {
            fileId = [IRUtil fileNameFromPath:uri];
            filePath = [self.extraCacheFolderPath stringByAppendingPathComponent:fileId];
            dataForURI = [NSData dataWithContentsOfFile:filePath];
        }
    }
    return dataForURI;
}
// --------------------------------------------------------------------------------------------------------------------
- (void) setData:(NSData *)data 
          forURI:(NSString *)uri 
{
    [[IRSimpleCache sharedInstance] setData:data forURI:uri transformURI:YES];
}
- (void) setData:(NSData *)data
          forURI:(NSString *)uri
    transformURI:(BOOL)transformURI
{
    NSString *fileId;
    if (transformURI) {
        fileId = [self fileIdForURI:uri];
    } else {
        fileId = uri;
    }
    NSString *filePath = [self.cacheFolderPath stringByAppendingPathComponent:fileId];
    // -- writeToFile will overwrite existing file if needed
    [data writeToFile:filePath atomically:YES];
}
// --------------------------------------------------------------------------------------------------------------------
- (void) clearCache {
    NSFileManager *fileManager = [NSFileManager defaultManager];
	
	NSArray *fileIdsList = [fileManager contentsOfDirectoryAtPath:self.cacheFolderPath error:NULL];
    NSString *filePath;
    for (NSString *fileId in fileIdsList) {
        filePath = [self.cacheFolderPath stringByAppendingPathComponent:fileId];
        [fileManager removeItemAtPath:filePath error:NULL];
    }
    
}
// --------------------------------------------------------------------------------------------------------------------
- (NSString *) fileIdForURI:(NSString *)uri {
    NSString *fileIdForURI;
    fileIdForURI = [self hashString:uri withSalt:@""];
    return fileIdForURI;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Private methods


- (NSString *)hashString:(NSString *)string withSalt:(NSString *)salt
{
    NSString *hash = nil;
    NSMutableString* output;

    if ([string length] > 0) {
        const char *cKey  = [salt cStringUsingEncoding:NSUTF8StringEncoding];
        const char *cData = [string cStringUsingEncoding:NSUTF8StringEncoding];
        unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
        CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);

        output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];

        for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
            [output appendFormat:@"%02x", cHMAC[i]];
        hash = output;
    }
    return hash;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Singleton object methods

+ (IRSimpleCache *)sharedInstance {
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        sharedCache = [[IRSimpleCache alloc] init];
    });
    return sharedCache;
}


@end
