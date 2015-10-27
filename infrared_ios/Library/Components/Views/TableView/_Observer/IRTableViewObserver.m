//
// Created by Uros Milivojevic on 12/15/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRTableViewObserver.h"
#import "IRTableView.h"
#import "IRTableViewDescriptor.h"
#import "IRBaseBuilder.h"
#import "IRTableViewCellDescriptor.h"
#import "IRTableViewCell.h"
#import "IRDataController.h"
#import "IRDataBindingDescriptor.h"
#import "IRTableViewBuilder.h"
#import "IRTableViewBuilder+AutoLayout.h"
#import "IRSimpleCache.h"
#import "IRUtil.h"
#import "IRView.h"
#import "IRViewBuilder.h"

@interface IRTableViewObserver ()

@property (nonatomic, strong) NSMutableDictionary *dynamicAutolayoutRowHeightDictionary;

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@implementation IRTableViewObserver

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dynamicAutolayoutRowHeightDictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    NSDictionary *cellDictionary;
    NSArray *sectionCellsArray = nil;
    if ([self.tableDataArray count] > section) {
        cellDictionary = self.tableDataArray[section];
        sectionCellsArray = cellDictionary[cellsKEY];
    }
    return [sectionCellsArray count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    IRTableViewCell *cell = nil;
    NSDictionary *cellData = [self cellDataForIndexPath:indexPath];
    IRTableViewCellDescriptor *cellDescriptor = [self cellDescriptorForCellData:cellData
                                                                    inTableView:(IRTableView *)tableView];
    if (cellDescriptor) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellDescriptor.componentId];
        if (cell == nil) {
            cell = (id) [IRBaseBuilder buildComponentFromDescriptor:cellDescriptor
                                                     viewController:nil
                                                              extra:@{
                                                                @"data" : cellData != nil ? cellData : @{},
                                                                typeTableViewKEY : tableView,
                                                                indexPathKEY : indexPath
                                                              }];
        } else {
            [IRViewBuilder updateComponent:cell extra:@{
              @"data" : cellData != nil ? cellData : @{},
              typeTableViewKEY : tableView,
              indexPathKEY : indexPath
            }];
//            cell.componentInfo = @{
//              @"data" : cellData != nil ? cellData : @{},
//              typeTableViewKEY : tableView,
//              indexPathKEY : indexPath
//            };
        }
        IRTableViewDescriptor *tableDescriptor = (IRTableViewDescriptor *) ((IRTableView *)tableView).descriptor;
        [self bindData:cellData toCell:cell withCellItemName:tableDescriptor.cellItemName];

        if (cellDescriptor.dynamicAutolayoutRowHeight) {
            // Make sure the constraints have been added to this cell, since it may have just been created from scratch
            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];
        } else {
            [cell setNeedsLayout];
            [cell layoutIfNeeded];
//            [cell setNeedsUpdateConstraints];
//            [cell updateConstraintsIfNeeded];
        }

    } else {
        NSLog(@"Incomplete data for cell at indexPath={%d, %d}", indexPath.section, indexPath.row);
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"incomplete-data"];
        cell.textLabel.text = @"IR: Incomplete data !!!";
    }

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;              // Default is 1 if not implemented
{
    return [self.tableDataArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;    // fixed font style. use custom view (UILabel) if you want something different
{
    NSString *sectionHeader = nil;
    NSDictionary *sectionDictionary = [self sectionDataForSection:section];
    sectionHeader = sectionDictionary[sectionHeaderKEY][titleKEY];
    return sectionHeader;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;
{
    NSString *sectionFooter = nil;
    NSDictionary *sectionDictionary = [self sectionDataForSection:section];
    sectionFooter = sectionDictionary[sectionFooterKEY][titleKEY];
    return sectionFooter;
}

// Editing

// Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
{
    BOOL canEdit;
    IRTableViewDescriptor *tableDescriptor = (IRTableViewDescriptor *) ((IRTableView *)tableView).descriptor;
    canEdit = tableDescriptor.editing;
    return canEdit;
}

// Moving/reordering

// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return NO;
}

// Index

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView;                                                    // return list of section titles to display in section index view (e.g. "ABCD...Z#")
{
    return nil;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;  // tell table which section corresponds to section title/index (e.g. "B",1))
{
    return -1;
}

// Data manipulation - insert and delete support

// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
// Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"tableView:commitEditingStyle:forRowAtIndexPath:");
}

// Data manipulation - reorder / moving support

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;
{

}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - UITableViewDelegate

// Display customization

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{

}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
{

}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
{

}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0);
{

}
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
{

}
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
{

}

// Variable height support

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CGFloat height = CGFLOAT_UNDEFINED;
    IRTableView *irTableView;
    IRTableViewCellDescriptor *cellDescriptor;
    NSDictionary *cellData = [self cellDataForIndexPath:indexPath];
    NSNumber *number = cellData[rowHeightKEY];
    if (number) {
        height = [number floatValue];
    } else {
        cellDescriptor = [self cellDescriptorForCellData:cellData inTableView:(IRTableView *)tableView];

        if (cellDescriptor.dynamicAutolayoutRowHeight) {
            IRTableViewCell *cell = self.dynamicAutolayoutRowHeightDictionary[cellDescriptor.componentId];
            if (cell == nil) {
                cell = (id) [IRBaseBuilder buildComponentFromDescriptor:cellDescriptor
                                                         viewController:nil
                                                                  extra:@{
                                                                    @"data" : cellData != nil ? cellData : @{},
                                                                    typeTableViewKEY : tableView,
                                                                    indexPathKEY : indexPath
                                                                  }];
                self.dynamicAutolayoutRowHeightDictionary[cellDescriptor.componentId] = cell;
            }

            IRTableViewDescriptor *tableDescriptor = (IRTableViewDescriptor *) ((IRTableView *) tableView).descriptor;
            [self bindData:cellData toCell:cell withCellItemName:tableDescriptor.cellItemName];

            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];

            CGFloat width = CGRectGetWidth(tableView.bounds);
            NSInteger indentationLevel = [self tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
            width -= indentationLevel * cell.indentationWidth;
            cell.bounds = CGRectMake(0.0f, 0.0f, width, CGRectGetHeight(cell.bounds));
            [cell setNeedsLayout];
            [cell layoutIfNeeded];
            CGSize aRect = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
            height = aRect.height;
            height += 1;
            if (height < cellDescriptor.dynamicAutolayoutRowHeightMinimum && cellDescriptor.dynamicAutolayoutRowHeightMinimum != CGFLOAT_UNDEFINED) {
                height = cellDescriptor.dynamicAutolayoutRowHeightMinimum;
            }
        } else {
            height = cellDescriptor.rowHeight;
        }
        if (height == CGFLOAT_UNDEFINED) {
            irTableView = (IRTableView *) tableView;
            height = ((IRTableViewDescriptor *) irTableView.descriptor).rowHeight;
        }
        if (height == CGFLOAT_UNDEFINED) {
            height = UITableViewAutomaticDimension;
        }
    }
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    CGFloat height;
    IRTableView *irTableView;
    NSDictionary *sectionDictionary = [self sectionDataForSection:section][sectionHeaderKEY];
    NSNumber *number = sectionDictionary[sectionHeaderHeightKEY];
    if (number) {
        height = [number floatValue];
    } else {
        irTableView = (IRTableView *) tableView;
        height = ((IRTableViewDescriptor *) irTableView.descriptor).sectionHeaderHeight;
        if (height == CGFLOAT_UNDEFINED) {
            height = UITableViewAutomaticDimension;
        }
    }
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    CGFloat height;
    IRTableView *irTableView = (IRTableView *) tableView;
    NSDictionary *sectionDictionary = [self sectionDataForSection:section][sectionFooterKEY];
    NSNumber *number = sectionDictionary[sectionFooterHeightKEY];
    if (number) {
        height = [number floatValue];
    } else {
        height = ((IRTableViewDescriptor *) irTableView.descriptor).sectionFooterHeight;
        if (height == CGFLOAT_UNDEFINED) {
            height = UITableViewAutomaticDimension;
        }
    }
    return height;
}

