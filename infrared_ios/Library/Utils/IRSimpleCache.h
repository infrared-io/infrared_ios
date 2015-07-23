//
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IRSimpleCache : NSObject {
    NSString *cacheFolderPath;
}

+ (IRSimpleCache *)sharedInstance;

- (void) setAdditionalCacheFolderPath:(NSString *)anCacheFolderPath;

- (BOOL) hasDataForURI:(NSString *)uri;
#if TARGET_OS_IPHONE
- (UIImage *) imageForURI:(NSString *)uri;
#endif
- (NSString *) dataStringForURI:(NSString *)uri;
- (NSData *) cachedDataForURI:(NSString *)uri;
- (void) setData:(NSData *)data
          forURI:(NSString *)uri;
- (void) setData:(NSData *)data
          forURI:(NSString *)uri
    transformURI:(BOOL)transformURI;
- (void) clearCache;

- (NSString *) fileIdForURI:(NSString *)uri;

@end
