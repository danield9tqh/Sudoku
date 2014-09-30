//
//  PJGridView.h
//  sudoku
//
//  Created by Jean Sung and Paula Yuan on 9/11/14.
//  Copyright (c) 2014 Paula Jean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCPYGridCellView.h"

@interface DCPYGridView : UIView

-(void) drawGrid;
-(void) setCellValue: (int) val atRow: (int) row andColumn: (int) col;
-(void) setCellIsMutable: (bool) isMutable atRow: (int) row andColumn: (int) col;
-(id) getSenderAtRow: (int) row andCol: (int) col;
-(void) flashRow: (int) row;
-(void) flashCol: (int) col;

@end
