//
//  IDZDelegateLoggerTests.m
//  IDZDelegateLoggerTests
//
//  Created by idz on 8/17/15.
//  Copyright (c) 2015 iOSDeveloperZone.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "IDZDelegateLogger.h"

@interface IDZDelegateLogger (NSXMLParserDelegate)<NSXMLParserDelegate>

@end

@implementation IDZDelegateLogger (NSXMLParserDelegate)

@end

@interface IDZDelegateLoggerTests : XCTestCase

@end

@implementation IDZDelegateLoggerTests

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
    NSString *xml = @"<doc></doc>";
    NSData *data = [xml dataUsingEncoding:NSUTF8StringEncoding];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    IDZDelegateLogger *delegate = [[IDZDelegateLogger alloc] init];
    parser.delegate = delegate;
    [parser parse];
    for(IDZInvocationDetails *invocation in delegate.invocations)
    {
        fprintf(stderr, "%s\n", [invocation description].UTF8String);
    }
    
    XCTAssert(YES, @"Pass");
}



@end
