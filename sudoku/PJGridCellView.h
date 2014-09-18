//
//  PJGridCellView.h
//  sudoku
//
//  Created by Jean Sung and Paula Yuan on 9/11/14.
//  Copyright (c) 2014 Paula Jean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PJGridCellView : UIView
-(void) initButtonAtRow:(int) row AndCol: (int) col;
-(void) setCellValue: (int) value;
@end
