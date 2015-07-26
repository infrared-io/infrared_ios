//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRComponentInfoProtocol.h"
#import "IRControlExportProtocol.h"
#import "IRView.h"
#import "UIControlIRExtension.h"
#import "UIPageControlExport.h"

@protocol IRPageControlExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRPageControl : UIPageControl  <IRComponentInfoProtocol, UIPageControlExport, IRPageControlExport, IRControlExportProtocol, UIControlIRExtensionExport, UIViewExport, IRViewExport>

@end