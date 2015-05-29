//
//  DetailViewController.h
//  WherezWill
//
//  Created by lyonwj on 4/18/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "GeoPointAnnotation.h"

@interface DetailViewController : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) PFObject* detailItem;

@end
