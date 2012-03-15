//
//  SpinchDevice.h
//  Spinch
//
//  Created by Tommaso Piazza on 3/7/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSSCContactDescriptor.h"
#import "DeviceInformation.h"

@interface SpinchDevice : NSObject
{
    BOOL _isOnTable;
    MSSCContactDescriptor* _contactDescriptor;
    NSString* _ipAddress;
    MSSCContactDescriptor* _otherDeviceDescriptor;
    DeviceInformation* _otherDevice;
}

@property (nonatomic, assign) BOOL isOnTable;
@property (nonatomic, retain) MSSCContactDescriptor* contactDescriptor;
@property (nonatomic, retain) MSSCContactDescriptor* otherDeviceDescriptor;
@property (nonatomic, strong) DeviceInformation* otherDevice;
@property (nonatomic, retain) NSString* ipAddress;

+ (id) sharedDevice;

@end
