//
// Created by Uros Milivojevic on 6/25/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRView.h"
#import "UIWebViewExport.h"

@protocol IRWebViewExport <JSExport>

//@property (nonatomic, assign) id <UIWebViewDelegate> delegate;
//
//@property (nonatomic, readonly, retain) UIScrollView *scrollView NS_AVAILABLE_IOS(5_0);
//
//- (void)loadRequest:(NSURLRequest *)request;
//- (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL;
//- (void)loadData:(NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)textEncodingName baseURL:(NSURL *)baseURL;
//
//@property (nonatomic, readonly, retain) NSURLRequest *request;
//
//- (void)reload;
//- (void)stopLoading;
//
//- (void)goBack;
//- (void)goForward;
//
//@property (nonatomic, readonly, getter=canGoBack) BOOL canGoBack;
//@property (nonatomic, readonly, getter=canGoForward) BOOL canGoForward;
//@property (nonatomic, readonly, getter=isLoading) BOOL loading;
//
//- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script;
//
//@property (nonatomic) BOOL scalesPageToFit;
//
//@property (nonatomic) BOOL detectsPhoneNumbers NS_DEPRECATED_IOS(2_0, 3_0);
//@property (nonatomic) UIDataDetectorTypes dataDetectorTypes NS_AVAILABLE_IOS(3_0);
//
//@property (nonatomic) BOOL allowsInlineMediaPlayback NS_AVAILABLE_IOS(4_0); // iPhone Safari defaults to NO. iPad Safari defaults to YES
//@property (nonatomic) BOOL mediaPlaybackRequiresUserAction NS_AVAILABLE_IOS(4_0); // iPhone and iPad Safari both default to YES
//
//@property (nonatomic) BOOL mediaPlaybackAllowsAirPlay NS_AVAILABLE_IOS(5_0); // iPhone and iPad Safari both default to YES
//
//@property (nonatomic) BOOL suppressesIncrementalRendering NS_AVAILABLE_IOS(6_0); // iPhone and iPad Safari both default to NO
//
//@property (nonatomic) BOOL keyboardDisplayRequiresUserAction NS_AVAILABLE_IOS(6_0); // default is YES
//
//@property (nonatomic) UIWebPaginationMode paginationMode NS_AVAILABLE_IOS(7_0);
//@property (nonatomic) UIWebPaginationBreakingMode paginationBreakingMode NS_AVAILABLE_IOS(7_0);
//@property (nonatomic) CGFloat pageLength NS_AVAILABLE_IOS(7_0);
//@property (nonatomic) CGFloat gapBetweenPages NS_AVAILABLE_IOS(7_0);
//@property (nonatomic, readonly) NSUInteger pageCount NS_AVAILABLE_IOS(7_0);

// -----------------------------------------------------------------------------------

- (void) setHtmlString:(NSString *)htmlString;

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRWebView : UIWebView <IRComponentInfoProtocol, UIWebViewExport, IRWebViewExport, UIViewExport, IRViewExport>

@end