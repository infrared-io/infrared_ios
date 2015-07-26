//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRView.h"
#import "UIPickerViewExport.h"

@class IRPickerViewObserver;

@protocol IRPickerViewExport <JSExport>

- (void) setPickerData:(NSArray *)pickerData;

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRPickerView : UIPickerView <IRComponentInfoProtocol, UIPickerViewExport, IRPickerViewExport, UIViewExport, IRViewExport>

@property (nonatomic, strong) IRPickerViewObserver *observer;

@end