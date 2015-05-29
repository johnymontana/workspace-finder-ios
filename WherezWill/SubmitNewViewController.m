//
//  SubmitNewViewController.m
//  WherezWill
//
//  Created by lyonwj on 5/14/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import "SubmitNewViewController.h"
#import <Parse/Parse.h>

@interface SubmitNewViewController ()

@end

@implementation SubmitNewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) setImageData:(NSData *)imageData
{
    _imageData = [NSData dataWithData:imageData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self locationManager] startUpdatingLocation];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(id)sender
{
    [self.descriptionText resignFirstResponder];
    PFObject *listing = [PFObject objectWithClassName:@"Location"];
    
    CLLocation *location = self.locationManager.location;
	if (!location) {
		return;
	}
    
	CLLocationCoordinate2D coordinate = [location coordinate];
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinate.latitude longitude:coordinate.longitude];

    
    PFFile *imageFile = [PFFile fileWithName:@"desk.jpg" data:self.imageData];
    
    [listing setObject:geoPoint forKey:@"location"];
    [listing setObject:imageFile forKey:@"picture"];
    [listing setObject:self.descriptionText.text forKey:@"Description"];
    
    int sqft = (int)self.sqftSlider.value;
    NSNumber* sqfeets = [NSNumber numberWithInt:sqft];
    
    [listing setObject:sqfeets forKey:@"SquareFootage"];
    
    [listing saveInBackground];

}

- (IBAction)takePhoto:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera] == YES){
        // Create image picker controller
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        // Set source to the camera
        imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        
        // Delegate is self
        imagePicker.delegate = self;
        
        // Show image picker
        
        
        [self presentModalViewController:imagePicker animated:YES];
    }

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Access the uncropped image from info dictionary
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    // Dismiss controller
    [picker dismissModalViewControllerAnimated:YES];
    
    // Resize image
    UIGraphicsBeginImageContext(CGSizeMake(640, 960));
    [image drawInRect: CGRectMake(0, 0, 640, 960)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Upload image
    NSData *imageData = UIImageJPEGRepresentation(image, 0.05f);
   
    self.imageData = imageData;
    // [self uploadImage:imageData];
}

- (IBAction)sliderDoneSlid:(UISlider *)sender
{
    self.sqftLabel.text = [NSString stringWithFormat:@"%i", (int)self.sqftSlider.value];

}

- (CLLocationManager *)locationManager {
    if (_locationManager != nil) {
        return _locationManager;
    }
    
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [_locationManager setDelegate:self];
    [_locationManager setPurpose:@"Wherez Will?"];
    
    return _locationManager;
}
@end
