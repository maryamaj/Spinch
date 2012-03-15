//
//  iPadViewController.h
//  Spinch
//
//  Created by Tommaso Piazza on 9/27/11.
//  Copyright (c) 2011 ChalmersTH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpinchConfig.h"
#import "MSSCommunicationController.h"
#import "ColorMixerViewController.h"
#import "SpinchModel.h"

@interface iPadViewController : UIViewController <MSSCommunicationProtocol>
{
    IBOutlet UIImageView *drawImage;
    ColorMixerViewController* _colorMixerController;
    
    int mouseMoved;
    BOOL mouseSwiped;
    
    CGPoint lastPoint;
    
    SpinchModel* model;
    
}

@property (strong, nonatomic) IBOutlet UIImageView *drawImage;
@property (strong, nonatomic) ColorMixerViewController* colorMixerController;

@end
