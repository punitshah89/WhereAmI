//
//  ViewController.h
//  WhereAmI
//
//  Created by Alasdair Allan on 15/12/2012.
//  Copyright (c) 2012 Babilim Light Industries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController
{
    
    IBOutlet UIButton *backgroundButton;
    IBOutlet UILabel *latLabel;
    IBOutlet UILabel *longLabel;
}
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *latitude;
@property (strong, nonatomic) IBOutlet UILabel *longitude;

- (void)updateFromDefaults;

@end
