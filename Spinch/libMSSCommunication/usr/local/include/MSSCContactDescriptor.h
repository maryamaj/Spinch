//
//  ContactDescriptor.h
//  pieMenu
//
//  Created by Tommaso Piazza on 2/24/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h> //For CGPoint
#import "CodeineStructs.h"

#define MSSC_degreesToRadians(x) (M_PI * x / 180.0)
#define MSSC_radiansToDegrees(x) (x * (180.0 / M_PI))

@interface MSSCContactDescriptor : NSObject
{
    unsigned char _byteValue;

    int _positionX;
    int _positionY;
    float _orientation;
    
}

@property (atomic) unsigned char byteValue;
@property (atomic) int positionX;
@property (atomic) int positionY;
@property (atomic) float orientation;

+(MSSCContactDescriptor *) descriptorFromStruct:(ContactDescriptor) cd;
+(MSSCContactDescriptor *) descriptorWithByteValue:(unsigned char) byteValue positionX:(int) posX positionY:(int)posY orientation:(float) angle;
+(float) distanceFromDescriptor:(MSSCContactDescriptor*) a toDescriptor:(MSSCContactDescriptor *) b;
+(CGPoint) positionOfDescriptor:(MSSCContactDescriptor *) desc relativeToDescriptor:(MSSCContactDescriptor *) origin;
+(float) orientationOfDescriptor:(MSSCContactDescriptor *) desc relativeToDescriptor:(MSSCContactDescriptor *) origin;
+(float) dotProd:(CGPoint)v1 v2:(CGPoint) v2;

-(MSSCContactDescriptor *) initWithByteValue:(unsigned char) byteValue positionX:(int) posX positionY:(int)posY orientation:(float) angle;


@end

