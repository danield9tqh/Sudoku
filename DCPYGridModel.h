//
//  DCPYGridModel.h
//  sudoku
//
//  Created by Daniel Cogan on 9/20/14.
//  Copyright (c) 2014 Daniel Cogan & Paula Yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCPYGridModel : NSObject

-(int) getValueAtRow: (int) row andColumn: (int) col;
-(void) setValueAtRow: (int) row andColumn: (int) col to: (int) value;
-(bool) isMutableAtRow: (int) row andColumn: (int) col;
-(bool) isConsistentAtRow: (int) row andColumn:(int) col for: (int) value;
-(bool) gameIsOver;

@end
