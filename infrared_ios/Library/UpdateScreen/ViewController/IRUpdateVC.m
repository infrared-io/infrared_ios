//
// Created by Uros Milivojevic on 12/1/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRUpdateVC.h"
#import "IRGlobal.h"
#import "IRLabel.h"

@interface IRUpdateVC ()

@property (nonatomic) float totalPercentage;
@property (nonatomic) NSInteger currentGroupCount;
@property (nonatomic) float currentGroupPercentage;

@end

// -------------------------------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------------------------------

@implementation IRUpdateVC

- (void) viewDidLoad
{
    [super viewDidLoad];

    self.totalPercentage = 0;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTitle:) name:IR_LOADING_TITLE_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNewProgressGroup:) name:IR_FILES_TO_PROCESS_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSingleProgress:) name:IR_FILE_READY_NOTIFICATION object:nil];
}

// -------------------------------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------------------------------

- (void) updateTitle:(NSNotification *)notification
{
    NSLog(@"IRUpdateVC-updateTitle: title=%@", notification.object);
    IRLabel *titleLabel = (IRLabel *)[self viewWithId:@"update_label"];
    titleLabel.text = notification.object;
}
- (void) updateNewProgressGroup:(NSNotification *)notification
{
    NSDictionary *dictionary = notification.object;
    self.currentGroupCount = [dictionary[IR_FILES_TO_PROCESS_COUNT] integerValue];
    self.currentGroupPercentage = [dictionary[IR_FILES_TO_PROCESS_PERCENTAGE] floatValue];
}
- (void) updateSingleProgress:(NSNotification *)notification
{
    self.totalPercentage += self.currentGroupPercentage*(1.0/self.currentGroupCount);
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