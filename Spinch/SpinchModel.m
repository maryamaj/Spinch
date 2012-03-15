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
//not serialized
@synthesize localHue;


+ (SpinchModel *) sharedModel
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}

+(SpinchModel *) modelFromData:(NSData *) data{

    const unsigned char* bytes = [data bytes];
    
    int length  =  data.length;
    
    SpinchModel* sp = nil;
    
    if(length == 22){
    
        sp = [[SpinchModel alloc] init];
        
        int pos = 0;
        int LtoolWith = *((int *)&bytes[pos]);
        LtoolWith = CFSwapInt32LittleToHost(LtoolWith);
        sp.toolWith = LtoolWith / 100.0f;
        
        pos +=sizeof(int);
        int LtoolAlpha = *((int *)&bytes[pos]);
        sp.toolAlpha  = LtoolAlpha / 100.0f;
        
        pos +=sizeof(int);
        int LcolorSaturation = *((int *)&bytes[pos]);
        sp.colorSaturation = LcolorSaturation / 100.0f;
        
        pos +=sizeof(int);
        int LcolorHue = *(&bytes[pos]);
        sp.colorHue = LcolorHue / 100.0f;
        
        pos +=sizeof(int);
        int LcolorBrightness = *((int *)&bytes[pos]);
        sp.colorBrightness = LcolorBrightness / 100.0f;
        
        pos += sizeof(unsigned char);
        unsigned char LisColorMixerDisplayed = *(&bytes[pos]);
        sp.isColorMixerDisplayed = (LisColorMixerDisplayed == 1) ? YES: NO; 
        
        pos += sizeof(unsigned char);
        unsigned char LisToolControllerDisplayed = *(&bytes[pos]);
        sp.isToolControllerDisplayed = (LisToolControllerDisplayed == 1) ? YES: NO; 
    }
    return sp;
}

-(NSData *) data {

    int size  = 5*sizeof(int)+2*sizeof(unsigned char);
    unsigned char* bytes = malloc(size);
    
    int pos = 0;
    
    int LtoolWith = toolWith * 100.0f;
    LtoolWith = CFSwapInt32HostToLittle(LtoolWith);
    memcpy(&(bytes[pos]), &LtoolWith, sizeof(int));
    
    pos += sizeof(int);
    int LtoolAlpha = toolAlpha * 100.0f;
    memcpy(&(bytes[pos]), &LtoolAlpha, sizeof(int));
    
    pos += sizeof(int);
    int LcolorSaturation = colorSaturation * 100.0f;
    memcpy(&(bytes[pos]), &LcolorSaturation, sizeof(int));
    
    pos += sizeof(int);
    int LcolorHue = colorHue * 100.0f;
    memcpy(&(bytes[pos]), &LcolorHue, sizeof(int));
    
    pos += sizeof(int);
    int LcolorBrightness = colorBrightness * 100.0f;
    memcpy(&(bytes[pos]), &LcolorBrightness, sizeof(int));
    
    pos += sizeof(unsigned char);
    unsigned char LisColorMixerDisplayed = (isColorMixerDisplayed == YES) ? 1 : 0;
    memcpy(&(bytes[pos]), &LisColorMixerDisplayed, sizeof(int));
    
    pos += sizeof(unsigned char);
    unsigned char LisToolControllerDisplayed = (isToolControllerDisplayed == YES) ? 1 : 0;
    memcpy(&(bytes[pos]), &LisToolControllerDisplayed, sizeof(int));
    
    NSData* data = [NSData dataWithBytes:bytes length:size];
    
    return data;
}

-(SpinchModel *) init{
    
    self = [super init];
    
    if(self){
        
        self.toolWith = 50.0f;
        self.toolAlpha = 1.0f;
        self.colorSaturation = 1.0f;
        self.colorHue = 1.0f;
        self.colorBrightness = 1.0f;
        self.isColorMixerDisplayed = NO;
        self.isToolControllerDisplayed = NO;
        
        //not serialized
        self.localHue = 1.0;
        
    }
    
    return self;
}

#pragma mark -
#pragma mark Scheduled Method for Network Communicaiton 

-(void) transmitToCanvasDevice{

    DeviceInformation * canvasDev = ((SpinchDevice *)[SpinchDevice sharedDevice]).otherDevice;
    if(canvasDev != nil){
    
        InterDeviceComController* comController = [InterDeviceComController sharedController];
        [comController sendData:[self data] toDevice:canvasDev]; 
    }

}

#pragma mark -
#pragma mark InterDeviceComProtocol

-(void) receivedData:(NSData *)data fromHost:(NSString *)host{
    
    SpinchModel* model = [SpinchModel modelFromData:data];
    
    self.toolWith = model.toolWith;
    self.toolAlpha = model.toolAlpha;
    self.colorSaturation = model.colorSaturation;
    self.colorHue = model.colorHue;
    self.colorBrightness = model.colorBrightness;
    self.isColorMixerDisplayed = model.isColorMixerDisplayed;
    self.isToolControllerDisplayed = model.isToolControllerDisplayed;
    self.localHue = model.localHue;
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
