//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRView.h"
#import "UIPickerViewExport.h"

@class IRPickerViewObserver;

@protocol IRPickerViewExport <JSExport>

//@property(nonatomic,assign) id<UIPickerViewDataSource> dataSource;                // default is nil. weak reference
//@property(nonatomic,assign) id<UIPickerViewDelegate>   delegate;                  // default is nil. weak reference
//@property(nonatomic)        BOOL                       showsSelectionIndicator;   // default is NO
//
//// info that was fetched and cached from the data source and delegate
//@property(nonatomic,readonly) NSInteger numberOfComponents;
//- (NSInteger)numberOfRowsInComponent:(NSInteger)component;
//- (CGSize)rowSizeForComponent:(NSInteger)component;
//
//// returns the view provided by the delegate via pickerView:viewForRow:forComponent:reusingView:
//// or nil if the row/component is not visible or the delegate does not implement
//// pickerView:viewForRow:forComponent:reusingView:
//- (UIView *)viewForRow:(NSInteger)row forComponent:(NSInteger)component;
//
//// Reloading whole view or single component
//- (void)reloadAllComponents;
//- (void)reloadComponent:(NSInteger)component;
//
//// selection. in this case, it means showing the appropriate row in the middle
//- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;  // scrolls the specified row to center.
//
//- (NSInteger)selectedRowInComponent:(NSInteger)component;                                   // returns selected row. -1 if nothing selected

// -----------------------------------------------------------------------------------

- (void) setPickerData:(NSArray *)pickerData;

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRPickerView : UIPickerView <IRComponentInfoProtocol, UIPickerViewExport, IRPickerViewExport, UIViewExport, IRViewExport>

@property (nonatomic, strong) IRPickerViewObserver *observer;

@end