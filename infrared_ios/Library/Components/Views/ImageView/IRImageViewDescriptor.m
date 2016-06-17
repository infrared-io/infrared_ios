//
//  IRImageViewDescriptor.m
//  infrared_ios
//
//  Created by Uros Milivojevic on 8/25/14.
//  Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRImageViewDescriptor.h"
#import "IRUtil.h"
#if TARGET_OS_IPHONE
#import "IRImageViewBuilder.h"
#import "IRImageView.h"
#endif

@implementation IRImageViewDescriptor

+ (NSString *) componentName
{
    return typeImageViewKEY;
}
#if TARGET_OS_IPHONE
+ (Class) componentClass
{
    return [IRImageView class];
}

+ (Class) builderClass
{
    return [IRImageViewBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([UIImageView class], @protocol(UIImageViewExport));
}
#endif

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;
        NSDictionary *dictionary;

        // image
        string = aDictionary[NSStringFromSelector(@selector(image))];
        self.image = string;

        // highlightedImage
        string = aDictionary[NSStringFromSelector(@selector(highlightedImage))];
        self.highlightedImage = string;

        // highlighted
        number = aDictionary[NSStringFromSelector(@selector(highlighted))];
        if (number) {
            self.highlighted = [number boolValue];
        } else {
            self.highlighted = NO;
        }

#if TARGET_OS_IPHONE
        // imageCapInsets
        dictionary = aDictionary[NSStringFromSelector(@selector(imageCapInsets))];
        self.imageCapInsets = [IRBaseDescriptor edgeInsetsFromDictionary:dictionary];

        // highlightedImageCapInsets
        dictionary = aDictionary[NSStringFromSelector(@selector(highlightedImageCapInsets))];
        self.highlightedImageCapInsets = [IRBaseDescriptor edgeInsetsFromDictionary:dictionary];
#endif

        // preserveAspectRatio
//        number = aDictionary[NSStringFromSelector(@selector(preserveAspectRatio))];
//        if (number) {
//            self.preserveAspectRatio = [number boolValue];
//        } else {
//            self.preserveAspectRatio = NO;
//        }
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
                 appDescriptor:(IRAppDescriptor *)appDescriptor
{
    if (self.image && [IRUtil isFileForDownload:self.image appDescriptor:appDescriptor]) {
        [imagePaths addObject:self.image];
    }
    if (self.highlightedImage && [IRUtil isFileForDownload:self.highlightedImage appDescriptor:appDescriptor]) {
        [imagePaths addObject:self.highlightedImage];
    }
}


@end
