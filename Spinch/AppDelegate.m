//
//  AppDelegate.m
//  Spinch
//
//  Created by Tommaso Piazza on 9/26/11.
//  Copyright (c) 2011 ChalmersTH. All rights reserved.
//

#import "AppDelegate.h"

#import "iPhoneViewController.h"
#import "iPadViewController.h"
#import "SpinchDevice.h"
#import "SpinchModel.h"
#import "MSSCommunicationController.h"
#import "InterDeviceCom.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize iPhoneViewController = _iPhoneViewController;
@synthesize iPadViewController = _iPadViewController;
@synthesize device = _device;
@synthesize sharedSurfaceComController = _sharedSurfaceComController;

- (void)dealloc
{
    [_window release];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        [_iPhoneViewController release];
    } else {
       
        [_iPadViewController release];
    }

    
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    InterDeviceComController* devComController = [InterDeviceComController sharedController];
    
    devComController.delegate = [SpinchModel sharedModel];
    
    _sharedSurfaceComController = [MSSCommunicationController sharedController];
    [_sharedSurfaceComController connectToHost:@"169.254.59.237" onPort:4568];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        //[[SpinchDevice sharedDevice] addObserver:[SpinchModel sharedModel] forKeyPath:@"contactDescriptor" options:NSKeyValueObservingOptionNew context:nil];
        
        self.iPhoneViewController = [[[iPhoneViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil] autorelease];
        self.window.rootViewController = self.iPhoneViewController;
        _sharedSurfaceComController.delegate = self.iPhoneViewController;
        self.device = [SpinchDevice sharedDevice];
        
    } else {
        
        self.iPadViewController = [[[iPadViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil] autorelease];
        self.window.rootViewController = self.iPadViewController;
        _sharedSurfaceComController.delegate = self.iPadViewController;
        self.device = [SpinchDevice sharedDevice];
        
        [[InterDeviceComController sharedController] startServer];
    }
    

    [NSTimer scheduledTimerWithTimeInterval:0.5 target:(_sharedSurfaceComController) selector:@selector(getContacsFromCodeine) userInfo:nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:(_sharedSurfaceComController) selector:@selector(getDevicesFromCodeine) userInfo:nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:[SpinchModel sharedModel] selector:@selector(transmitToCanvasDevice) userInfo:nil repeats:YES];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
