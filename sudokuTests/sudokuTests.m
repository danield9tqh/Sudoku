//
//  sudokuTests.m
//  sudokuTests
//
//  Created by Jean Sung on 9/11/14.
//  Copyright (c) 2014 Paula Jean. All rights reserved.
//

#import "DCPYGridModel.h"
#import <XCTest/XCTest.h>

@interface sudokuTests : XCTestCase {
    DCPYGridModel* _gridModel;
}

@end

@implementation sudokuTests

- (void)setUp
{
    [super setUp];
    
    _gridModel = [[DCPYGridModel alloc] init];
    
    int grid[9][9] = {
        {7,0,0,4,2,0,0,0,9},
        {0,0,9,5,0,0,0,0,4},
        {0,2,0,6,9,0,5,0,0},
        {6,5,0,0,0,0,4,3,0},
        {0,8,0,0,0,6,0,0,7},
        {0,1,0,0,4,5,6,0,0},
        {0,0,0,8,6,0,0,0,2},
        {3,4,0,9,0,0,1,0,0},
        {8,0,0,3,0,2,7,4,0}
    };
    
    [_gridModel generateGridWith:grid];
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testConsistency
{
    XCTAssertFalse([_gridModel isConsistentAtRow:0 andColumn:1 for:7], @"Test row and block consistency");
    XCTAssertFalse([_gridModel isConsistentAtRow:0 andColumn:7 for:7], @"Test row consistency");
    XCTAssertFalse([_gridModel isConsistentAtRow:5 andColumn:0 for:7], @"Test column consistency");
    XCTAssertTrue([_gridModel isConsistentAtRow:1 andColumn:1 for:3], @"Test that consistent value works");
    XCTAssertTrue([_gridModel isConsistentAtRow:1 andColumn:1 for:0], @"Test that 0 is a consistent input");
}

- (void)testMutable
{
    XCTAssertFalse([_gridModel isMutableAtRow:0 andColumn:0], @"Test that initial values are not mutable");
    XCTAssertTrue([_gridModel isMutableAtRow:1 andColumn:1], @"Test that blank values are mutable");
}

- (void) testFilledRowAndColumn
{
    XCTAssertFalse([_gridModel rowIsFilledAt: 3], @"Test that row 3 is not filled");
    XCTAssertFalse([_gridModel colIsFilledAt: 3], @"Test that column 3 is not filled");
}

- (void)testGameIsOver {
    XCTAssertFalse([_gridModel gameIsOver], @"Test that game is not over when grid is not full");
}


@end
