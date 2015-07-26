//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRControlExportProtocol.h"
#import "IRView.h"
#import "UIControlIRExtension.h"
#import "UIDatePickerExport.h"


@protocol IRDatePickerExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRDatePicker : UIDatePicker <IRComponentInfoProtocol, UIDatePickerExport, IRDatePickerExport, IRControlExportProtocol, UIControlIRExtensionExport, UIViewExport, IRViewExport>

@end