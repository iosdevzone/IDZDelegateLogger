//
//  IDZDelegateLogger.m
//  IDZDelegateLogger
//
//  Created by idz on 8/17/15.
//  Copyright (c) 2015 iOSDeveloperZone.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDZDelegateLogger.h"
#import <IDZInvocation/IDZInvocation.h>

@interface IDZInvocationDetails ()
@property (nonatomic, readonly) NSInvocation *invocation;
//@property (nonatomic, readwrite, strong) id target;
@end

@implementation IDZInvocationDetails
@synthesize invocation = mInvocation;
@dynamic target;

static NSString* IDZStringWithArgument(id arg)
{
    if(!arg || arg == [NSNull null])
        return @"nil";
    if([arg isKindOfClass:[NSString class]])
    {
        return [NSString stringWithFormat:@"@\"%@\"", arg];
    }
    return [arg description];
}

- (instancetype)initWithInvocation:(NSInvocation*)invocation
{
    NSParameterAssert(invocation);
    if(self = [super init])
    {
        [invocation retainArguments];
        mInvocation = invocation;
    }
    return self;
}

- (NSMethodSignature*)methodSignature
{
    return self.invocation.methodSignature;
}

- (SEL)selector
{
    return self.invocation.selector;
}

- (NSArray*)arguments
{
    return self.invocation.idz_arguments;
}

- (id)target
{
    return self.invocation.target;
}

/**
 * Prints an invocation in the following format
 * -[target action:argument0] -> returnValue 
 * The returnValue is omitted for methods returning void.
 * @todo Ensure that varargs are handled correctly
 */
- (NSString*)description
{
    NSString *selectorString = NSStringFromSelector(self.selector);
    NSArray *selectorComponents = [selectorString componentsSeparatedByString:@":"];
    
    NSMutableString *s = [NSMutableString stringWithFormat:@"-[%@", self.target];
    for(int i = 0; i < self.arguments.count; ++i) {
        if(i < selectorComponents.count)
            [s appendFormat:@" %@:", selectorComponents[i]];
        [s appendFormat:@"%@", IDZStringWithArgument(self.arguments[i])];
    }
    [s appendFormat:@"]"];
    if(self.methodSignature.methodReturnType[0] != 'v')
        [s appendFormat:@" -> %@", self.returnValue];
    
    return s;
}

@end

@interface IDZDelegateLogger ()
{
    NSMutableArray *mInvocations;
}

@end

@implementation IDZDelegateLogger
@synthesize delegate = mDelegate;
@synthesize invocations = mInvocations;

- (instancetype)init {
    return [self initWithDelegate:nil];
}

- (instancetype)initWithDelegate:(id)delegate
{
    if(self = [super init])
    {
        mDelegate = delegate;
        mInvocations = [NSMutableArray array];
    }
    return self;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    NSString *selectorString = NSStringFromSelector(aSelector);
    // Turns out to be a bad idea to pretend to respond to these selectors if you don't really.
    // Causes crashes in printing.
    if([selectorString isEqualToString:@"_dynamicContextEvaluation:patternString:"] ||
       [selectorString isEqualToString:@"descriptionWithLocale:"])
    {
        if(self.delegate)
            return [self.delegate respondsToSelector:aSelector];
        else
            return [super respondsToSelector:aSelector];
    }
    return mDelegate ? [mDelegate respondsToSelector:aSelector] : YES;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    id forwardedTo = self;
    if([mDelegate respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:mDelegate];
        forwardedTo = mDelegate;
    } else if([super respondsToSelector:anInvocation.selector]) {
        [super forwardInvocation:anInvocation];
    }
    IDZInvocationDetails *details = [[IDZInvocationDetails alloc] initWithInvocation:anInvocation];
    [mInvocations addObject:details];
}

@end
