//
//  SpinchModel.h
//  Spinch
//
//  Created by Tommaso Piazza on 3/7/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSSCContactDescriptor.h"
#import "InterDeviceComController.h"
#import "SpinchDevice.h"

@interface SpinchModel : NSObject <InterDeviceComProtocol, NSCoding>

@property (nonatomic, assign) float toolWith;
@property (nonatomic, assign) float toolAlpha;
@property (nonatomic, assign) float colorSaturation;
@property (nonatomic, assign) float colorHue;
@property (nonatomic, assign) float colorBrightness;
@property (nonatomic, assign) BOOL isColorMixerDisplayed;
@property (nonatomic, assign) BOOL isToolControllerDisplayed;

+(SpinchModel *) sharedModel;
-(void) transmitToCanvasDevice;

@end
