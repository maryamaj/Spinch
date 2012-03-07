//
//  AppDelegate.h
//  Spinch
//
//  Created by Tommaso Piazza on 9/26/11.
//  Copyright (c) 2011 ChalmersTH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iPhoneViewController, iPadViewController, SpinchDevice, MSSCommunicationController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) iPhoneViewController *iPhoneViewController;
@property (strong, nonatomic) iPadViewController *iPadViewController;
@property (strong, nonatomic) SpinchDevice* device;
@property (strong, nonatomic) MSSCommunicationController *sharedSurfaceComController;

@end
