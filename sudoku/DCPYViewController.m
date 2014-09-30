//
//  PJViewController.m
//  sudoku
//
//  Created by Jean Sung and Paula Yuan on 9/11/14.
//  Copyright (c) 2014 Paula Jean. All rights reserved.
//

#import "DCPYViewController.h"

@interface DCPYViewController () {
    DCPYGridView* _gridView;
    DCPYGridModel* _gridModel;
    DCPYNumPadView* _numPadView;
    UIImageView* _backgroundView;
    NSTimer* _timer;
    UILabel* _timerLabel;
    NSDate* _startDate;
    UIColor* _darkBlue;
    UIAlertView* _winAlert;
}

@end

@implementation DCPYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _darkBlue = [UIColor colorWithRed: .1 green: .2 blue: .5 alpha: 1];
    
    _winAlert = [[UIAlertView alloc] initWithTitle:@"Congratulations!!!" message:@"YOU WIN!!!" delegate:nil cancelButtonTitle:@"YAY!!" otherButtonTitles:nil, nil];
    
    // Initialize the Grid Model
    _gridModel = [[DCPYGridModel alloc] init];
    
    // Create a frame
    CGRect frame = self.view.frame;
    
    // Create timer label
    CGRect timerFrame = CGRectMake(CGRectGetWidth(frame) / 2 - 35, CGRectGetHeight(frame) * .05, 80, 50);
    _timerLabel = [[UILabel alloc] initWithFrame:timerFrame];
    _timerLabel.font = [UIFont systemFontOfSize: 30];
    [_timerLabel setTextColor:_darkBlue];
    
    // Set background image
    UIImage* background = [UIImage imageNamed:@"bg.jpg"];
    _backgroundView = [[UIImageView alloc] initWithImage:background];
    [self.view addSubview:_backgroundView];
    
    // Create a grid frame
    CGFloat x = CGRectGetWidth(frame) * 0.1;
    CGFloat y = CGRectGetHeight(frame) * 0.1;
    CGFloat sizeFactor = 0.80;
    CGFloat size = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))  * sizeFactor;
    CGRect gridFrame = CGRectMake(x, y, size, size);
    
    // Set up the grid view
    _gridView = [[DCPYGridView alloc] initWithFrame:gridFrame];
    _gridView.backgroundColor = _darkBlue;
    [self.view addSubview:_gridView];
    [_gridView drawGrid];
    
    // Create a numpad frame
    y = CGRectGetWidth(frame);
    int numPadCellCount = 10;
    CGFloat width = size;
    CGFloat height = size / (0.92 * numPadCellCount + 0.08);
    CGRect numPadFrame = CGRectMake(x, y, width, height);
    
    // Set up the numpad view
    _numPadView = [[DCPYNumPadView alloc] initWithFrame:numPadFrame];
    _numPadView.backgroundColor = _darkBlue;
    [self.view addSubview:_numPadView];
    [_numPadView drawNumPad];
    
    // Create start button
    CGRect startGameFrame = CGRectMake(CGRectGetWidth(frame) / 2 - 75, CGRectGetHeight(frame) * 0.83, 150, 150);
    UIButton* startButton;
    startButton = [[UIButton alloc] initWithFrame:startGameFrame];
    [self.view addSubview:startButton];
    [startButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [startButton.titleLabel setFont:[UIFont systemFontOfSize:25]];
    [startButton setImage:[UIImage imageNamed:@"StartButtonUp.png"] forState:UIControlStateNormal];
    [startButton setImage:[UIImage imageNamed:@"StartButtonDown.png"] forState:UIControlStateHighlighted];
    
    [startButton addTarget:self action:@selector(newGame) forControlEvents:UIControlEventTouchUpInside];
    
    // Add targets to grid cells
    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            [[_gridView getSenderAtRow: r andCol: c] addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchDown];
        }
    }
    
    [self newGame];
    
}

-(void) newGame
{
    // Generate new grid from text file
    [_gridModel generateGrid];
    
    // Set up values for the grid
    [self initGridValues];
    [self setCellsMutable];
    _backgroundView.alpha = [_gridModel percentDone];
    
    // Create the timer
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self
                                            selector:@selector(updateTimer)
                                            userInfo:nil
                                            repeats:YES];
    
    [self.view addSubview:_timerLabel];
    _startDate = [NSDate date];
}

-(void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initGridValues {
    for (int col = 0; col < 9; col++) {
        for (int row = 0; row < 9; row++) {
            int value = [_gridModel getValueAtRow: row andColumn: col];
            [_gridView setCellValue:value atRow:row andColumn:col];
        }
    }
}

-(void) setCellsMutable {
    for (int col = 0; col < 9; col++) {
        for (int row = 0; row < 9; row++) {
            bool isMutable = [_gridModel isMutableAtRow:row andColumn:col];
            [_gridView setCellIsMutable:isMutable atRow:row andColumn:col];
        }
    }
}

-(void) buttonSelected: (id) sender {
    UIButton* button = (UIButton *)sender;
    int row = (int) button.tag/9;
    int col = button.tag%9;
    int currentValue = [_numPadView getCurrentValue];
    
    // If we can enter the number selected...
    if([_gridModel isMutableAtRow:row andColumn:col] && [_gridModel isConsistentAtRow:row andColumn:col for:currentValue]){
        
        // Set the value
        [_gridModel setValueAtRow:row andColumn:col to:currentValue];
        [_gridView setCellValue:currentValue atRow:row andColumn:col];
        
        // Display alert if game is won
        if([_gridModel gameIsOver]){
            [_winAlert show];
        }
        
        // Flash row or column whenver it's filled
        if ([_gridModel rowIsFilledAt: row]) {
            [_gridView flashRow: row];
        }
        if ([_gridModel colIsFilledAt: col]) {
            [_gridView flashCol: col];
        }
    }
    _backgroundView.alpha = [_gridModel percentDone];
}

- (void)updateTimer
{
    // Create date from the elapsed time
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:_startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    // Create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    // Format the elapsed time and set it to the label
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    _timerLabel.text = timeString;
}

@end
