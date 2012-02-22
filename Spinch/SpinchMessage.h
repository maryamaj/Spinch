//
//  TBMessage.h
//  tommyBros
//
//  Created by Tommaso Piazza on 5/19/11.
//  Copyright 2011 ChalmersTH. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SpinchMessage : NSObject <NSCoding> {
    
    int _messageType;
    float _floatValue;
    int _intValue;
    
}

@property (nonatomic, assign) int messageType;
@property (nonatomic, assign) float floatValue; 
@property (nonatomic, assign) int intValue;

+ (SpinchMessage *) messageOfType:(int) messageType withIntValue:(int) intValue floatValue:(float) floatValue;
- (id) initWithType:(int) messageType intValue:(int) intValue floatValue:(float) floatValue;

@end
