//
//  iPadViewController.h
//  Spinch
//
//  Created by Tommaso Piazza on 9/27/11.
//  Copyright (c) 2011 ChalmersTH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpinchActionPassingProtocolDelegate.h"
#import "ServerController.h"
#import "SpinchConfig.h"

@interface iPadViewController : UIViewController < SpinchActionPassingProtocolDelegate >
{
    IBOutlet UIImageView *drawImage;
    int mouseMoved;
    BOOL mouseSwiped;
    CGPoint lastPoint;
    
    CGFloat lineWidth;
    CGFloat alphaValue;
    
    CGFloat lastScaleValue;

    
    ServerController *_sharedServerController;
    id<SpinchActionPassingProtocolDelegate> _delegate;
    
}

@property (strong, nonatomic) IBOutlet UIImageView *drawImage;

@end
