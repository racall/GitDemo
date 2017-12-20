//
//  GitDemoTests.m
//  GitDemoTests
//
//  Created by MiniCreo on 12/20/17.
//  Copyright (c) 2017 MiniCreo. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

@interface GitDemoTests : XCTestCase

@end

@implementation GitDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

-(void)testmmm{
    NSLog(@"AAA");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
