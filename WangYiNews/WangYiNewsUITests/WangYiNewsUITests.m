//
//  WangYiNewsUITests.m
//  WangYiNewsUITests
//
//  Created by lifangli on 16/1/25.
//  Copyright © 2016年 lifangli. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface WangYiNewsUITests : XCTestCase

@end

@implementation WangYiNewsUITests

- (void)setUp {
    [super setUp];
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tabQuery = app.tabBars;
    XCUIElement *readButton = tabQuery.buttons[@"tabbar_icon_reader_normal@2x.png"];
    [readButton tap];
    XCUIElement *newsButton = tabQuery.buttons[@"tabbar_icon_news_normal@2x.png"];
    [newsButton tap];
    [readButton tap];
    [newsButton tap];
    [readButton tap];
}

@end
