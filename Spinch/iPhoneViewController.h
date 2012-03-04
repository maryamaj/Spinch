//
//  ViewController.h
//  Spinch
//
//  Created by Tommaso Piazza on 9/26/11.
//  Copyright (c) 2011 ChalmersTH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClientController.h"
#import "ClientControllerProtocolDelegate.h"
#import "SpinchConfig.h"
#import "MSSCommunicationController.h"
#import "MSSCContactDescriptor.h"

@interface iPhoneViewController : UIViewController <UIGestureRecognizerDelegate, ClientControllerProtocolDelegate, MSSCommunicationProtocol>
{
    IBOutlet UIImageView *imageView;
    UIRotationGestureRecognizer *rotationGestureRecognizer;
    UIPinchGestureRecognizer *pinchGestureRecognizer;
    CGFloat lastRotation;
    CGFloat lastScale;
    
    int pinchTimes;
    int rotateTimes;
        
    ClientController *_sharedClientController;
    id<SpinchActionPassingProtocolDelegate> _delegate;
    
    MSSCommunicationController *_sharedSurfaceComController;
    MSSCContactDescriptor *_device;
    
    IBOutlet UIButton *_connectButton;

}

-(IBAction) handleRotateGesture:(UIRotationGestureRecognizer *) recognizer;
-(IBAction) handlePinchGesture:(UIPinchGestureRecognizer *) recognizer;
-(IBAction) searchForDevice:(id)sender;
-(IBAction) connectToDevice:(id)sender;

-(void) forwardMessageOfType:(int)messageType intValue:(int) intValue floatValue:(float) floatValue;
    
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIButton *connectButton;
@property (nonatomic, retain) MSSCContactDescriptor* device;

@end
