//
// Created by Uros Milivojevic on 4/3/15.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol NSDataExport <JSExport>

@property (readonly) NSUInteger length;
/*
 The -bytes method returns a pointer to a contiguous region of memory managed by the receiver.
 If the regions of memory represented by the receiver are already contiguous, it does so in O(1) time, otherwise it may take longer
 Using -enumerateByteRangesUsingBlock: will be efficient for both contiguous and discontiguous data.
 */
@property (readonly) const void *bytes NS_RETURNS_INNER_POINTER;

#pragma mark - NSExtendedData

@property (readonly, copy) NSString *description;
- (void)getBytes:(void *)buffer length:(NSUInteger)length;
- (void)getBytes:(void *)buffer range:(NSRange)range;
- (BOOL)isEqualToData:(NSData *)other;
- (NSData *)subdataWithRange:(NSRange)range;
- (BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile;
- (BOOL)writeToURL:(NSURL *)url atomically:(BOOL)atomically; // the atomically flag is ignored if the url is not of a type the supports atomic writes
- (BOOL)writeToFile:(NSString *)path options:(NSDataWritingOptions)writeOptionsMask error:(NSError **)errorPtr;
- (BOOL)writeToURL:(NSURL *)url options:(NSDataWritingOptions)writeOptionsMask error:(NSError **)errorPtr;
- (NSRange)rangeOfData:(NSData *)dataToFind options:(NSDataSearchOptions)mask range:(NSRange)searchRange NS_AVAILABLE(10_6, 4_0);

/*
 'block' is called once for each contiguous region of memory in the receiver (once total for contiguous NSDatas), until either all bytes have been enumerated, or the 'stop' parameter is set to YES.
 */
- (void) enumerateByteRangesUsingBlock:(void (^)(const void *bytes, NSRange byteRange, BOOL *stop))block NS_AVAILABLE(10_9, 7_0);

#pragma mark - NSDataCreation

+ (instancetype)data;
+ (instancetype)dataWithBytes:(const void *)bytes length:(NSUInteger)length;
+ (instancetype)dataWithBytesNoCopy:(void *)bytes length:(NSUInteger)length;
+ (instancetype)dataWithBytesNoCopy:(void *)bytes length:(NSUInteger)length freeWhenDone:(BOOL)b;
+ (instancetype)dataWithContentsOfFile:(NSString *)path options:(NSDataReadingOptions)readOptionsMask error:(NSError **)errorPtr;
+ (instancetype)dataWithContentsOfURL:(NSURL *)url options:(NSDataReadingOptions)readOptionsMask error:(NSError **)errorPtr;
+ (instancetype)dataWithContentsOfFile:(NSString *)path;
+ (instancetype)dataWithContentsOfURL:(NSURL *)url;
//- (instancetype)initWithBytes:(const void *)bytes length:(NSUInteger)length;
//- (instancetype)initWithBytesNoCopy:(void *)bytes length:(NSUInteger)length;
//- (instancetype)initWithBytesNoCopy:(void *)bytes length:(NSUInteger)length freeWhenDone:(BOOL)b;
//- (instancetype)initWithBytesNoCopy:(void *)bytes length:(NSUInteger)length deallocator:(void (^)(void *bytes, NSUInteger length))deallocator NS_AVAILABLE(10_9, 7_0);
//- (instancetype)initWithContentsOfFile:(NSString *)path options:(NSDataReadingOptions)readOptionsMask error:(NSError **)errorPtr;
//- (instancetype)initWithContentsOfURL:(NSURL *)url options:(NSDataReadingOptions)readOptionsMask error:(NSError **)errorPtr;
//- (instancetype)initWithContentsOfFile:(NSString *)path;
//- (instancetype)initWithContentsOfURL:(NSURL *)url;
//- (instancetype)initWithData:(NSData *)data;
+ (instancetype)dataWithData:(NSData *)data;

#pragma mark - NSDataBase64Encoding

/* Create an NSData from a Base-64 encoded NSString using the given options. By default, returns nil when the input is not recognized as valid Base-64.
*/
//- (instancetype)initWithBase64EncodedString:(NSString *)base64String options:(NSDataBase64DecodingOptions)options NS_AVAILABLE(10_9, 7_0);

/* Create a Base-64 encoded NSString from the receiver's contents using the given options.
*/
- (NSString *)base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)options NS_AVAILABLE(10_9, 7_0);

/* Create an NSData from a Base-64, UTF-8 encoded NSData. By default, returns nil when the input is not recognized as valid Base-64.
*/
//- (instancetype)initWithBase64EncodedData:(NSData *)base64Data options:(NSDataBase64DecodingOptions)options NS_AVAILABLE(10_9, 7_0);

/* Create a Base-64, UTF-8 encoded NSData from the receiver's contents using the given options.
*/
- (NSData *)base64EncodedDataWithOptions:(NSDataBase64EncodingOptions)options NS_AVAILABLE(10_9, 7_0);

@end