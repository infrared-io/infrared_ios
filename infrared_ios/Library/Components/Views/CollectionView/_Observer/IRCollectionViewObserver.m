//
// Created by Uros Milivojevic on 6/19/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRCollectionViewObserver.h"
#import "IRDesctiptorDefaultKeys.h"
#import "IRCollectionViewCellDescriptor.h"
#import "IRCollectionViewDescriptor.h"
#import "IRCollectionView.h"
#import "IRCollectionViewCell.h"
#import "IRBaseBuilder.h"
#import "IRCollectionViewCellBuilder.h"
#import "IRViewController.h"
#import "IRCollectionReusableView.h"
#import "IRCollectionReusableViewBuilder.h"
#import "IRTableViewBuilder.h"
#import "IRTableViewBuilder+AutoLayout.h"


@implementation IRCollectionViewObserver

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    NSDictionary *cellDictionary;
    NSArray *sectionCellsArray = nil;
    if ([self.collectionDataArray count] > section) {
        cellDictionary = self.collectionDataArray[section];
        sectionCellsArray = cellDictionary[cellsKEY];
    }
    return [sectionCellsArray count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IRCollectionViewCell *cell = nil;
    IRCollectionViewDescriptor *tableDescriptor;
    NSDictionary *cellData = [self cellDataForIndexPath:indexPath];
    IRCollectionViewCellDescriptor *cellDescriptor = [self cellDescriptorForCellData:cellData
                                                                    inCollectionView:(IRCollectionView *) collectionView];
    if (cellDescriptor) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellDescriptor.componentId
                                                         forIndexPath:indexPath];
        if (cell.setUpDone == NO) {
            cell.setUpDone = YES;
            [IRCollectionViewCellBuilder extendedSetUpComponent:cell
                                            componentDescriptor:cellDescriptor
                                                 viewController:nil
                                                          extra:@{
                                                            @"data" : cellData != nil ? cellData : @{},
                                                            typeCollectionViewKEY : collectionView,
                                                            indexPathKEY : indexPath
                                                          }];
        } else {
            cell.componentInfo = @{
              @"data" : cellData != nil ? cellData : @{},
              typeCollectionViewKEY : collectionView,
              indexPathKEY : indexPath
            };
        }
        tableDescriptor = (IRCollectionViewDescriptor *) ((IRCollectionView *)collectionView).descriptor;
        [self bindData:cellData toCell:cell withCellItemName:tableDescriptor.cellItemName];
    } else {
        NSLog(@"No Cell Descriptor");
    }
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.collectionDataArray count];
}

//// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    IRCollectionReusableView *reusableView = nil;
    BOOL setUpReusableView = NO;
    NSDictionary *sectionData;
    IRViewDescriptor *descriptor;
    if ([UICollectionElementKindSectionHeader isEqualToString:kind]) {
        sectionData = [self sectionDataForSection:indexPath.section][sectionHeaderKEY];
        descriptor = [self sectionHeaderDescriptorForData:sectionData
                                         inCollectionView:(IRCollectionView *)collectionView];
        if (sectionData && descriptor) {
            reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                              withReuseIdentifier:descriptor.componentId
                                                                     forIndexPath:indexPath];
            setUpReusableView = YES;
        } else {
            reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                              withReuseIdentifier:@"UICollectionElementKindSectionHeader"
                                                                     forIndexPath:indexPath];
        }
    } else if ([UICollectionElementKindSectionFooter isEqualToString:kind]) {
        sectionData = [self sectionDataForSection:indexPath.section][sectionFooterKEY];
        descriptor = [self sectionFooterDescriptorForData:sectionData
                                         inCollectionView:(IRCollectionView *)collectionView];
        if (sectionData && descriptor) {
            reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                              withReuseIdentifier:descriptor.componentId
                                                                     forIndexPath:indexPath];
            setUpReusableView = YES;
        } else {
            reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                              withReuseIdentifier:@"UICollectionElementKindSectionFooter"
                                                                     forIndexPath:indexPath];
        }
    }
    if (setUpReusableView) {
        if (reusableView.setUpDone == NO) {
            reusableView.setUpDone = YES;
            [IRCollectionReusableViewBuilder setUpComponent:reusableView
                                        componentDescriptor:descriptor
                                             viewController:nil
                                                      extra:@{
                                                        @"data" : sectionData != nil ? sectionData : @{},
                                                        typeCollectionViewKEY : collectionView,
                                                        indexPathKEY : indexPath
                                                      }];
            [IRTableViewBuilder addAutoLayoutConstraintsForView:reusableView inRootViews:@[reusableView]];
            IRCollectionViewDescriptor *tableDescriptor = (IRCollectionViewDescriptor *) ((IRCollectionView *)collectionView).descriptor;
            [self bindData:sectionData toView:reusableView withSectionItemName:tableDescriptor.sectionItemName];
        } else {
            reusableView.componentInfo = @{
              @"data" : sectionData != nil ? sectionData : @{},
              typeCollectionViewKEY : collectionView,
              indexPathKEY : indexPath
            };
        }
    }
    return reusableView;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - UICollectionViewDelegate

