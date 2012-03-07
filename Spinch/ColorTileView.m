//
//  ColorTileView.m
//  Spinch
//
//  Created by Tommaso Piazza on 3/6/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import "ColorTileView.h"

@implementation ColorTileView

@synthesize isSelected = _isSelected;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _isSelected = NO;
    }
    return self;
}

-(id) initWithFrame:(CGRect)frame andColor:(UIColor *) color{

    self = [super initWithFrame:frame];
    if(self){
    
        self.backgroundColor = color;
        _isSelected = NO;
    }

    return  self;
}

+(ColorTileView *) tileWithFrame:(CGRect) frame andColor:(UIColor *) color {

    ColorTileView *view = [[[self alloc] initWithFrame:frame andColor:color] autorelease];
    
    return view;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/
- (void)drawRect:(CGRect)rect
{
    if(_isSelected){
    
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextBeginPath (context);
        CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1);
        CGContextSetLineWidth(context, 3.0f);
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, rect.size.width,0);
        CGContextAddLineToPoint(context, rect.size.width,rect.size.height);
        CGContextAddLineToPoint(context, 0,rect.size.height);
        CGContextClosePath(context);
        CGContextStrokePath(context);
    
    }
}

#pragma mark -
#pragma mark KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    float hue;
    float brightness;
    float saturation;
    float alpha;
    
    [self.backgroundColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    if([keyPath isEqualToString:@"colorSaturation"]){
        
        saturation = [[change valueForKey:NSKeyValueChangeNewKey] floatValue];
    }
    if([keyPath isEqualToString:@"colorBrightness"]){
    
        brightness = [[change valueForKey:NSKeyValueChangeNewKey] floatValue];
    }
    
    self.backgroundColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
    //FIXME: this might be called every time the contactDescriptor for the current device is received over the network
    //even it the actual attributes of the device haven't changed. This can be fixed in the MSSCommunicationController delegate, iPhoneViewController
    
    [self setNeedsDisplay];
    
}



@end