// Use the estimatedHeight methods to quickly calcuate guessed values which will allow for fast load times of the table.
// If these methods are implemented, the above -tableView:heightForXXX calls will be deferred until views are ready to be displayed, so more expensive logic can be placed there.
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0);
//{
//    return [self tableView:tableView heightForRowAtIndexPath:indexPath];
//}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0);
//{
//    return [self tableView:tableView heightForHeaderInSection:section];
//}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0);
//{
//    return [self tableView:tableView heightForFooterInSection:section];
//}

// Section header & footer information. Views are preferred over title should you decide to provide both

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;   // custom view for header. will be adjusted to default or specified header height
{
    IRView *headerView = nil;
    NSDictionary *sectionData = [self sectionDataForSection:section][sectionHeaderKEY];
    IRViewDescriptor *sectionHeaderDescriptor = [self sectionHeaderDescriptorForData:sectionData
                                                                         inTableView:(IRTableView *) tableView];
    if (sectionHeaderDescriptor) {
        headerView = [IRBaseBuilder buildComponentFromDescriptor:sectionHeaderDescriptor
                                                  viewController:nil
                                                           extra:@{
                                                             @"data" : sectionData != nil ? sectionData : @{},
                                                             typeTableViewKEY : tableView,
                                                             sectionKEY : @(section)
                                                           }];
        [IRTableViewBuilder addAutoLayoutConstraintsForView:headerView inRootViews:@[headerView]];
        headerView.translatesAutoresizingMaskIntoConstraints = YES;
        IRTableViewDescriptor *tableDescriptor = (IRTableViewDescriptor *) ((IRTableView *)tableView).descriptor;
        [self bindData:sectionData toView:headerView withSectionItemName:tableDescriptor.sectionItemName];
    }
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;   // custom view for footer. will be adjusted to default or specified footer height
{
    IRView *footerView = nil;
    NSDictionary *sectionData = [self sectionDataForSection:section][sectionFooterKEY];
    IRViewDescriptor *sectionFooterDescriptor = [self sectionFooterDescriptorForData:sectionData
                                                                         inTableView:(IRTableView *) tableView];
    if (sectionFooterDescriptor) {
        footerView = [IRBaseBuilder buildComponentFromDescriptor:sectionFooterDescriptor
                                                  viewController:nil
                                                           extra:@{
                                                             @"data" : sectionData != nil ? sectionData : @{},
                                                             typeTableViewKEY : tableView,
                                                             sectionKEY : @(section)
                                                           }];
        [IRTableViewBuilder addAutoLayoutConstraintsForView:footerView inRootViews:@[footerView]];
        footerView.translatesAutoresizingMaskIntoConstraints = YES;
        IRTableViewDescriptor *tableDescriptor = (IRTableViewDescriptor *) ((IRTableView *)tableView).descriptor;
        [self bindData:sectionData toView:footerView withSectionItemName:tableDescriptor.sectionItemName];
    }
    return footerView;
}

// Accessories (disclosures).

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
{
    NSString *action;
    NSDictionary *cellData = [self cellDataForIndexPath:indexPath];
    IRTableViewCellDescriptor *cellDescriptor = [self cellDescriptorForCellData:cellData
                                                                    inTableView:(IRTableView *)tableView];
    if ([cellDescriptor.accessoryButtonAction length] > 0) {
        action = cellDescriptor.accessoryButtonAction;
    } else {
        IRTableViewDescriptor *tableDescriptor = (IRTableViewDescriptor *) ((IRTableView *) tableView).descriptor;
        action = tableDescriptor.accessoryButtonAction;
    }
    [IRTableViewObserver executeAction:action withData:cellData tableView:tableView indexPath:indexPath];
}

// Selection

// -tableView:shouldHighlightRowAtIndexPath: is called when a touch comes down on a row.
// Returning NO to that message halts the selection process and does not cause the currently selected row to lose its selected look while the touch is down.
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0);
{
    return YES;
}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0);
{

}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0);
{

}

// Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSIndexPath *indexPathReturnValue;
    NSDictionary *cellData = [self cellDataForIndexPath:indexPath];
    IRTableViewCellDescriptor *cellDescriptor = [self cellDescriptorForCellData:cellData
                                                                    inTableView:(IRTableView *)tableView];
    if (cellDescriptor.disableSelectRowAction) {
       indexPathReturnValue = nil;
    } else {
        IRTableViewDescriptor *tableDescriptor = (IRTableViewDescriptor *) ((IRTableView *)tableView).descriptor;
        if (tableDescriptor.disableSelectRowAction) {
            indexPathReturnValue = nil;
        } else {
            indexPathReturnValue = indexPath;
        }
    }
    return indexPathReturnValue;
}
- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
// Called after the user changes the selection.
{
    return indexPath;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    // evaluate Action
    NSString *action;
    NSDictionary *cellData = [self cellDataForIndexPath:indexPath];
    IRTableViewCellDescriptor *cellDescriptor = [self cellDescriptorForCellData:cellData
                                                                    inTableView:(IRTableView *)tableView];
    if ([cellDescriptor.selectRowAction length] > 0) {
        action = cellDescriptor.selectRowAction;
    } else {
        IRTableViewDescriptor *tableDescriptor = (IRTableViewDescriptor *) ((IRTableView *) tableView).descriptor;
        action = tableDescriptor.selectRowAction;
    }
    [IRTableViewObserver executeAction:action withData:cellData tableView:tableView indexPath:indexPath];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
{

}

// Editing

// Allows customization of the editingStyle for a particular cell located at 'indexPath'. If not implemented, all editable cells will have UITableViewCellEditingStyleDelete set for them when the table has editing property set to YES.
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCellEditingStyle tableViewCellEditingStyle;
    NSDictionary *cellData = [self cellDataForIndexPath:indexPath];
    IRTableViewCellDescriptor *cellDescriptor = [self cellDescriptorForCellData:cellData
                                                                    inTableView:(IRTableView *)tableView];
    tableViewCellEditingStyle = cellDescriptor.editingStyle;
    return tableViewCellEditingStyle;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
{
    return @"Delete";
}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0); // supercedes -tableView:titleForDeleteConfirmationButtonForRowAtIndexPath: if return value is non-nil
{
    return nil;
}

