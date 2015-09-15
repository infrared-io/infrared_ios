//
// Created by Uros Milivojevic on 9/14/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewExport.h"
#import "IRView.h"
#import "IRControlExportProtocol.h"
#import "UIControlIRExtension.h"
#import "UIRefreshControlExport.h"

@protocol IRRefreshControlExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRRefreshControl : UIRefreshControl  <IRComponentInfoProtocol, IRRefreshControlExport, UIRefreshControlExport, IRControlExportProtocol, UIControlIRExtensionExport, UIViewExport, IRViewExport>



@end