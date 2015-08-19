//
//  IDZDelegateLogger.h
//  IDZDelegateLogger
//
//  Created by idz on 8/17/15.
//  Copyright (c) 2015 iOSDeveloperZone.com. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for IDZDelegateLogger.
FOUNDATION_EXPORT double IDZDelegateLoggerVersionNumber;

//! Project version string for IDZDelegateLogger.
FOUNDATION_EXPORT const unsigned char IDZDelegateLoggerVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <IDZDelegateLogger/PublicHeader.h>

@interface IDZInvocationDetails : NSObject

@property (nonatomic, readonly) NSMethodSignature *methodSignature;
@property (nonatomic, readonly) id target;
@property (nonatomic, readonly) SEL selector;
@property (nonatomic, readonly) NSArray *arguments;
@property (nonatomic, readonly) id returnValue;

@end

@interface IDZDelegateLogger : NSObject

@property (nonatomic, readonly) id delegate;
//! An array of IDZInvocationDetails objects
@property (nonatomic, readonly) NSArray *invocations;

- (instancetype)initWithDelegate:(id)delegate;

@end
