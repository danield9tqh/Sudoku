//
//  PJGridCellView.h
//  sudoku
//
//  Created by Jean Sung and Paula Yuan on 9/11/14.
//  Copyright (c) 2014 Paula Jean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCPYGridCellView : UIView

-(void) initButtonAtRow:(int) row AndColumn: (int) col;
-(void) setCellValue: (int) value;
-(void) setIsMutable: (BOOL) isMutable;
-(void) cellSelected:(id) sender;
-(id) getSender;
-(int) getCol;
-(int) getRow;
-(void) flashButton;
-(void) restoreColor;

@end
