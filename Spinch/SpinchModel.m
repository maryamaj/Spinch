//
//  SpinchModel.m
//  Spinch
//
//  Created by Tommaso Piazza on 3/7/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import "SpinchModel.h"

@implementation SpinchModel

@synthesize toolWith;
@synthesize toolAlpha;
@synthesize colorHue;
@synthesize colorBrightness;
@synthesize colorSaturation;
@synthesize isColorMixerDisplayed;
@synthesize isToolControllerDisplayed;


+ (SpinchModel *) sharedModel
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}

-(SpinchModel *) init{
    
    self = [super init];
    
    if(self){
        
        self.toolWith = 10.0f;
        self.toolAlpha = 1.0f;
        self.colorSaturation = 1.0f;
        self.colorHue = 1.0f;
        self.colorBrightness = 1.0f;
        self.isColorMixerDisplayed = NO;
        self.isToolControllerDisplayed = NO;
    }
    
    return self;
}

#pragma mark -
#pragma mark Scheduled Method for Network Communicaiton 

-(void) transmitToCanvasDevice{

    DeviceInformation * canvasDev = ((SpinchDevice *)[SpinchDevice sharedDevice]).canvasDevice;
    if(canvasDev != nil){
    
        InterDeviceComController* comController = [InterDeviceComController sharedController];
        [comController connectToDevice:canvasDev onPort:kIDCPORT];
        [comController sendData:[NSKeyedArchiver archivedDataWithRootObject:self] toDevice:canvasDev]; 
    }

}

#pragma mark -
#pragma mark InterDeviceComProtocol

-(void) receivedData:(NSData *)data fromHost:(NSString *)host{
    
    
    SpinchModel* model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    self.toolWith = model.toolWith;
    self.toolAlpha = model.toolAlpha;
    self.colorSaturation = model.colorSaturation;
    self.colorHue = model.colorHue;
    self.colorBrightness = model.colorBrightness;
    self.isColorMixerDisplayed = model.isColorMixerDisplayed;
    self.isToolControllerDisplayed = model.isToolControllerDisplayed;
}


#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder *)aDecoder 
{
    
    if((self = [super init])){
        
        toolWith = [aDecoder decodeInt32ForKey:@"toolWith"];
        toolWith = toolWith / 100.0f;
        toolAlpha = [aDecoder decodeInt32ForKey:@"toolAlpha"];
        toolAlpha = toolWith / 100.0f;
        colorSaturation = [aDecoder decodeInt32ForKey:@"colorSaturation"];
        colorSaturation = colorSaturation / 100.0f;
        colorHue = [aDecoder decodeInt32ForKey:@"colorHue"];
        colorHue = colorHue / 100.0f;
        colorBrightness = [aDecoder decodeInt32ForKey:@"colorBrightness"];
        colorBrightness = colorBrightness / 100.0f;
        isColorMixerDisplayed = [aDecoder decodeBoolForKey:@"isColorMixerDisplayed"];
        isToolControllerDisplayed = [aDecoder decodeBoolForKey:@"isColorMixerDisplayed"];
    }
    
    return self;
}

- (void) encodeWithCoder:(NSCoder*)encoder 
{
    
    [encoder encodeInt32:toolWith*100 forKey:@"toolWith"];
    [encoder encodeInt32:toolAlpha*100 forKey:@"toolAlpha"];
    [encoder encodeInt32:colorSaturation*100 forKey:@"colorSaturation"];
    [encoder encodeInt32:colorHue*100 forKey:@"colorHue"];
    [encoder encodeInt32:colorBrightness*100 forKey:@"colorBrightness"];
    [encoder encodeBool:isColorMixerDisplayed forKey:@"isColorMixerDisplayed"];
    [encoder encodeBool:isToolControllerDisplayed forKey:@"isToolControllerDisplayed"];
    
}

#pragma mark -
#pragma mark KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{


    if([keyPath isEqualToString:@"contactDescriptor"]){
        
        MSSCContactDescriptor* desc = [change objectForKey:NSKeyValueChangeNewKey];
        if(desc !=(MSSCContactDescriptor*) [NSNull null]){
        
            self.colorSaturation = 1.0f - desc.orientation/360.0f;
        }else{
        
            NSLog(@"Can't change colorSaturation");
        }
    }
    
}

@end