// Controls whether the background is indented while editing.  If not implemented, the default is YES.  This is unrelated to the indentation level below.  This method only applies to grouped style table views.
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return YES;
}

// The willBegin/didEnd methods are called whenever the 'editing' property is automatically changed by the table (allowing insert/delete/move). This is done by a swipe activating a single row
- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath;
{

}
- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath;
{

}

// Moving/reordering

// Allows customization of the target row for a particular row as it is being moved/reordered
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath;
{
    return proposedDestinationIndexPath;
}

// Indentation

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath; // return 'depth' of row for hierarchies
{
    NSInteger indentation;
    NSDictionary *cellData = [self cellDataForIndexPath:indexPath];
    if (cellData[cellIndentationLevelKEY]) {
        indentation = [cellData[cellIndentationLevelKEY] integerValue];
    } else {
        indentation = 0;
    }
    return indentation;
}

// Copy/Paste.  All three methods must be implemented by the delegate.

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(5_0);
{
    return NO;
}
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender NS_AVAILABLE_IOS(5_0);
{
    return YES;
}
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender NS_AVAILABLE_IOS(5_0);
{

}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Private methods

- (NSDictionary *) sectionDataForSection:(NSInteger)section
{
    NSDictionary *sectionDictionary = nil;
    if ([self.tableDataArray count] > section) {
        sectionDictionary = self.tableDataArray[section];
    }
    return sectionDictionary;
}

