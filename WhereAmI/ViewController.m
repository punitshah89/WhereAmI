//
//  ViewController.m
//  WhereAmI
//
//  Created by Alasdair Allan on 15/12/2012.
//  Copyright (c) 2012 Babilim Light Industries. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateFromDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    if ( [defaults boolForKey:@"enabled_preference"] ) {
        backgroundButton.hidden = NO;
        latLabel.text = @"Latitude";
        longLabel.text = @"Longitude";
    } else {
        backgroundButton.hidden = YES;
        latLabel.text = @"";
        longLabel.text = @"";
    } }

- (void)viewWillAppear:(BOOL)animated {
    [self updateFromDefaults];
    [super viewWillAppear:animated];
}


@end
