//
//  PJGridView.h
//  sudoku
//
//  Created by Jean Sung and Paula Yuan on 9/11/14.
//  Copyright (c) 2014 Paula Jean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PJGridCellView.h"

@interface PJGridView : UIView

- (void)drawGrid;
-(void) setCellValue: (int) val AtRow: (int) row AndCol: (int) col;
@end
