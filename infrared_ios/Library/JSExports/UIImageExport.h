//
// Created by Uros Milivojevic on 3/10/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol UIImageExport <JSExport>

+ (UIImage *)imageNamed:(NSString *)name;      // load from main bundle
+ (UIImage *)imageNamed:(NSString *)name inBundle:(NSBundle *)bundle compatibleWithTraitCollection:(UITraitCollection *)traitCollection;

+ (UIImage *)imageWithContentsOfFile:(NSString *)path;
+ (UIImage *)imageWithData:(NSData *)data;
+ (UIImage *)imageWithData:(NSData *)data scale:(CGFloat)scale NS_AVAILABLE_IOS(6_0);
+ (UIImage *)imageWithCGImage:(CGImageRef)cgImage;
+ (UIImage *)imageWithCGImage:(CGImageRef)cgImage scale:(CGFloat)scale orientation:(UIImageOrientation)orientation NS_AVAILABLE_IOS(4_0);
+ (UIImage *)imageWithCIImage:(CIImage *)ciImage NS_AVAILABLE_IOS(5_0);
+ (UIImage *)imageWithCIImage:(CIImage *)ciImage scale:(CGFloat)scale orientation:(UIImageOrientation)orientation NS_AVAILABLE_IOS(6_0);

//- (instancetype)initWithContentsOfFile:(NSString *)path;
//- (instancetype)initWithData:(NSData *)data;
//- (instancetype)initWithData:(NSData *)data scale:(CGFloat)scale NS_AVAILABLE_IOS(6_0);
//- (instancetype)initWithCGImage:(CGImageRef)cgImage;
//- (instancetype)initWithCGImage:(CGImageRef)cgImage scale:(CGFloat)scale orientation:(UIImageOrientation)orientation NS_AVAILABLE_IOS(4_0);
//- (instancetype)initWithCIImage:(CIImage *)ciImage NS_AVAILABLE_IOS(5_0);
//- (instancetype)initWithCIImage:(CIImage *)ciImage scale:(CGFloat)scale orientation:(UIImageOrientation)orientation NS_AVAILABLE_IOS(6_0);

@property(nonatomic,readonly) CGSize             size;             // reflects orientation setting. In iOS 4.0 and later, this is measured in points. In 3.x and earlier, measured in pixels
@property(nonatomic,readonly) CGImageRef         CGImage;          // returns underlying CGImageRef or nil if CIImage based
- (CGImageRef)CGImage NS_RETURNS_INNER_POINTER CF_RETURNS_NOT_RETAINED;
@property(nonatomic,readonly) CIImage           *CIImage NS_AVAILABLE_IOS(5_0); // returns underlying CIImage or nil if CGImageRef based
@property(nonatomic,readonly) UIImageOrientation imageOrientation; // this will affect how the image is composited
@property(nonatomic,readonly) CGFloat            scale NS_AVAILABLE_IOS(4_0);

// animated images. When set as UIImageView.image, animation will play in an infinite loop until removed. Drawing will render the first image

+ (UIImage *)animatedImageNamed:(NSString *)name duration:(NSTimeInterval)duration NS_AVAILABLE_IOS(5_0);  // read sequence of files with suffix starting at 0 or 1
+ (UIImage *)animatedResizableImageNamed:(NSString *)name capInsets:(UIEdgeInsets)capInsets duration:(NSTimeInterval)duration NS_AVAILABLE_IOS(5_0); // sequence of files
+ (UIImage *)animatedResizableImageNamed:(NSString *)name capInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode duration:(NSTimeInterval)duration NS_AVAILABLE_IOS(6_0);
+ (UIImage *)animatedImageWithImages:(NSArray *)images duration:(NSTimeInterval)duration NS_AVAILABLE_IOS(5_0);

@property(nonatomic,readonly) NSArray       *images   NS_AVAILABLE_IOS(5_0); // default is nil for non-animated images
@property(nonatomic,readonly) NSTimeInterval duration NS_AVAILABLE_IOS(5_0); // total duration for all frames. default is 0 for non-animated images

// the these draw the image 'right side up' in the usual coordinate system with 'point' being the top-left.

- (void)drawAtPoint:(CGPoint)point;                                                        // mode = kCGBlendModeNormal, alpha = 1.0
- (void)drawAtPoint:(CGPoint)point blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;
- (void)drawInRect:(CGRect)rect;                                                           // mode = kCGBlendModeNormal, alpha = 1.0
- (void)drawInRect:(CGRect)rect blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;

- (void)drawAsPatternInRect:(CGRect)rect; // draws the image as a CGPattern

- (UIImage *)resizableImageWithCapInsets:(UIEdgeInsets)capInsets NS_AVAILABLE_IOS(5_0); // create a resizable version of this image. the interior is tiled when drawn.
- (UIImage *)resizableImageWithCapInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode NS_AVAILABLE_IOS(6_0); // the interior is resized according to the resizingMode

@property(nonatomic,readonly) UIEdgeInsets capInsets               NS_AVAILABLE_IOS(5_0);   // default is UIEdgeInsetsZero for non resizable images
@property(nonatomic,readonly) UIImageResizingMode resizingMode NS_AVAILABLE_IOS(6_0); // default is UIImageResizingModeTile

// Support for constraint-based layout (auto layout)
// The alignmentRectInsets of a UIImage are used by UIImageView and other UIView and UIControl
//  subclasses that take custom images to determine the view's alignment rect insets for
//  constraint-based layout.
// The default alignmentRectInsets are UIEdgeInsetsZero.
- (UIImage *)imageWithAlignmentRectInsets:(UIEdgeInsets)alignmentInsets NS_AVAILABLE_IOS(6_0);
@property(nonatomic,readonly) UIEdgeInsets alignmentRectInsets NS_AVAILABLE_IOS(6_0);

// Create a version of this image with the specified rendering mode. By default, images have a rendering mode of UIImageRenderingModeAutomatic.
- (UIImage *)imageWithRenderingMode:(UIImageRenderingMode)renderingMode NS_AVAILABLE_IOS(7_0);
@property(nonatomic, readonly) UIImageRenderingMode renderingMode NS_AVAILABLE_IOS(7_0);

@end