// Methods for notification of selection/deselection and highlight/unhighlight events.
// The sequence of calls leading to selection from a user touch is:
//
// (when the touch begins)
// 1. -collectionView:shouldHighlightItemAtIndexPath:
// 2. -collectionView:didHighlightItemAtIndexPath:
//
// (when the touch lifts)
// 3. -collectionView:shouldSelectItemAtIndexPath: or -collectionView:shouldDeselectItemAtIndexPath:
// 4. -collectionView:didSelectItemAtIndexPath: or -collectionView:didDeselectItemAtIndexPath:
// 5. -collectionView:didUnhighlightItemAtIndexPath:
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"collectionView:didHighlightItemAtIndexPath:");
//}
//- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"collectionView:didUnhighlightItemAtIndexPath:");
//}
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
////// called when the user taps on an already-selected item in multi-select mode
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    [collectionView deselectItemAtIndexPath:indexPath animated:YES];

    // evaluate Action
    NSString *action;
    IRCollectionViewDescriptor *tableDescriptor;
    NSDictionary *cellData = [self cellDataForIndexPath:indexPath];
    IRCollectionViewCellDescriptor *cellDescriptor = [self cellDescriptorForCellData:cellData
                                                                    inCollectionView:(IRCollectionView *)collectionView];
    if ([cellDescriptor.selectItemAction length] > 0) {
        action = cellDescriptor.selectItemAction;
    } else {
        tableDescriptor = (IRCollectionViewDescriptor *) ((IRCollectionView *) collectionView).descriptor;
        action = tableDescriptor.selectItemAction;
    }
    [IRCollectionViewObserver executeAction:action withData:cellData collectionView:collectionView indexPath:indexPath];
}
//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"collectionView:didDeselectItemAtIndexPath:");
//}

//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0)
//{
//
//}
//- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view
//        forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0)
//{
//
//}
//- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}
//- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
//{
//
//}
//
//// These methods provide support for copy/paste actions on cells.
//// All three should be implemented if any are.
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}
//- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
//{
//
//}
//- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
//{
//
//}
//
//// support for custom transition layout
//- (UICollectionViewTransitionLayout *)collectionView:(UICollectionView *)collectionView
//                        transitionLayoutForOldLayout:(UICollectionViewLayout *)fromLayout
//                                           newLayout:(UICollectionViewLayout *)toLayout
//{
//
//}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize cellSize = CGSizeZero;
    IRCollectionView *irCollectionView;
    IRCollectionViewCellDescriptor *cellDescriptor;
    NSDictionary *cellData = [self cellDataForIndexPath:indexPath];
    NSDictionary *dictionary = cellData[cellSizeKEY];
    if (dictionary) {
        cellSize = [IRBaseDescriptor sizeFromDictionary:dictionary];
    } else {
        cellDescriptor = [self cellDescriptorForCellData:cellData
                                        inCollectionView:(IRCollectionView *) collectionView];
        if (cellDescriptor) {
            if (CGSizeEqualToSize(cellDescriptor.cellSize, CGSizeZero) == NO) {
                cellSize = cellDescriptor.cellSize;
            }
        }
        if (CGSizeEqualToSize(cellSize, CGSizeZero)) {
            irCollectionView = (IRCollectionView *) collectionView;
            cellSize = ((IRCollectionViewDescriptor *) irCollectionView.descriptor).cellSize;
        }
    }
    return cellSize;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets edgeInsets;
    IRCollectionView *irCollectionView;
    NSDictionary *cellData = [self sectionDataForSection:section];
    NSDictionary *dictionary = cellData[sectionEdgeInsetsKEY];
    if (dictionary) {
        edgeInsets = [IRBaseDescriptor edgeInsetsFromDictionary:dictionary];
    } else {
        irCollectionView = (IRCollectionView *) collectionView;
        edgeInsets = ((IRCollectionViewDescriptor *) irCollectionView.descriptor).sectionEdgeInsets;
    }
    if (UIEdgeInsetsEqualToEdgeInsets(edgeInsets, UIEdgeInsetsNull)) {
        edgeInsets = UIEdgeInsetsZero;
    }
    return edgeInsets;
}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//
//}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize headerSize;
    CGFloat height;
    IRCollectionView *irCollectionView;
    NSDictionary *sectionDictionary = [self sectionDataForSection:section][sectionHeaderKEY];
    NSNumber *number = sectionDictionary[sectionHeaderHeightKEY];
    if (number) {
        height = [number floatValue];
        headerSize = CGSizeMake(100, height);
    } else {
        irCollectionView = (IRCollectionView *) collectionView;
        height = ((IRCollectionViewDescriptor *) irCollectionView.descriptor).sectionHeaderHeight;
        if (height == CGFLOAT_UNDEFINED) {
            height = 0;
        }
        headerSize = CGSizeMake(100, height);
    }
    return headerSize;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize footerSize;
    CGFloat height;
    IRCollectionView *irCollectionView;
    NSDictionary *sectionDictionary = [self sectionDataForSection:section][sectionFooterKEY];
    NSNumber *number = sectionDictionary[sectionFooterHeightKEY];
    if (number) {
        height = [number floatValue];
        footerSize = CGSizeMake(100, height);
    } else {
        irCollectionView = (IRCollectionView *) collectionView;
        height = ((IRCollectionViewDescriptor *) irCollectionView.descriptor).sectionFooterHeight;
        if (height == CGFLOAT_UNDEFINED) {
            height = 0;
        }
        footerSize = CGSizeMake(100, height);
    }
    return footerSize;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Private methods

