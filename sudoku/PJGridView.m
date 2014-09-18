//
//  PJGridView.m
//  sudoku
//
//  Created by Jean Sung and Paula Yuan on 9/11/14.
//  Copyright (c) 2014 Paula Jean. All rights reserved.
//

#import "PJGridView.h"

@interface PJGridView () {
    NSMutableArray* _gridCellArray;
}

@end

@implementation PJGridView

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
            PJGridCellView* cellView = [[PJGridCellView alloc] initWithFrame:cellFrame];
            [cellView initButtonAtRow:r AndCol:c];
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
-(void) setCellValue: (int) val AtRow: (int) row AndCol: (int) col {
    int adjustedIndex = (row*9) + col;
    
    // only show non zero initial values (0 means empty value)
    if (val !=0) {
        PJGridCellView* current = [_gridCellArray objectAtIndex:adjustedIndex];
        [current setCellValue:val];
    }
}


@end
