//
// Created by Uros Milivojevic on 4/17/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IRPickerViewObserver : NSObject <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSArray *pickerDataArray;

@end