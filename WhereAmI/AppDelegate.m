//
//  AppDelegate.m
//  WhereAmI
//
//  Created by Alasdair Allan on 15/12/2012.
//  Copyright (c) 2012 Babilim Light Industries. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL enabled = [defaults boolForKey:@"enabled_preference"];
    NSLog(@"enabled = %d", enabled);
    
    self.locationManager = [[CLLocationManager alloc] init];
    if ( [CLLocationManager locationServicesEnabled] ) {
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter = 1000;
        [self.locationManager startUpdatingLocation];
    }
    
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

+ (void)initialize {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *settingsBundle =
    [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    NSDictionary *settings =
    [NSDictionary dictionaryWithContentsOfFile:
     [settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
    NSMutableDictionary *defaultsToRegister =
    [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
   
    [defaults registerDefaults:defaultsToRegister];
    [defaults synchronize];
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self.viewController updateFromDefaults];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    double miles = 12.0;
    double scalingFactor = ABS( cos(2 * M_PI * newLocation.coordinate.latitude /360.0) );
    MKCoordinateSpan span;
    span.latitudeDelta = miles/69.0;
    span.longitudeDelta = miles/( scalingFactor*69.0 );
    MKCoordinateRegion region;
    region.span = span;
    region.center = newLocation.coordinate;
    [self.viewController.mapView setRegion:region animated:YES];
    self.viewController.mapView.showsUserLocation = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    if ( [defaults boolForKey:@"enabled_preference"] ) {
    self.viewController.latitude.text = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    self.viewController.longitude.text = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
    }
    else {
        self.viewController.latitude.text = @"";
        self.viewController.longitude.text = @"";
    }
}

@end
