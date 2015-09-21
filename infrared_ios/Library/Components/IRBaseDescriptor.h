//
// Created by Uros Milivojevic on 8/27/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#if TARGET_OS_IPHONE
    #import <UIKit/UIKit.h>
#endif
#import <Foundation/Foundation.h>
#import "IRDesctiptorDefaultKeys.h"

#if TARGET_OS_IPHONE
    #define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
    #define IS_IPHONE ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPhone" ] )
    #define IS_IPOD   ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPod touch" ] )
    #define IS_IPHONE_5 ( (IS_IPHONE || IS_IPOD) && IS_WIDESCREEN )

    #define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
    #define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
    #define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
    #define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
    #define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#endif

typedef enum {
    DataBindingModeOneWayFromData = 0,
    DataBindingModeOneWayToData = 1,
    DataBindingModeTwoWay = 2
} DataBindingMode;

@interface IRBaseDescriptor : NSObject

@property (nonatomic, strong) NSString *componentId;
@property (nonatomic) BOOL jsInit;

+ (IRBaseDescriptor *) newAppDescriptorWithDictionary:(NSDictionary *)sourceDictionary;

+ (NSArray *) newScreenDescriptorsArrayFromDictionariesArray:(NSArray *)aArray
                                                         app:(NSString *)app
                                                     version:(long long)version
                                                     baseUrl:(NSString *)baseUrl;
#if TARGET_OS_IPHONE
+ (BOOL) isDeviceTypeMatchingDevice:(NSString *)deviceType;
#endif

+ (NSMutableArray *) viewDescriptorsHierarchyFromArray:(NSArray *)aArray;

+ (IRBaseDescriptor *) newViewDescriptorWithDictionary:(NSDictionary *)sourceDictionary;

+ (IRBaseDescriptor *) newControllerDescriptorWithDictionary:(NSDictionary *)controllerDictionary
                                            screenDictionary:(NSDictionary *)screenDictionary;

#if TARGET_OS_IPHONE
+ (UIViewContentMode) contentModeFromString:(NSString *)string;
+ (UIAccessibilityTraits) accessibilityTraitsFromString:(NSString *)string
                                          forDescriptor:(IRBaseDescriptor *)descriptor;

+ (NSArray *) interfaceOrientationsFromString:(NSString *)string;

+ (UIFont *) fontFromString:(NSString *)fontString;
#endif
+ (BOOL) isSystemFamilyFontString:(NSString *)string;
+ (BOOL) isSystemRegularFontString:(NSString *)string;
+ (BOOL) isSystemBoldFontString:(NSString *)string;
+ (BOOL) isSystemItalicFontString:(NSString *)string;
#if TARGET_OS_IPHONE
+ (BOOL) isFontTextStyle:(NSString *)fontString;
#endif

#if TARGET_OS_IPHONE
+ (NSTextAlignment) textAlignmentFromString:(NSString *)string;
+ (UIBaselineAdjustment) baselineAdjustmentFromString:(NSString *)string;
+ (NSLineBreakMode) lineBreakModeFromString:(NSString *)string;
#endif

+ (CGRect) frameFromDictionary:(NSDictionary *)dictionary;
+ (CGSize) sizeFromDictionary:(NSDictionary *)dictionary;
+ (CGPoint) pointFromDictionary:(NSDictionary *)dictionary;

#if TARGET_OS_IPHONE
+ (UIEdgeInsets) edgeInsetsFromDictionary:(NSDictionary *)dictionary;

+ (UIControlContentHorizontalAlignment) contentHorizontalAlignmentFromString:(NSString *)string;
+ (UIControlContentVerticalAlignment) contentVerticalAlignmentFromString:(NSString *)string;

+ (UIButtonType) buttonTypeFromString:(NSString *)string;

+ (UITextBorderStyle) borderStyleFromString:(NSString *)string;

+ (UITextFieldViewMode) textFieldViewModeFromString:(NSString *)string;

+ (UIDataDetectorTypes) dataDetectorTypesFromString:(NSString *)string;

+ (UITextAutocapitalizationType) textAutocapitalizationTypeFromString:(NSString *)string;

+ (UITextSpellCheckingType) spellCheckingTypeFromString:(NSString *)string;

+ (UITextAutocorrectionType) autocorrectionTypeFromString:(NSString *)string;

+ (UIKeyboardType) keyboardTypeFromString:(NSString *)string;

+ (UIKeyboardAppearance) keyboardAppearanceFromString:(NSString *)string;

+ (UIReturnKeyType) returnKeyTypeFromString:(NSString *)string;

+ (UIScrollViewIndicatorStyle) scrollViewIndicatorStyleFromString:(NSString *)string;

+ (UIScrollViewKeyboardDismissMode) scrollViewKeyboardDismissModeFromString:(NSString *)string;

+ (UIProgressViewStyle) progressViewStyleFromString:(NSString *)string;

+ (UIActivityIndicatorViewStyle) activityIndicatorViewStyleFromString:(NSString *)string;

+ (UITableViewCellSeparatorStyle) separatorStyleFromString:(NSString *)string;

+ (UIDatePickerMode) datePickerModeFromString:(NSString *)string;

+ (UIBarStyle) barStyleFromString:(NSString *)string;

+ (UIBarButtonSystemItem) barButtonSystemItemFromString:(NSString *)string;

+ (UIBarButtonItemStyle) barButtonItemStyleFromString:(NSString *)string;

+ (UISearchBarStyle) searchBarStyleFromString:(NSString *)string;

+ (UITableViewStyle) tableViewStyleFromString:(NSString *)string;

+ (UITableViewCellStyle) tableViewCellStyleFromString:(NSString *)string;

+ (UITableViewCellSelectionStyle) tableViewCellSelectionStyleFromString:(NSString *)string;

+ (UITableViewCellAccessoryType) tableViewCellAccessoryTypeFromString:(NSString *)string;

+ (UITableViewCellEditingStyle) tableViewCellEditingStyleFromString:(NSString *)string;

+ (CGAffineTransform) affineTransformFromDictionary:(NSDictionary *)dictionary;

+ (UIStatusBarStyle) statusBarStyleFromString:(NSString *)string;

+ (UICollectionViewScrollDirection) scrollDirectionFromString:(NSString *)string;

+ (UIWebPaginationMode) webPaginationModeFromString:(NSString *)string;

+ (UIWebPaginationBreakingMode) webPaginationBreakingModeFromString:(NSString *)string;
#endif

+ (NSDate *)dateWithISO8601String:(NSString *)dateString;
+ (NSDate *)dateFromString:(NSString *)dateString
                withFormat:(NSString *)dateFormat;

+ (NSArray *) componentsArrayFromString:(NSString *)string;

+ (DataBindingMode) dataBindingModeForString:(NSString *)string;

#if TARGET_OS_IPHONE
+ (UIRectEdge) rectEdgeForString:(NSString *)string;
#endif

+ (NSArray *) allImagePaths;

+ (NSArray *) allJSFilesPaths;

// --------------------------------------------------------------------------------------------------------------------

+ (NSString *) componentName;
#if TARGET_OS_IPHONE
+ (Class) componentClass;

+ (Class) builderClass;

+ (void) addJSExportProtocol;
#endif

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (BOOL) isIdRequired;

- (NSDictionary *) viewDefaults;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths;

@end