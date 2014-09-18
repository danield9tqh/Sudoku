//
//  PJViewController.m
//  sudoku
//
//  Created by Jean Sung and Paula Yuan on 9/11/14.
//  Copyright (c) 2014 Paula Jean. All rights reserved.
//

#import "PJViewController.h"

int initialGrid[9][9] = {
    {7,0,0,4,2,0,0,0,9},
    {0,0,9,5,0,0,0,0,4},
    {0,2,0,6,9,0,5,0,0},
    {6,5,0,0,0,0,4,3,0},
    {0,8,0,0,0,6,0,0,7},
    {0,1,0,0,4,5,6,0,0},
    {0,0,0,8,6,0,0,0,2},
    {3,4,0,9,0,1,0,0,0},
    {8,0,0,3,0,2,7,4,0}
};

@interface PJViewController () {
    UIButton* _button;
    PJGridView* _gridView;
}

@end

@implementation PJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // change background color
    self.view.backgroundColor = [UIColor whiteColor];
    
    // creating a frame
    CGRect frame = self.view.frame;
    
    // creating a grid frame
    CGFloat x = CGRectGetWidth(frame) *0.1;
    CGFloat y = CGRectGetHeight(frame)*0.1;
    CGFloat sizeFactor = 0.80;
    CGFloat size = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))  * sizeFactor;
    CGRect gridFrame = CGRectMake(x, y, size, size);
    
    // setting up the grid view
    _gridView = [[PJGridView alloc] initWithFrame:gridFrame];
    _gridView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_gridView];
    [_gridView drawGrid];
    
    // setting up values for the grid
    [self initGridValues];
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
            [_gridView setCellValue:initialGrid[col][row] AtRow:row AndCol:col];
        }
    }
}

@end
