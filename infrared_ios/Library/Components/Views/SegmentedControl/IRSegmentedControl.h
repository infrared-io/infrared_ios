//
// Created by Uros Milivojevic on 12/5/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRComponentInfoProtocol.h"
#import "IRView.h"
#import "IRControlExportProtocol.h"
#import "UIControlIRExtension.h"
#import "UISegmentedControlExport.h"

@protocol IRSegmentedControlExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRSegmentedControl : UISegmentedControl <IRComponentInfoProtocol, UISegmentedControlExport, IRSegmentedControlExport, IRControlExportProtocol, UIControlIRExtensionExport, UIViewExport, IRViewExport>
@end