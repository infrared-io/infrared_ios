//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRComponentInfoProtocol.h"
#import "IRView.h"
#import "IRTableViewCell.h"
#import "IRBaseBuilder.h"
#import "IRBaseDescriptor.h"
#import "IRViewDescriptor.h"
#import "IRTableViewCellDescriptor.h"
#import "IRLabel.h"


@implementation IRTableViewCell

@synthesize componentInfo;
@synthesize descriptor;

- (instancetype) initWithStyle:(UITableViewCellStyle)style
               reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    if (((IRTableViewCellDescriptor *)self.descriptor).dynamicAutolayoutRowHeight) {
        // Make sure the contentView does a layout pass here so that its subviews have their frames set, which we
        // need to use to set the preferredMaxLayoutWidth below.
        [self.contentView setNeedsLayout];
        [self.contentView layoutIfNeeded];

        // Set the preferredMaxLayoutWidth of the mutli-line bodyLabel based on the evaluated width of the label's frame,
        // as this will allow the text to wrap correctly, and as a result allow the label to take on the correct height.
        [self setPreferredMaxLayoutWidth:self.contentView];
    }
}


- (void)setFrame:(CGRect)frame {
    CGFloat indentationInset;
    if (self.indentationLevel > 0) {
        indentationInset = [self indentationInset];
        frame.origin.x += indentationInset;
        frame.size.width -= indentationInset;
    }
    [super setFrame:frame];
}

- (void) setPreferredMaxLayoutWidth:(IRView *)irView
{
    IRLabel *irLabel;
    CGFloat preferredMaxLayoutWidth;
    CGFloat indentationInset;
    for (IRView *anSubview in irView.subviews) {
        if ([anSubview isKindOfClass:[IRLabel class]]) {
            irLabel = (IRLabel *)anSubview;
            if (irLabel.numberOfLines > 1 || irLabel.numberOfLines == 0) {
                preferredMaxLayoutWidth = CGRectGetWidth(irLabel.frame);
                if (self.indentationLevel > 0) {
                    indentationInset = [self indentationInset];
                    preferredMaxLayoutWidth -= indentationInset;
                }
                irLabel.preferredMaxLayoutWidth = preferredMaxLayoutWidth;
            }
        } else if ([anSubview conformsToProtocol:@protocol(IRComponentInfoProtocol)]) {
            [self setPreferredMaxLayoutWidth:anSubview];
        }
    }

}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Create

+ (id) createWithComponentId:(NSString *)componentId
{
    IRTableViewCell *irTableViewCell = [[IRTableViewCell alloc] init];
    irTableViewCell.descriptor = [[IRTableViewCellDescriptor alloc] init];
    [IRBaseBuilder setComponentId:componentId toJSInitComponent:irTableViewCell];
    return irTableViewCell;
}

- (NSString *) componentId
{
    return self.descriptor.componentId;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Private

- (CGFloat) indentationInset
{
    CGFloat indentationInset = 0;
    if (self.indentationLevel > 0) {
        indentationInset = self.indentationLevel * self.indentationWidth;
    }
    return indentationInset;
}

@end