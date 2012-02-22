//
//  ViewController.m
//  Spinch
//
//  Created by Tommaso Piazza on 9/26/11.
//  Copyright (c) 2011 ChalmersTH. All rights reserved.
//

#import "iPhoneViewController.h"

@implementation iPhoneViewController

@synthesize imageView;
@synthesize connectButton = _connectButton;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotateGesture:)];
    pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    
    rotationGestureRecognizer.delegate = self;
    pinchGestureRecognizer.delegate = self;
    
    [self.view addGestureRecognizer:rotationGestureRecognizer];
    [self.view addGestureRecognizer:pinchGestureRecognizer];
    
    [self.view addSubview:imageView];
    
    lastRotation = 0.0f;
    lastScale = 0.0f;
    pinchTimes = 0;
    rotateTimes = 0;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void) dealloc {

    [rotationGestureRecognizer release];
    [pinchGestureRecognizer release];

}

#pragma mark - Gersture Handling

-(IBAction) handleRotateGesture:(UIRotationGestureRecognizer *) recognizer
{
    
    if([recognizer state] == UIGestureRecognizerStateEnded) {
        
        lastRotation = 0.0f;
        NSLog(@"Rotation Ended");

        return;
    }
    
    
    CGFloat rotation = [recognizer rotation] - lastRotation;
    imageView.transform = CGAffineTransformRotate(imageView.transform, rotation);
    NSLog(@"current rotation:%f\t last rotation:%f\t angle of rotation:%f", [recognizer rotation], lastRotation, rotation);
    lastRotation = [recognizer rotation];
    
    if(rotateTimes % 2 == 1){
        
        [self forwardMessageOfType:kMessageTypeRotation intValue:-1 floatValue:rotation];
        
    }
    
    rotateTimes++;
    if(rotateTimes > 1) rotateTimes = 0;

}

-(IBAction) handlePinchGesture:(UIPinchGestureRecognizer *) recognizer
{

    if([recognizer state] == UIGestureRecognizerStateEnded) {
        
		lastScale = 1.0;
		return;
	}
    
	CGFloat scale = 1.0 - (lastScale - [recognizer scale]);
    
	CGAffineTransform currentTransform = imageView.transform;
	CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    
	imageView.transform = newTransform;
    
    NSLog(@"Pinch scale:%f\t recognizer scale:%f\t scale delta:%f", scale, [recognizer scale], -1.0f*(lastScale - [recognizer scale]));
    
	lastScale = [recognizer scale];
    
    if(pinchTimes % 2 == 1){
    
        [self forwardMessageOfType:kMessageTypePinch intValue:-1 floatValue:scale];
    
    }
    
    pinchTimes++;
    if(pinchTimes > 1) pinchTimes = 0;

}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{

    return YES;
}

#pragma mark - Network Stuff

-(IBAction) searchForDevice:(id)sender{
    
    
    _sharedClientController = [ClientController sharedClientController];
    _delegate = _sharedClientController;
    _sharedClientController.delegate = self;
    
    [[ClientController  sharedClientController] search];
    
}

- (IBAction) connectToDevice:(id)sender{
    
    NSMutableArray * services = [[ClientController sharedClientController] services];
    
    if([services count] > 0){
        
        
        [[ClientController sharedClientController] connectToService:[services objectAtIndex:0]];
        
    }
    else{
        
        _connectButton.enabled = NO;
    }
    
}

- (void) didFindService:(NSNetService *)aService{
    
    _connectButton.enabled = YES;
    [_connectButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
}


- (void) forwardMessageOfType:(int)messageType intValue:(int)intValue floatValue:(float)floatValue {
    
    if(_delegate && [_delegate respondsToSelector:@selector(willSendMessageOfType: withIntValue: floatValue:)]){
        
        [_delegate willSendMessageOfType:messageType withIntValue:intValue floatValue:floatValue];
        
    }
    
    
}


@end
