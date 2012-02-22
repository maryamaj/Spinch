//
//  TBMessage.m
//  tommyBros
//
//  Created by Tommaso Piazza on 5/19/11.
//  Copyright 2011 ChalmersTH. All rights reserved.
//

#import "SpinchMessage.h"


@implementation SpinchMessage

@synthesize messageType = _messageType;
@synthesize floatValue = _floatValue;
@synthesize intValue = _intValue;

+ (SpinchMessage *) messageOfType:(int)messageType withIntValue:(int)intValue floatValue:(float)floatValue
{
    return [[[self alloc] initWithType:messageType intValue:intValue floatValue:floatValue] autorelease];

}

- (id) initWithType:(int) messageType intValue:(int)intValue floatValue:(float)floatValue
{
    
    if((self = [super init]))
    {
        _messageType = messageType; 
        _intValue = intValue;
        _floatValue = floatValue;
    }
    
    return self;
}

#pragma mark NSCoding Protocol

- (id) initWithCoder:(NSCoder *)aDecoder 
{

    if((self = [super init])){
        
        _messageType = [aDecoder decodeInt32ForKey:@"_messageType"];
        _intValue = [aDecoder decodeInt32ForKey:@"_intValue"];
        _floatValue = [aDecoder decodeFloatForKey:@"_floatValue"];
    }

    return self;
}

- (void) encodeWithCoder:(NSCoder*)encoder 
{
    
    [encoder encodeInt32:_messageType forKey:@"_messageType"];
    [encoder encodeInt32:_intValue forKey:@"_intValue"];
    [encoder encodeFloat:_floatValue forKey:@"_floatValue"];
    
}

@end
