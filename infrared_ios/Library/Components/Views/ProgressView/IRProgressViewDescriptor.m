//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRProgressViewDescriptor.h"
#import "IRUtil.h"
#if TARGET_OS_IPHONE
#import "IRProgressViewBuilder.h"
#import "IRProgressView.h"
#endif


@implementation IRProgressViewDescriptor

+ (NSString *) componentName
{
    return typeProgressViewKEY;
}
#if TARGET_OS_IPHONE
+ (Class) componentClass
{
    return [IRProgressView class];
}

+ (Class) builderClass
{
    return [IRProgressViewBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([UIProgressView class], @protocol(UIProgressViewExport));
}
#endif

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;

#if TARGET_OS_IPHONE
        // progressViewStyle
        string = aDictionary[NSStringFromSelector(@selector(progressViewStyle))];
        self.progressViewStyle = [IRBaseDescriptor progressViewStyleFromString:string];
#endif

        // progress
        number = aDictionary[NSStringFromSelector(@selector(progress))];
        if (number) {
            self.progress = [number floatValue];
        } else {
            self.progress = 0;
        }

#if TARGET_OS_IPHONE
        // progressTintColor
        string = aDictionary[NSStringFromSelector(@selector(progressTintColor))];
        self.progressTintColor = [IRUtil transformHexColorToUIColor:string];

        // trackTintColor
        string = aDictionary[NSStringFromSelector(@selector(trackTintColor))];
        self.trackTintColor = [IRUtil transformHexColorToUIColor:string];
#endif

        // progressImage
        string = aDictionary[NSStringFromSelector(@selector(progressImage))];
        self.progressImage = string;

        // trackImage
        string = aDictionary[NSStringFromSelector(@selector(trackImage))];
        self.trackImage = string;
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{
    if (self.progressImage && [IRUtil isFileForDownload:self.progressImage]) {
        [imagePaths addObject:self.progressImage];
    }
    if (self.trackImage && [IRUtil isFileForDownload:self.trackImage]) {
        [imagePaths addObject:self.trackImage];
    }
}

@end