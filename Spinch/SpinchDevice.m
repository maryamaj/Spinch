//
//  SpinchDevice.m
//  Spinch
//
//  Created by Tommaso Piazza on 3/7/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import "SpinchDevice.h"

@implementation SpinchDevice

@synthesize isOnTable = _isOnTable;
@synthesize contactDescriptor = _contactDescriptor;
@synthesize canvasDescriptor = _canvasDescriptor;
@synthesize ipAddress = _ipAddress;

+ (SpinchDevice *) sharedDevice
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}

-(SpinchDevice *) init{
    
    self = [super init];
    
    if(self){
        self.isOnTable = NO;
        self.contactDescriptor = nil;
        self.canvasDescriptor = nil;
    }
    
    return self;
}

@end
