//
// Created by Uros Milivojevic on 10/3/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "IRView.h"
#import "IRControlExportProtocol.h"
#import "UIControlIRExtension.h"
#import "UITextFieldExport.h"


@protocol IRTextFieldExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRTextField : UITextField <IRComponentInfoProtocol, UITextFieldExport, IRTextFieldExport, IRControlExportProtocol, UIControlIRExtensionExport, UIViewExport, IRViewExport>

@end