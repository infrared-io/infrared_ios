//
// Created by Uros Milivojevic on 6/25/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRWebViewDescriptor.h"
#if TARGET_OS_IPHONE
#import "IRWebViewBuilder.h"
#import "IRWebView.h"
#import "UIScrollViewExport.h"
#endif


@implementation IRWebViewDescriptor

+ (NSString *) componentName
{
    return typeWebViewKEY;
}
#if TARGET_OS_IPHONE
+ (Class) componentClass
{
    return [IRWebView class];
}

+ (Class) builderClass
{
    return [IRWebViewBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([UIWebView class], @protocol(UIWebViewExport));
    @try {
//        class_addProtocol(NSClassFromString(@"_UIWebViewScrollView"), @protocol(UIScrollViewExport));
        class_addProtocol(NSClassFromString(@"UIWebScrollView"), @protocol(UIScrollViewExport));
    }
    @catch (NSException *exception) {
        NSLog(@"Exception when adding UIScrollViewExport to WebView: %@, %@", exception, [exception userInfo]);
    }
}
#endif

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;

        // scalesPageToFit
        number = aDictionary[NSStringFromSelector(@selector(scalesPageToFit))];
        if (number) {
            self.scalesPageToFit = [number boolValue];
        } else {
            self.scalesPageToFit = NO;
        }

#if TARGET_OS_IPHONE
        // dataDetectorTypes
        string = aDictionary[NSStringFromSelector(@selector(dataDetectorTypes))];
        self.dataDetectorTypes = [IRBaseDescriptor dataDetectorTypesFromString:string];
#endif

        // allowsInlineMediaPlayback
        number = aDictionary[NSStringFromSelector(@selector(allowsInlineMediaPlayback))];
        if (number) {
            self.allowsInlineMediaPlayback = [number boolValue];
        } else {
#if TARGET_OS_IPHONE
            if (IS_IPHONE)
#else
            if (YES)
#endif
            {
                self.allowsInlineMediaPlayback = NO;
            } else {
                self.allowsInlineMediaPlayback = YES;
            }
        }

        // mediaPlaybackRequiresUserAction
        number = aDictionary[NSStringFromSelector(@selector(mediaPlaybackRequiresUserAction))];
        if (number) {
            self.mediaPlaybackRequiresUserAction = [number boolValue];
        } else {
            self.mediaPlaybackRequiresUserAction = YES;
        }

        // mediaPlaybackAllowsAirPlay
        number = aDictionary[NSStringFromSelector(@selector(mediaPlaybackAllowsAirPlay))];
        if (number) {
            self.mediaPlaybackAllowsAirPlay = [number boolValue];
        } else {
            self.mediaPlaybackAllowsAirPlay = YES;
        }

        // suppressesIncrementalRendering
        number = aDictionary[NSStringFromSelector(@selector(suppressesIncrementalRendering))];
        if (number) {
            self.suppressesIncrementalRendering = [number boolValue];
        } else {
            self.suppressesIncrementalRendering = NO;
        }

        // keyboardDisplayRequiresUserAction
        number = aDictionary[NSStringFromSelector(@selector(keyboardDisplayRequiresUserAction))];
        if (number) {
            self.keyboardDisplayRequiresUserAction = [number boolValue];
        } else {
            self.keyboardDisplayRequiresUserAction = YES;
        }

#if TARGET_OS_IPHONE
        // paginationMode
        string = aDictionary[NSStringFromSelector(@selector(paginationMode))];
        self.paginationMode = [IRBaseDescriptor webPaginationModeFromString:string];

        // paginationBreakingMode
        string = aDictionary[NSStringFromSelector(@selector(paginationBreakingMode))];
        self.paginationBreakingMode = [IRBaseDescriptor webPaginationBreakingModeFromString:string];
#endif

        // pageLength
        number = aDictionary[NSStringFromSelector(@selector(pageLength))];
        if (number) {
            self.pageLength = [number floatValue];
        } else {
            self.pageLength = 0;
        }

        // gapBetweenPages
        number = aDictionary[NSStringFromSelector(@selector(gapBetweenPages))];
        if (number) {
            self.gapBetweenPages = [number floatValue];
        } else {
            self.gapBetweenPages = 0;
        }

        // path
        string = aDictionary[NSStringFromSelector(@selector(path))];
        self.path = string;

        // htmlString
        string = aDictionary[NSStringFromSelector(@selector(htmlString))];
        self.htmlString = string;

        // openAllLinksInSafari
        number = aDictionary[NSStringFromSelector(@selector(openAllLinksInSafari))];
        if (number) {
            self.openAllLinksInSafari = [number boolValue];
        } else {
            self.openAllLinksInSafari = NO;
        }
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{

}

@end