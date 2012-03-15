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
@synthesize colorMixerController = _colorMixerController;

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
    
    [SpinchModel sharedModel].isColorMixerDisplayed = NO;
    [SpinchModel sharedModel].isToolControllerDisplayed = YES;
    
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

#pragma mark -
#pragma mark MSSCommunicationController Protocol

-(void) newContacs:(NSDictionary *)contacDictionary{
    
    
    SpinchDevice* device = [SpinchDevice sharedDevice]; 
    device.ipAddress = [MSSCommunicationController deviceIp];
    MSSCContactDescriptor *desc = [contacDictionary objectForKey:[NSNumber numberWithUnsignedChar:iPhoneID]];
    device.contactDescriptor = desc;
    if (device.contactDescriptor) {
        
        device.isOnTable = YES;
        [[MSSCommunicationController sharedController] setDeviceToCodeine:[DeviceInformation deviceInfoWithCDByteValue:device.contactDescriptor.byteValue andIp:device.ipAddress]];
        
        MSSCContactDescriptor* canvas = [contacDictionary objectForKey:[NSNumber numberWithUnsignedChar:iPadID]];
        
        if(canvas){
                    
            ((SpinchDevice *)[SpinchDevice sharedDevice]).otherDeviceDescriptor = canvas;
           
        
            float angle = [MSSCContactDescriptor orientationOfDescriptor:device.contactDescriptor relativeToDescriptor:canvas];
            
            if( angle > 20.0f && angle  < 140.0f){
                
                if(![SpinchModel sharedModel].isColorMixerDisplayed){
                
                    [self dismissViewControllerAnimated:YES completion:nil];
                    self.colorMixerController = [[ColorMixerViewController alloc] init];
                    [SpinchModel sharedModel].isColorMixerDisplayed = YES;
                    [SpinchModel sharedModel].isToolControllerDisplayed = NO;
                    [self presentViewController:self.colorMixerController animated:YES completion:nil];
                }
            
            }
            
            
            if( angle < 20.0f || angle > 140.0f ){
                
                if(![SpinchModel sharedModel].isToolControllerDisplayed){
                    [self dismissViewControllerAnimated:YES completion:nil];
                    [SpinchModel sharedModel].isColorMixerDisplayed = NO;
                    self.colorMixerController = nil;
                    [SpinchModel sharedModel].isToolControllerDisplayed = YES;
                }
            }
        }
    }
    else{
    
        device.isOnTable = NO;
    
    }
    
}

-(void) newIPs:(NSDictionary *)ipDictionary {

    SpinchDevice* device = [SpinchDevice sharedDevice];
    NSNumber* key = [NSNumber numberWithUnsignedChar:device.otherDeviceDescriptor.byteValue];
    DeviceInformation* canvasDevice = [ipDictionary objectForKey:key];
    
    if(canvasDevice != nil && canvasDevice.ipStrLength > 0){
    
        SpinchDevice* device = [SpinchDevice sharedDevice];
        device.otherDevice = canvasDevice;
        
    }
    


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
    self.colorMixerController = nil;
    [super dealloc];

}

#pragma mark - Gersture Handling

-(IBAction) handleRotateGesture:(UIRotationGestureRecognizer *) recognizer
{
    
    if([recognizer state] == UIGestureRecognizerStateEnded) {
        
        lastRotation = 0.0f;
        NSLog(@"Rotation Ended");

        return;
    }
    
    
    /*
    NSLog(@"current rotation:%f\t last rotation:%f\t angle of rotation:%f", [recognizer rotation], lastRotation, rotation);
    lastRotation = [recognizer rotation];
    
    if(rotateTimes % 2 == 1){
        
        [SpinchModel sharedModel].toolAlpha = 1* rotation;
        
    }
    
    rotateTimes++;
    if(rotateTimes > 1) rotateTimes = 0;
     
     */
    
    CGFloat imgRotation = [recognizer rotation] - lastRotation;
    imageView.transform = CGAffineTransformRotate(imageView.transform, imgRotation);
    lastRotation = [recognizer rotation];
    NSLog(@"Rotation: %f", [recognizer rotation]);
    [SpinchModel sharedModel].toolAlpha = 1* [recognizer rotation];

}

-(IBAction) handlePinchGesture:(UIPinchGestureRecognizer *) recognizer
{

    /*

    
	CGAffineTransform currentTransform = imageView.transform;
	CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    
	imageView.transform = newTransform;
    
    NSLog(@"Pinch scale:%f\t recognizer scale:%f\t scale delta:%f", scale, [recognizer scale], -1.0f*(lastScale - [recognizer scale]));
    
	lastScale = [recognizer scale];
    
    if(pinchTimes % 2 == 1){
    
        [SpinchModel sharedModel].toolWith = scale;
    
    }
    
    pinchTimes++;
    if(pinchTimes > 1) pinchTimes = 0;
     */
    
    if([recognizer state] == UIGestureRecognizerStateEnded) {
        
		lastScale = 1.0;
		return;
	}
    
	CGFloat scale = 1.0 - (lastScale - [recognizer scale]);
    CGAffineTransform currentTransform = imageView.transform;
	CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    imageView.transform =newTransform;
    
    int toolscale = 0;
    float increment = (lastScale - [recognizer scale]);
    
    increment = fabs(increment);
    NSLog(@"Increment %f, 10%% %f", increment, lastScale*0.01);
    if(increment > lastScale*0.01){
        if(lastScale > 0)
            toolscale = 5;
        else
            toolscale = -5;
    }
    lastScale = [recognizer scale];
    [SpinchModel sharedModel].toolWith = 50*[recognizer scale];
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{

    return YES;
}

@end
