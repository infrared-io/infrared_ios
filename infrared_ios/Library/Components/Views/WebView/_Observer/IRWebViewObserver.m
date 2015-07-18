//
// Created by Uros Milivojevic on 7/18/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRWebViewObserver.h"
#import "IRWebView.h"
#import "IRWebViewDescriptor.h"


@implementation IRWebViewObserver

- (BOOL)webView:(UIWebView *)webView
  shouldStartLoadWithRequest:(NSURLRequest *)request
  navigationType:(UIWebViewNavigationType)navigationType
{
    IRWebView *irWebView = (IRWebView *) webView;
    IRWebViewDescriptor *descriptor = (IRWebViewDescriptor *) irWebView.descriptor;
    if (descriptor.openAllLinksInSafari) {
        if ( navigationType == UIWebViewNavigationTypeLinkClicked ) { // UIWebViewNavigationTypeOther
            [[UIApplication sharedApplication] openURL:[request URL]];
            return NO;
        }
    }
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{

}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{

}
- (void)webView:(UIWebView *)webView
  didFailLoadWithError:(NSError *)error
{

}

@end