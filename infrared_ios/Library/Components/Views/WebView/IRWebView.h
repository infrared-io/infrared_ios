//
// Created by Uros Milivojevic on 6/25/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRView.h"
#import "UIWebViewExport.h"

@protocol IRWebViewExport <JSExport>

- (void) setHtmlString:(NSString *)htmlString;

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRWebView : UIWebView <IRComponentInfoProtocol, UIWebViewExport, IRWebViewExport, UIViewExport, IRViewExport>

@end