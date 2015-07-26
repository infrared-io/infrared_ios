//
// Created by Uros Milivojevic on 12/5/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRView.h"
#import "IRControlExportProtocol.h"
#import "IRScrollView.h"
#import "UITextViewExport.h"

@protocol IRTextViewExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRTextView : UITextView <IRComponentInfoProtocol, UITextViewExport, IRTextViewExport, UIScrollViewExport, IRScrollViewExport, UIViewExport, IRViewExport>

@end