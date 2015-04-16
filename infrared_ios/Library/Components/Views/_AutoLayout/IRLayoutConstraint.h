//
// Created by Uros Milivojevic on 10/13/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "IRComponentInfoProtocol.h"

@protocol IRLayoutConstraintExport <JSExport>

/* If a constraint's priority level is less than UILayoutPriorityRequired, then it is optional.  Higher priority constraints are met before lower priority constraints.
 Constraint satisfaction is not all or nothing.  If a constraint 'a == b' is optional, that means we will attempt to minimize 'abs(a-b)'.
 This property may only be modified as part of initial set up.  An exception will be thrown if it is set after a constraint has been added to a view.
 */
@property UILayoutPriority priority;

/* When a view is archived, it archives some but not all constraints in its -constraints array.  The value of shouldBeArchived informs UIView if a particular constraint should be archived by UIView.
 If a constraint is created at runtime in response to the state of the object, it isn't appropriate to archive the constraint - rather you archive the state that gives rise to the constraint.  Since the majority of constraints that should be archived are created in Interface Builder (which is smart enough to set this prop to YES), the default value for this property is NO.
 */
@property BOOL shouldBeArchived;

/* accessors
 firstItem.firstAttribute {==,<=,>=} secondItem.secondAttribute * multiplier + constant
 */
@property (readonly, assign) id firstItem;
@property (readonly) NSLayoutAttribute firstAttribute;
@property (readonly) NSLayoutRelation relation;
@property (readonly, assign) id secondItem;
@property (readonly) NSLayoutAttribute secondAttribute;
@property (readonly) CGFloat multiplier;

/* Unlike the other properties, the constant may be modified after constraint creation.  Setting the constant on an existing constraint performs much better than removing the constraint and adding a new one that's just like the old but for having a new constant.
 */
@property CGFloat constant;

/* The receiver may be activated or deactivated by manipulating this property.  Only active constraints affect the calculated layout.  Attempting to activate a constraint whose items have no common ancestor will cause an exception to be thrown.  Defaults to NO for newly created constraints. */
@property (getter=isActive) BOOL active NS_AVAILABLE(10_10, 8_0);

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRLayoutConstraint : NSLayoutConstraint <IRComponentInfoProtocol, IRLayoutConstraintExport>



@end