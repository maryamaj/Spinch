//
//  ViewController.h
//  Spinch
//
//  Created by Tommaso Piazza on 9/26/11.
//  Copyright (c) 2011 ChalmersTH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpinchConfig.h"
#import "MSSCContactDescriptor.h"
#import "MSSCommunicationController.h"
#import "ColorMixerViewController.h"
#import "SpinchDevice.h"
#import "SpinchModel.h"

@interface iPhoneViewController : UIViewController <UIGestureRecognizerDelegate, MSSCommunicationProtocol>
{
    IBOutlet UIImageView *imageView;
    UIRotationGestureRecognizer *rotationGestureRecognizer;
    UIPinchGestureRecognizer *pinchGestureRecognizer;
    CGFloat lastRotation;
    CGFloat lastScale;
    
    int pinchTimes;
    int rotateTimes;
    
    ColorMixerViewController* _colorMixerController;
    
    IBOutlet UIButton *_connectButton;

}

-(IBAction) handleRotateGesture:(UIRotationGestureRecognizer *) recognizer;
-(IBAction) handlePinchGesture:(UIPinchGestureRecognizer *) recognizer;
    
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIButton *connectButton;
@property (nonatomic, retain) ColorMixerViewController* colorMixerController;

@end
