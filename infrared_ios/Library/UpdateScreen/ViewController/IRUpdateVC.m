//
// Created by Uros Milivojevic on 12/1/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRUpdateVC.h"
#import "IRGlobal.h"
#import "IRLabel.h"
#import "IRProgressView.h"

@interface IRUpdateVC ()

@property (nonatomic) float totalPercentage;
@property (nonatomic) NSInteger currentGroupCount;
@property (nonatomic) float currentGroupPercentage;

@property (nonatomic, strong) IRLabel *titleLabel;
@property (nonatomic, strong) IRProgressView *progressView;

@end

// -------------------------------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------------------------------

@implementation IRUpdateVC

- (void) viewDidLoad
{
    [super viewDidLoad];

    self.totalPercentage = 0;

    self.titleLabel = (IRLabel *)[self viewWithId:@"update_label"];
    self.progressView = (IRProgressView *)[self viewWithId:@"update_progress"];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTitle:) name:IR_LOADING_TITLE_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNewProgressGroup:) name:IR_FILES_TO_PROCESS_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSingleProgress:) name:IR_FILE_READY_NOTIFICATION object:nil];
}

// -------------------------------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------------------------------

- (void) updateTitle:(NSNotification *)notification
{
    NSString *title = notification.object;
//    NSLog(@"IRUpdateVC-updateTitle: title=%@", title);
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *formattedTitle = [NSString stringWithFormat:@"Loading %@ ...", [title lowercaseString]];
        self.titleLabel.text = formattedTitle;
    });
}
- (void) updateNewProgressGroup:(NSNotification *)notification
{
    NSDictionary *dictionary = notification.object;
    self.currentGroupCount = [dictionary[IR_FILES_TO_PROCESS_COUNT] integerValue];
    self.currentGroupPercentage = [dictionary[IR_FILES_TO_PROCESS_PERCENTAGE] floatValue];

    if (self.currentGroupCount == 0) {
        self.totalPercentage += self.currentGroupPercentage;
    }
    [self updateProgress];
}
- (void) updateSingleProgress:(NSNotification *)notification
{
    self.totalPercentage += self.currentGroupPercentage*(1.0/self.currentGroupCount);
    [self updateProgress];
}

// -------------------------------------------------------------------------------------------------------------------

- (void) updateProgress
{
    CGFloat progress = (float) (self.totalPercentage / 100.0);
//    NSLog(@"progress: %1.3f", progress);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressView.progress = progress;
    });
}

// -------------------------------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------------------------------

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:IR_LOADING_TITLE_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:IR_FILES_TO_PROCESS_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:IR_FILE_READY_NOTIFICATION object:nil];
}

@end