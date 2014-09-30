//
//  DCPYGridModel.m
//  sudoku
//
//  Created by Daniel Cogan on 9/20/14.
//  Copyright (c) 2014 Daniel Cogan & Paula Yuan. All rights reserved.
//

#import "DCPYGridModel.h"

@implementation DCPYGridModel

int grid[9][9];
int initialGrid[9][9];

-(void) generateGrid
{

    NSString* path = [[NSBundle mainBundle] pathForResource:@"grid1" ofType:@"txt"];
    NSError* error;
    
    // Read grids from text file
    NSString* readString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    int numGrids = (int)readString.length/82;
    int gridNumber = arc4random_uniform(numGrids);
    NSRange range = NSMakeRange(gridNumber*82, 81);
    NSString* gridString = [readString substringWithRange:range];
    for (int i=0; i<81; i++) {
        initialGrid[i/9][i%9] = [[gridString substringWithRange:NSMakeRange(i, 1)] intValue];
        grid[i/9][i%9] = [[gridString substringWithRange:NSMakeRange(i, 1)] intValue];
    }
    
    
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

-(CGFloat) percentDone {
    int numDone = 0;
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            if(grid[i][j] != 0)
                numDone++;
        }
    }
    return numDone / 81.0;
}

-(bool) rowIsFilledAt: (int) row {
    for (int i = 0; i < 9; i++) {
        if (grid[row][i] == 0)
            return false;
    }
    return true;
}

-(bool) colIsFilledAt: (int) col {
    for (int i = 0; i < 9; i++) {
        if (grid[i][col] == 0) {
            return false;
        }
    }
    return true;
}

-(bool) gameIsOver {
    for (int i = 0; i < 9; i++) {
        for(int j=0; j < 9; j++){
            if(grid[i][j] == 0){
                return false;
            }
        }
    }
    return true;
}


@end
