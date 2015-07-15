
#import <float.h>

#define CGSizeNull CGSizeMake(-1, -1)
#define UIEdgeInsetsNull UIEdgeInsetsMake(-1, -1, -1, -1)
#define CGPointNull CGPointMake(-1, -1)
#define CGFLOAT_UNDEFINED CGFLOAT_MAX
#define CGDOUBLE_UNDEFINED DBL_MAX
#define NSINTEGER_UNDEFINED NSIntegerMax
#define NSUINTEGER_UNDEFINED NSUIntegerMax
#define UIBarButtonSystemItemNone -1
#define UIDataDetectorTypeUnDefined 11


#define appKEY                          @"app"
#define appVersionKEY                   @"version"
#define silentUpdateKEY                 @"silentUpdate"
#define appLanguagesKEY                 @"languages"
#define jsLibrariesKEY                  @"jsLibraries"

#define screensKEY                      @"screens"
#define fontsKEY                        @"fonts"
#define deviceTypeKEY                   @"deviceType"
#define deviceTypePhoneKEY              @"phone"
#define deviceTypeTabletKEY             @"tablet"
#define pathKEY                         @"path"

#define supportedInterfaceOrientationsKEY @"supportedInterfaceOrientations"

#define viewKEY                         @"view"
#define hierarchyKEY                    @"hierarchy"
#define rootKEY                         @"root"
#define orientationKEY                  @"orientation"
#define orientationLandscapeKEY         @"landscape"
#define orientationPortraitKEY          @"portrait"

#define idKEY                           @"id"
#define typeKEY                         @"type"
#define typeViewKEY                     @"view"
#define typeLabelKEY                    @"label"
#define typeButtonKEY                   @"button"
#define typeImageViewKEY                @"imageView"
#define typeTextFieldKEY                @"textField"
#define typeTextViewKEY                 @"textView"
#define typeScrollViewKEY               @"scrollView"
#define typeSegmentedControlKEY         @"segmentedControl"
#define typeSliderKEY                   @"slider"
#define typeSwitchKEY                   @"switch"
#define typeStepperKEY                  @"stepper"
#define typeProgressViewKEY             @"progressView"
#define typeActivityIndicatorViewKEY    @"activityIndicatorView"
#define typeTableViewKEY                @"tableView"
#define typeTableViewCellKEY            @"tableViewCell"
#define typeCollectionViewKEY           @"collectionView"
#define typeCollectionViewCellKEY       @"collectionViewCell"
#define typeCollectionReusableViewKEY   @"collectionReusableView"
#define typePageControlKEY              @"pageControl"
#define typeDatePickerKEY               @"datePicker"
#define typePickerViewKEY               @"pickerView"
#define typeToolbarKEY                  @"toolbar"
#define typeBarButtonItemKEY            @"barButtonItem"
#define typeSearchBarKEY                @"searchBar"
#define typeNavigationBarKEY            @"navigationBar"
#define typeNavigationItemKEY           @"navigationItem"
#define typeMapViewKEY                  @"mapView"
#define typeAnnotationViewKEY           @"annotationView"
#define typePinAnnotationViewKEY        @"pinAnnotationView"
#define typeCalloutAnnotationViewKEY    @"calloutAnnotationView"
#define typeWebViewKEY                  @"webView"
#define typeViewControllerKEY           @"viewController"
#define xKEY                            @"x"
#define yKEY                            @"y"
#define widthKEY                        @"width"
#define heightKEY                       @"height"
#define topKEY                          @"top"
#define bottomKEY                       @"bottom"
#define leftKEY                         @"left"
#define rightKEY                        @"right"
#define aKEY                            @"a"
#define bKEY                            @"b"
#define cKEY                            @"c"
#define dKEY                            @"d"
#define txKEY                           @"tx"
#define tyKEY                           @"ty"
#define dataBindingKEY                  @"dataBinding"
#define restrictToOrientationsKEY       @"restrictToOrientations"
#define subviewsKEY                     @"subviews"
#define constraintsKEY                  @"constraints"
#define intrinsicContentSizePriorityKEY @"intrinsicContentSizePriority"
#define gestureRecognizersKEY           @"gestureRecognizers"
#define segmentsKEY                     @"segments"
#define cellsKEY                        @"cells"
#define sectionHeadersKEY               @"sectionHeaders"
#define sectionFootersKEY               @"sectionFooters"
#define sectionKEY                      @"section"
#define cellKEY                         @"cell"
#define rowHeightKEY                    @"rowHeight"
#define cellIdKEY                       @"cellId"
#define cellIndentationLevelKEY         @"cellIndentationLevel"
#define sectionIdKEY                    @"sectionId"
#define sectionHeaderKEY                @"sectionHeader"
#define sectionHeaderHeightKEY          @"sectionHeaderHeight"
#define sectionFooterKEY                @"sectionFooter"
#define sectionFooterHeightKEY          @"sectionFooterHeight"
#define cellSizeKEY                     @"cellSize"
#define sectionEdgeInsetsKEY            @"sectionEdgeInsets"
#define indexPathKEY                    @"indexPath"
#define titleKEY                        @"title"
#define subtitleKEY                     @"subtitle"
#define centerKEY                       @"center"
#define latitudeKEY                     @"latitude"
#define longitudeKEY                    @"longitude"
#define coordinateKEY                   @"coordinate"
#define spanKEY                         @"span"
#define latitudeDeltaKEY                @"latitudeDelta"
#define longitudeDeltaKEY               @"longitudeDelta"
#define annotationIdKEY                 @"annotationId"
#define annotationKEY                   @"annotation"
#define annotationsKEY                  @"annotations"
#define pinKEY                          @"pin"
#define calloutKEY                      @"callout"

#define controllerKEY                                  @"controller"

#define gestureRecognizerTypeKEY                       @"gestureType"
#define gestureRecognizerTypeTapKEY                    @"tap"
#define gestureRecognizerTypeSwipeKEY                  @"swipe"
#define gestureRecognizerTypePinchKEY                  @"pinch"
#define gestureRecognizerTypePanKEY                    @"pan"
#define gestureRecognizerTypeRotationKEY               @"rotation"
#define gestureRecognizerTypeLongPressKEY              @"longPress"
#define gestureRecognizerTypeScreenEdgePanKEY          @"screenEdgePan"


typedef enum {
    ObserverTypeNone,
    ObserverTypeAuto,
    ObserverTypeExistingClass
} ObserverType;