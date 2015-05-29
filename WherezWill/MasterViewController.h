//
//  MasterViewController.h
//  WherezWill
//
//  Created by lyonwj on 4/18/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>
#import "GraphView.h"
#import "GraphViewController.h"

@interface MasterViewController : PFQueryTableViewController <CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, strong) PFObject* object;

- (IBAction)insertLocation:(id)sender;


@end
