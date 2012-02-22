//
//  TBActionPassingDelegate.h
//  iJPad
//
//  Created by Tommaso Piazza on 5/19/11.
//  Copyright 2011 ChalmersTH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SpinchActionPassingProtocolDelegate <NSObject>
@optional

-(void) willSendMessageOfType:(int) messageType withIntValue:(int) intValue floatValue:(float) floatValue;
-(void) didReceiveMessageOfType:(int) messageType withIntValue:(int) intValue floatValue:(float) floatValue;

@end
