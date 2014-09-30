//
//  PJGridView.m
//  sudoku
//
//  Created by Jean Sung and Paula Yuan on 9/11/14.
//  Copyright (c) 2014 Paula Jean. All rights reserved.
//

#import "DCPYGridView.h"

@interface DCPYGridView () {
    NSMutableArray* _gridCellArray;
}

@end

@implementation DCPYGridView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {}
    return self;
}

/* method to draw the sudoku grid
 */
- (void)drawGrid
{
    _gridCellArray = [[NSMutableArray alloc] init];
    
    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            
            CGSize frameSize = self.bounds.size;
            
            // calculating the position and size
            int cellCount = 9;
            CGFloat frameSizeFactor = 0.95;
            CGFloat positionFactor = 0.05;
            CGFloat xOffSet = frameSize.width * (1 - frameSizeFactor) / 6 * ((int) c/3 + 2);
            CGFloat yOffSet = frameSize.width * (1 - frameSizeFactor) / 6 * ((int) r/3 + 2);
            CGFloat x = frameSize.width * frameSizeFactor / cellCount * (c + positionFactor) + xOffSet;
            CGFloat y = frameSize.height * frameSizeFactor / cellCount * (r + positionFactor) + yOffSet;
            CGFloat sizeFactor = 0.9 / cellCount;
            CGFloat size = MIN(frameSize.width, frameSize.height) * sizeFactor * frameSizeFactor;
            
            // frame for each cell, intialaize grid cell view object
            CGRect cellFrame = CGRectMake(x, y, size, size);
            DCPYGridCellView* cellView = [[DCPYGridCellView alloc] initWithFrame:cellFrame];
            [cellView initButtonAtRow:r AndColumn:c];
            
            cellView.backgroundColor = [UIColor whiteColor];
            
            // add view as subview and object to array
            [self addSubview:cellView];
            [_gridCellArray addObject: cellView];
        }
    }
}

/* method to set a given cell value at a specified row and column in an existing 
    sudoku grid
 */
-(void) setCellValue: (int) val atRow: (int) row andColumn: (int) col {
    int adjustedIndex = (row*9) + col;
    DCPYGridCellView* current = [_gridCellArray objectAtIndex:adjustedIndex];
    [current setCellValue:val];
}

-(void) setCellIsMutable: (bool) isMutable atRow: (int) row andColumn: (int) col
{
    int adjustedIndex = (row*9) + col;
    
    DCPYGridCellView* current = [_gridCellArray objectAtIndex:adjustedIndex];
    [current setIsMutable:isMutable];
}

-(id) getSenderAtRow: (int) row andCol: (int) col {
    return [[_gridCellArray objectAtIndex: (row * 9 + col)] getSender];
}

-(void) flashRow: (int) row {
    for (int i = 0; i < 9; i++) {
        DCPYGridCellView* gridCellView = [_gridCellArray objectAtIndex:(row*9+i)];
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, .1 * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^(void) {
            [gridCellView flashButton];
        });
    }
    for (int i = 0; i < 9; i++) {
        DCPYGridCellView* gridCellView = [_gridCellArray objectAtIndex:(row*9+i)];
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^(void) {
            [gridCellView restoreColor];
        });
    }
}

-(void) flashCol: (int) col {
    for (int i = 0; i < 9; i++) {
        DCPYGridCellView* gridCellView = [_gridCellArray objectAtIndex:(i*9+col)];
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, .1 * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^(void) {
            [gridCellView flashButton];
        });
    }
    for (int i = 0; i < 9; i++) {
        DCPYGridCellView* gridCellView = [_gridCellArray objectAtIndex:(i*9+col)];
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^(void) {
            [gridCellView restoreColor];
        });
    }
}

@end