- (IRViewDescriptor *) sectionHeaderDescriptorForData:(NSDictionary *)sectionData
                                          inTableView:(IRTableView *)tableView
{
    IRViewDescriptor *viewDescriptor = nil;
    IRTableViewDescriptor *tableDescriptor = (IRTableViewDescriptor *) tableView.descriptor;
    NSArray *viewDescriptorsArray = tableDescriptor.sectionHeadersArray;
    NSString *sectionId = sectionData[sectionIdKEY];
    viewDescriptor = [self viewDescriptorWithId:sectionId fromDescriptors:viewDescriptorsArray];
    return viewDescriptor;
}

- (IRViewDescriptor *) sectionFooterDescriptorForData:(NSDictionary *)sectionData
                                          inTableView:(IRTableView *)tableView
{
    IRViewDescriptor *viewDescriptor = nil;
    IRTableViewDescriptor *tableDescriptor = (IRTableViewDescriptor *) tableView.descriptor;
    NSArray *viewDescriptorsArray = tableDescriptor.sectionFootersArray;
    NSString *sectionId = sectionData[sectionIdKEY];
    viewDescriptor = [self viewDescriptorWithId:sectionId fromDescriptors:viewDescriptorsArray];
    return viewDescriptor;
}

- (IRViewDescriptor *) viewDescriptorWithId:(NSString *)sectionId
                            fromDescriptors:(NSArray *)descriptors
{
    IRViewDescriptor *viewDescriptor = nil;
    if (sectionId) {
        for (IRViewDescriptor *anViewDescriptor in descriptors) {
            if ([anViewDescriptor.componentId isEqualToString:sectionId]) {
                viewDescriptor = anViewDescriptor;
                break;
            }
        }
    } else {
        if ([descriptors count] > 0) {
            viewDescriptor = descriptors[0];
        }
    }
    return viewDescriptor;
}

- (void) bindData:(NSDictionary *)dictionary
             toView:(IRView *)view
withSectionItemName:(NSString *)name
{
    [IRBaseBuilder bindData:dictionary toView:view withDataBindingItemName:name];
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (NSDictionary *) cellDataForIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cellDictionary = nil;
    NSDictionary *sectionDictionary = [self sectionDataForSection:indexPath.section];
    NSArray *array = sectionDictionary[cellsKEY];
    if ([array count] > indexPath.row) {
        cellDictionary = array[indexPath.row];
    }
    return cellDictionary;
}

- (IRTableViewCellDescriptor *) cellDescriptorForCellData:(NSDictionary *)cellData
                                              inTableView:(IRTableView *)tableView
{
    IRTableViewCellDescriptor *cellDescriptor = nil;
    IRTableViewDescriptor *tableDescriptor = (IRTableViewDescriptor *) tableView.descriptor;
    NSArray *cellDescriptorsArray = tableDescriptor.cellsArray;
    NSString *cellId = cellData[cellIdKEY];
    if (cellId) {
        for (IRTableViewCellDescriptor *anCellDescriptor in cellDescriptorsArray) {
            if ([anCellDescriptor.componentId isEqualToString:cellId]) {
                cellDescriptor = anCellDescriptor;
                break;
            }
        }
    } else {
        if ([cellDescriptorsArray count] > 0) {
            cellDescriptor = cellDescriptorsArray[0];
        }
    }
    return cellDescriptor;
}

- (void) bindData:(NSDictionary *)dictionary
           toCell:(IRTableViewCell *)cell
 withCellItemName:(NSString *)name
{
    [IRBaseBuilder bindData:dictionary toView:cell withDataBindingItemName:name];
    NSArray *cellComponentsArray = cell.contentView.subviews;
    for (IRView *anView in cellComponentsArray) {
        [IRBaseBuilder bindData:dictionary toView:anView withDataBindingItemName:name];
    }
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

+ (void) executeAction:(NSString *)action
              withData:(id)data
             tableView:(UITableView *)tableView
             indexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (tableView) {
        dictionary[@"tableView"] = tableView;
    }
    if (indexPath) {
        dictionary[@"indexPath"] = indexPath;
    }
    if (data) {
        dictionary[@"data"] = data;
    }
    [IRBaseBuilder executeAction:action withDictionary:dictionary sourceView:tableView];
}

@end