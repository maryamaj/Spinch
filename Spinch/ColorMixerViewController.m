//
//  ColorMixerViewController.m
//  Spinch
//
//  Created by Tommaso Piazza on 3/5/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#define MAX_TILES 35

#import "ColorMixerViewController.h"

@implementation ColorMixerViewController

@synthesize selectedTiles = _selectedTiles;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.selectedTiles = [NSMutableArray arrayWithCapacity:5];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    for (int i = 0; i < MAX_TILES; i++) {
        
        float saturation = [SpinchModel sharedModel].colorSaturation;
        float brightness = [SpinchModel sharedModel].colorBrightness;
        
        ColorTileView *ct = [ColorTileView tileWithFrame:CGRectMake(10+((i*60)%300), 30+((i*60)/300)*60, 60, 60) andColor:[UIColor colorWithHue:i*1.0/35.0 saturation:saturation brightness:brightness alpha:1.0]];
        ct.tag = i;
        [self.view addSubview:ct ];
        [[SpinchModel sharedModel] addObserver:ct forKeyPath:@"colorSaturation" options:NSKeyValueObservingOptionNew context:nil];
        [[SpinchModel sharedModel] addObserver:ct forKeyPath:@"colorBrightness" options:NSKeyValueObservingOptionNew context:nil];
    }
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    NSArray *views = [self.view subviews];
    for(int i = 0; i < [views count]; i++){
        [[views objectAtIndex:i] release];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Touch Handling


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *aTouch = [touches anyObject];
    if (aTouch.tapCount == 2) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        NSArray* views = [self.view subviews];
        
        for (int i = 0; i < views.count; i++) {
            ColorTileView* aTile  = (ColorTileView *)[views objectAtIndex:i];
            
            if(aTile.isSelected){
            
                aTile.isSelected = NO;
                [aTile setNeedsDisplay];
                [_selectedTiles removeAllObjects];
            }
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
}



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *theTouch = [touches anyObject];
    if (theTouch.tapCount == 1) {
        NSDictionary *touchLoc = [NSDictionary dictionaryWithObject:
                                  [NSValue valueWithCGPoint:[theTouch locationInView:self.view]] forKey:@"location"];
        [self performSelector:@selector(handleSingleTap:) withObject:touchLoc afterDelay:0.3];
    } else if (theTouch.tapCount == 2) {
        
    }
}

- (void)handleSingleTap:(NSDictionary *)touches {
    // Single-tap: decrease image size by 10%"
    
    CGPoint locationInView = [(NSValue *) [touches objectForKey:@"location"] CGPointValue];
    
    int tile = [self tileIdFromLocation:locationInView];
    if(tile >= 0){
        
        ColorTileView* aTile = (ColorTileView*)[self.view viewWithTag:tile];
        
        aTile.isSelected  = YES;
        [aTile setNeedsDisplay];
        [_selectedTiles addObject:aTile];
    }

}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    /* no state to clean up, so null implementation */
}

#pragma mark -
#pragma mark Utilities

-(int) tileIdFromLocation:(CGPoint) locationInView {

    if(locationInView.x >= 10 && locationInView.x <= 300 && locationInView.y >= 30 && locationInView.y <=450){
    
    
        int row = locationInView.y / 60;
        int column = locationInView.x / 60;
        
        
        return row*5+column;
    }

    return -1;
}

@end