- (NSDictionary *) sectionDataForSection:(NSInteger)section
{
    NSDictionary *sectionDictionary = nil;
    if ([self.collectionDataArray count] > section) {
        sectionDictionary = self.collectionDataArray[section];
    }
    return sectionDictionary;
}

- (IRViewDescriptor *) sectionHeaderDescriptorForData:(NSDictionary *)sectionData
                                     inCollectionView:(IRCollectionView *)collectionView
{
    IRViewDescriptor *viewDescriptor = nil;
    IRCollectionViewDescriptor *collectionViewDescriptor = (IRCollectionViewDescriptor *) collectionView.descriptor;
    NSArray *viewDescriptorsArray = collectionViewDescriptor.sectionHeadersArray;
    NSString *sectionId = sectionData[sectionIdKEY];
    viewDescriptor = [self viewDescriptorWithId:sectionId fromDescriptors:viewDescriptorsArray];
    return viewDescriptor;
}

- (IRViewDescriptor *) sectionFooterDescriptorForData:(NSDictionary *)sectionData
                                     inCollectionView:(IRCollectionView *)collectionView
{
    IRViewDescriptor *viewDescriptor = nil;
    IRCollectionViewDescriptor *collectionViewDescriptor = (IRCollectionViewDescriptor *) collectionView.descriptor;
    NSArray *viewDescriptorsArray = collectionViewDescriptor.sectionFootersArray;
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

- (IRCollectionViewCellDescriptor *) cellDescriptorForCellData:(NSDictionary *)cellData
                                              inCollectionView:(IRCollectionView *)collectionView
{
    IRCollectionViewCellDescriptor *cellDescriptor = nil;
    IRCollectionViewDescriptor *collectionDescriptor = (IRCollectionViewDescriptor *) collectionView.descriptor;
    NSArray *cellDescriptorsArray = collectionDescriptor.cellsArray;
    NSString *cellId = cellData[cellIdKEY];
    if (cellId) {
        for (IRCollectionViewCellDescriptor *anCellDescriptor in cellDescriptorsArray) {
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
           toCell:(IRCollectionViewCell *)cell
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
        collectionView:(UICollectionView *)collectionView
             indexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (collectionView) {
        dictionary[@"collectionView"] = collectionView;
    }
    if (indexPath) {
        dictionary[@"indexPath"] = indexPath;
    }
    if (data) {
        dictionary[@"data"] = data;
    }
    [IRBaseBuilder executeAction:action withDictionary:dictionary sourceView:collectionView];
}

@end