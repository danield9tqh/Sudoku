//
//  DCPYGridModel.m
//  sudoku
//
//  Created by Daniel Cogan on 9/20/14.
//  Copyright (c) 2014 Daniel Cogan & Paula Yuan. All rights reserved.
//

#import "DCPYGridModel.h"

@implementation DCPYGridModel

int grid[9][9] = {
    {7,0,0,4,2,0,0,0,9},
    {0,0,9,5,0,0,0,0,4},
    {0,2,0,6,9,0,5,0,0},
    {6,5,0,0,0,0,4,3,0},
    {0,8,0,0,0,6,0,0,7},
    {0,1,0,0,4,5,6,0,0},
    {0,0,0,8,6,0,0,0,2},
    {3,4,0,9,0,0,1,0,0},
    {8,0,0,3,0,2,7,4,0}
};

int initialGrid[9][9] = {
    {7,0,0,4,2,0,0,0,9},
    {0,0,9,5,0,0,0,0,4},
    {0,2,0,6,9,0,5,0,0},
    {6,5,0,0,0,0,4,3,0},
    {0,8,0,0,0,6,0,0,7},
    {0,1,0,0,4,5,6,0,0},
    {0,0,0,8,6,0,0,0,2},
    {3,4,0,9,0,0,1,0,0},
    {8,0,0,3,0,2,7,4,0}
};

-(void) generateGrid
{
    
}

-(int) getValueAtRow: (int) row andColumn: (int) col
{
    return grid[row][col];
}

-(void) setValueAtRow: (int) row andColumn: (int) col to: (int) value
{
    grid[row][col] = value;
}

-(bool) isMutableAtRow: (int) row andColumn: (int) col
{
    return !initialGrid[row][col];
}

-(bool) isConsistentAtRow: (int) row andColumn:(int) col for: (int) value
{
    bool isConsistent = true;
    
    //Test the column
    for (int i =0; i<9; i++) {
        if (value == grid[i][col]) {
            isConsistent = false;
        }
    }
    
    //Test the row
    for (int i =0; i<9; i++) {
        if (value == grid[row][i]) {
            isConsistent = false;
        }
    }
    
    //Test the block
    int rowBlock = row/3;
    int colBlock = col/3;
    
    for (int r = 0; r<3; r++) {
        for (int c=0; c<3; c++) {
            if (value == grid[r+rowBlock*3][c+colBlock*3]) {
                isConsistent = false;
            }
        }
    }
    
    if (value == 0) {
        isConsistent = true;
    }
    
    return isConsistent;
}

-(bool) gameIsOver {
    for (int i = 0; i<9; i++) {
        for(int j=0; j<9; j++){
            if(grid[i][j] == 0){
                return false;
            }
        }
    }
    return true;
}


@end
