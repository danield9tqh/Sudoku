//
//  DCPYNumPadView.m
//  sudoku
//
//  Created by Daniel Cogan on 9/20/14.
//  Copyright (c) 2014 Daniel Cogan & Paula Yuan. All rights reserved.
//

#import "DCPYNumPadView.h"

@interface DCPYNumPadView ()
{
    NSMutableArray* _numPadCellArray;
    int _currentValue;
}

@end

@implementation DCPYNumPadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {}
    return self;
}

- (void)drawNumPad
{
    _numPadCellArray = [[NSMutableArray alloc] init];
    
    for (int c = 0; c <= 9; c++) {
            
        CGSize frameSize = self.bounds.size;
        
        // Calculate the position and size
        int cellCount = 10;
        CGFloat x = frameSize.width / cellCount * c + 0.08 * frameSize.height;
        CGFloat y = 0.08 * frameSize.height;
        CGFloat size = 0.84 * frameSize.height;
        
        // Frame for each button, initialize button
        CGRect buttonFrame = CGRectMake(x, y, size, size);
        UIButton* button = [[UIButton alloc] initWithFrame:buttonFrame];
        button.backgroundColor = [UIColor whiteColor];
        button.tag = c;
        
        // Add view as subview and object to array
        [self addSubview: button];
        [_numPadCellArray addObject: button];
        
        // Set number for button
        if (c != 0) {
            [button setTitle:[NSString stringWithFormat:@"%d",c] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithRed: .3 green: .7 blue: .1 alpha: 1] forState:UIControlStateNormal];
        }
        
        // add target to button
        [button addTarget:self action:@selector(cellSelected:) forControlEvents:UIControlEventTouchDown];
    }
}

- (int) getCurrentValue
{
    return _currentValue;
}

- (void) cellSelected: (id) sender
{
    UIButton *button = [_numPadCellArray objectAtIndex:_currentValue];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setTitleColor:[UIColor colorWithRed: .3 green: .7 blue: .1 alpha: 1] forState:UIControlStateNormal];
    button = (UIButton *)sender;
    [button setBackgroundColor:[UIColor colorWithRed: .6 green: .9 blue: .1 alpha: 1]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _currentValue = (int) button.tag;
}

@end
