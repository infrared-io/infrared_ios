//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRComponentInfoProtocol.h"
#import "IRControlExportProtocol.h"
#import "IRView.h"
#import "UIControlIRExtension.h"
#import "UIStepperExport.h"


@protocol IRStepperExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRStepper : UIStepper <IRComponentInfoProtocol, UIStepperExport, IRStepperExport, IRControlExportProtocol, UIControlIRExtensionExport, UIViewExport, IRViewExport>
@end