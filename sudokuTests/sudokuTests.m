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
    // Put setup code here. This method is called before the invocation of each test method in the class.
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
}

- (void)testMutable
{
    XCTAssertFalse([_gridModel isMutableAtRow:0 andColumn:0], @"Test that initial values are not mutable");
}

- (void)testGameIsOver {
    XCTAssertFalse([_gridModel gameIsOver], @"Test that game is not over when grid is not full");
}


@end
