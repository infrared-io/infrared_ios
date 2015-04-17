//
// Created by Uros Milivojevic on 4/17/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRPickerViewObserver.h"
#import "IRPickerViewDescriptor.h"
#import "IRBaseBuilder.h"
#import "IRPickerView.h"


@implementation IRPickerViewObserver

#pragma mark - UIPickerViewDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return [self.pickerDataArray count];
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger numberOfRowsInComponent = 0;
    if ([self.pickerDataArray count] > component) {
        numberOfRowsInComponent = [self.pickerDataArray[component] count];
    }
    return numberOfRowsInComponent;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - UIPickerViewDelegate

// returns width of column and height of row for each component.
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
//{
//    return pickerView.frame.size.width/([self numberOfComponentsInPickerView:pickerView]);
//}
//- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
//{
//    return 40;
//}

// these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
// If you return back a different object, the old one will be released. the view will be centered in the row rect
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *rowString = [self stringForRow:row component:component];
    return rowString;
}
//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component NS_AVAILABLE_IOS(6_0) // attributed title is favored if both methods are implemented
//{
//    return nil;
//}
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
//{
//    return nil;
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *action;
    NSDictionary *cellData = [self dataForRow:row component:component];
    IRPickerViewDescriptor *pickerViewDescriptor = (IRPickerViewDescriptor *) ((IRPickerView *)pickerView).descriptor;
    action = pickerViewDescriptor.selectRowAction;
    [IRPickerViewObserver executeAction:action withData:cellData pickerView:pickerView row:row component:component];
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Private methods

- (NSString *) stringForRow:(NSInteger)row
                  component:(NSInteger)component
{
    NSString *rowString = nil;
    NSArray *rowsArray;
    if ([self.pickerDataArray count] > component) {
        rowsArray = self.pickerDataArray[component];
        if ([rowsArray count] > row) {
            rowString = rowsArray[row];
        }
    }
    return rowString;
}

- (NSDictionary *) dataForRow:(NSInteger)row
                    component:(NSInteger)component
{
    NSDictionary *rowData = nil;
    NSArray *rowsArray;
    if ([self.pickerDataArray count] > component) {
        rowsArray = self.pickerDataArray[component];
        if ([rowsArray count] > row) {
            rowData = rowsArray[row];
        }
    }
    return rowData;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

+ (void) executeAction:(NSString *)action
              withData:(id)data
            pickerView:(UIPickerView *)pickerView
                   row:(NSInteger)row
             component:(NSInteger)component
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (pickerView) {
        dictionary[@"pickerView"] = pickerView;
    }
    dictionary[@"row"] = @(row);
    dictionary[@"component"] = @(component);
    if (data) {
        dictionary[@"data"] = data;
    }
    [IRBaseBuilder executeAction:action withDictionary:dictionary sourceView:pickerView];
}

@end