//
// Created by Uros Milivojevic on 6/25/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRWebViewBuilder.h"
#import "IRWebView.h"
#import "IRViewBuilder.h"
#import "IRWebViewDescriptor.h"
#import "IRUtil.h"


@implementation IRWebViewBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRWebView *irWebView;

    irWebView = [[IRWebView alloc] init];
    [IRWebViewBuilder setUpComponent:irWebView componentDescriptor:descriptor viewController:viewController extra:extra];

    return irWebView;
}

+ (void) setUpComponent:(IRWebView *)irWebView
    componentDescriptor:(IRWebViewDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    NSString *path;
    NSURL *pathURL;
    NSURLRequest *request;

    [IRViewBuilder setUpComponent:irWebView componentDescriptor:descriptor viewController:viewController extra:extra];

    irWebView.scalesPageToFit = descriptor.scalesPageToFit;
    if (descriptor.dataDetectorTypes != UIDataDetectorTypeUnDefined) {
        irWebView.dataDetectorTypes = descriptor.dataDetectorTypes;
    }
    irWebView.allowsInlineMediaPlayback = descriptor.allowsInlineMediaPlayback;
    irWebView.mediaPlaybackAllowsAirPlay = descriptor.mediaPlaybackAllowsAirPlay;
    irWebView.suppressesIncrementalRendering = descriptor.suppressesIncrementalRendering;
    irWebView.keyboardDisplayRequiresUserAction = descriptor.keyboardDisplayRequiresUserAction;
    irWebView.paginationMode = descriptor.paginationMode;
    irWebView.paginationBreakingMode = descriptor.paginationBreakingMode;
    irWebView.pageLength = descriptor.pageLength;
    irWebView.gapBetweenPages = descriptor.gapBetweenPages;
    if ([descriptor.path length] > 0) {
        if ([IRUtil isLocalFile:descriptor.path]) {
            path = [[NSBundle mainBundle] pathForResource:descriptor.path ofType:@""];
            pathURL = [NSURL fileURLWithPath:path];
        } else {
            path = descriptor.path;
            pathURL = [NSURL URLWithString:path];
        }
        request = [NSURLRequest requestWithURL:pathURL];
        [irWebView loadRequest:request];
    }
    if ([descriptor.htmlString length] > 0) {
        [irWebView setHtmlString:descriptor.htmlString];
    }
    irWebView.scrollView.indicatorStyle = descriptor.indicatorStyle;
}

@end