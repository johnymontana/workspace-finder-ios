//
//  DetailViewController.m
//  WherezWill
//
//  Created by lyonwj on 4/18/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self) {
        // Custom initialization
        if (self.detailItem) {
            // obtain the geopoint
            PFGeoPoint *geoPoint = self.detailItem[@"location"];
            
            // center our map view around this geopoint
            self.mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude), MKCoordinateSpanMake(0.01f, 0.01f));
            
            // add the annotation
            GeoPointAnnotation *annotation = [[GeoPointAnnotation alloc] initWithObject:self.detailItem];
        
            [self.mapView addAnnotation:annotation];
            self.mapView.delegate = self;
        }
        
    }

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *GeoPointAnnotationIdentifier = @"RedPin";
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:GeoPointAnnotationIdentifier];
    
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:GeoPointAnnotationIdentifier];
        annotationView.pinColor = MKPinAnnotationColorRed;
        annotationView.canShowCallout = YES;
        annotationView.draggable = YES;
        annotationView.animatesDrop = YES;
        UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.rightCalloutAccessoryView=detailButton;
    }
    
    return annotationView;
}

// sent to the mapView's delegate (us) when any {left,right}CalloutAccessoryView
//   that is a UIControl is tapped on
// in this case, we manually segue using the setPhoto: segue

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    //[self performSegueWithIdentifier:@"setPhoto:" sender:view];
    NSLog(@"Something got tapped");
}

// prepares a view controller segued to via the setPhoto: segue
//   by calling setPhoto: with the photo associated with sender
//   (sender must be an MKAnnotationView whose annotation is a Photo)

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"setPhoto:"]) {
        // if ([sender isKindOfClass:[MKAnnotationView class]]) {
        //    MKAnnotationView *aView = sender;
            NSLog(@"Something got clicked");
            
            //if ([aView.annotation isKindOfClass:[Photo class]]) {
              //  Photo *photo = aView.annotation;
              //  if ([segue.destinationViewController respondsToSelector:@selector(setPhoto:)]) {
             //       [segue.destinationViewController performSelector:@selector(setPhoto:) withObject:photo];
                //}
           // }
       // }
    }
}



@end
