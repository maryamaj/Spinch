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
        self.isColorMixerDisplayed = NO;
    }
    
    return self;
}


#pragma mark -
#pragma mark KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{


    if([keyPath isEqualToString:@"contactDescriptor"]){
        
        MSSCContactDescriptor* desc = [change objectForKey:NSKeyValueChangeNewKey];
        if(desc !=(MSSCContactDescriptor *)[NSNull null]){
        
            self.colorSaturation = 1.0f - desc.orientation/360.0f;
        }else{
        
            NSLog(@"Can't change colorSaturation");
        }
    }
    
}

@end
