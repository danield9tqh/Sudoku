//
//  PJGridCellView.m
//  sudoku
//
//  Created by Jean Sung and Paula Yuan on 9/11/14.
//  Copyright (c) 2014 Paula Jean. All rights reserved.
//

#import "PJGridCellView.h"

@interface PJGridCellView() {
    UIButton* _button;
    int _row;
    int _col;
    int _value;
}

@end
@implementation PJGridCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {}
    return self;
}
-(void) initButtonAtRow:(int) row AndCol: (int) col{
    // button fields
    _row = row;
    _col = col;
    
    //creating a button
    CGSize cellSize = self.bounds.size;
    CGRect buttonFrame = CGRectMake(0, 0, cellSize.width, cellSize.height);
    _button = [[UIButton alloc] initWithFrame:buttonFrame];
    
    //button properties (highlight when touched, released when finger lifts up)
    [_button setShowsTouchWhenHighlighted:YES];
    [_button addTarget:self action:@selector(buttonHighlight:) forControlEvents:UIControlEventTouchDown];
    [_button addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [_button addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpOutside];
    [self addSubview:_button];
}

-(void) setCellValue: (int) value {
    _value = value;
    [_button setTitle:[NSString stringWithFormat:@"%d",_value] forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
}

-(void) buttonHighlight: (id) sender {
    [_button setBackgroundColor:[UIColor yellowColor]];
}
-(void) buttonSelected:(id) sender {
    [_button setBackgroundColor:[UIColor whiteColor]];
    NSLog(@"location: (%d, %d)" ,_row, _col);
    
}

@end
