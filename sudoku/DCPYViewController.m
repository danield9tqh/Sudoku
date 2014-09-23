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
}

@end

@implementation DCPYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Initialize the Grid Model
    _gridModel = [[DCPYGridModel alloc] init];
    
    // change background color
    self.view.backgroundColor = [UIColor whiteColor];
    
    // creating a frame
    CGRect frame = self.view.frame;
    
    // creating a grid frame
    CGFloat x = CGRectGetWidth(frame) * 0.1;
    CGFloat y = CGRectGetHeight(frame) * 0.1;
    CGFloat sizeFactor = 0.80;
    CGFloat size = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))  * sizeFactor;
    CGRect gridFrame = CGRectMake(x, y, size, size);
    
    // setting up the grid view
    _gridView = [[DCPYGridView alloc] initWithFrame:gridFrame];
    _gridView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_gridView];
    [_gridView drawGrid];
    
    // setting up values for the grid
    [self initGridValues];
    [self setCellsMutable];
    
    // create a numpad frame
    y = CGRectGetWidth(frame);
    int numPadCellCount = 10;
    CGFloat width = size;
    CGFloat height = size / (0.92 * numPadCellCount + 0.08);
    CGRect numPadFrame = CGRectMake(x, y, width, height);
    
    // set up the numpad view
    _numPadView = [[DCPYNumPadView alloc] initWithFrame:numPadFrame];
    _numPadView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_numPadView];
    [_numPadView drawNumPad];
    
    // action target or something
    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            [[_gridView getSenderAtRow: r andCol: c] addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchDown];
        }
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/* Initializes all of the starting sudoku values (will be replaced by model)
 */
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
    if([_gridModel isMutableAtRow:row andColumn:col] && [_gridModel isConsistentAtRow:row andColumn:col for:currentValue]){
        [_gridModel setValueAtRow:row andColumn:col to:currentValue];
        [_gridView setCellValue:currentValue atRow:row andColumn:col];
        if([_gridModel gameIsOver]){
            NSLog(@"YOU WIN!!!!!");
        }
    }
}


@end
