//
// Created by Uros Milivojevic on 10/26/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRTableViewHeaderOrFooter.h"
#import "IRLabel.h"
#import "IRTableViewHeaderOrFooterDescriptor.h"


@implementation IRTableViewHeaderOrFooter

- (void)layoutSubviews
{
    [super layoutSubviews];

    if (((IRTableViewHeaderOrFooterDescriptor *)self.descriptor).dynamicAutolayoutHeight) {
        // Make sure the contentView does a layout pass here so that its subviews have their frames set, which we
        // need to use to set the preferredMaxLayoutWidth below.
//        [self/*.contentView*/ setNeedsLayout];
//        [self/*.contentView*/ layoutIfNeeded];

        // Set the preferredMaxLayoutWidth of the mutli-line bodyLabel based on the evaluated width of the label's frame,
        // as this will allow the text to wrap correctly, and as a result allow the label to take on the correct height.
        [self setPreferredMaxLayoutWidth:self/*.contentView*/];
    }
}

- (void) setPreferredMaxLayoutWidth:(IRView *)irView
{
    IRLabel *irLabel;
    CGFloat preferredMaxLayoutWidth;
    for (IRView *anSubview in irView.subviews) {
        if ([anSubview isKindOfClass:[IRLabel class]]) {
            irLabel = (IRLabel *)anSubview;
            if (irLabel.numberOfLines > 1 || irLabel.numberOfLines == 0) {
                preferredMaxLayoutWidth = CGRectGetWidth(irLabel.frame);
                irLabel.preferredMaxLayoutWidth = preferredMaxLayoutWidth;
            }
        } else if ([anSubview conformsToProtocol:@protocol(IRComponentInfoProtocol)]) {
            [self setPreferredMaxLayoutWidth:anSubview];
        }
    }
}

@end