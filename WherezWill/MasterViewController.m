//
//  MasterViewController.m
//  WherezWill
//
//  Created by lyonwj on 4/18/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()

@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.parseClassName = @"Location";
        //self.objectsPerPage = 25;
        //self.paginationEnabled = YES;
        //self.pullToRefreshEnabled = YES;
    }
    return self;
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

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self loadObjects];
        }];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    // A date formatter for the creation date.
    static NSDateFormatter *dateFormatter = nil;
	if (dateFormatter == nil) {
		dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeStyle = NSDateFormatterMediumStyle;
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
	}
    
	static NSNumberFormatter *numberFormatter = nil;
	if (numberFormatter == nil) {
		numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        numberFormatter.maximumFractionDigits = 3;
	}
    
    PFTableViewCell *cell = (PFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LocationCell"];
    
    // Configure the cell
    PFGeoPoint *geoPoint = object[@"location"];
    self.object = object;
    
    NSString *descTitle = object[@"Description"];
    
	//cell.textLabel.text = [dateFormatter stringFromDate:object.updatedAt];
    
    //PFFile *theImage = [eachObject objectForKey:@"imageFile"];
    //NSData *imageData = [theImage getData];
    //UIImage *image = [UIImage imageWithData:imageData];
    
    PFFile *theImage = object[@"picture"];
    NSData *imageData = [theImage getData];
    UIImage *image = [UIImage imageWithData:imageData];
    
    cell.imageView.image = image;
    
    cell.textLabel.text = descTitle;
    
    NSString *string = [NSString stringWithFormat:@"%@, %@",
						[numberFormatter stringFromNumber:[NSNumber numberWithDouble:geoPoint.latitude]],
						[numberFormatter stringFromNumber:[NSNumber numberWithDouble:geoPoint.longitude]]];
    
    //cell.detailTextLabel.text = string;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Sqft: %@", object[@"SquareFootage"]];
    return cell;
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

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    self.navigationItem.leftBarButtonItem.enabled = YES;
    self.navigationItem.rightBarButtonItem.enabled = YES;
}


- (IBAction)insertLocation:(id)sender {
    CLLocation *location = self.locationManager.location;
	if (!location) {
		return;
	}
    
	// Configure the new event with information from the location.
	CLLocationCoordinate2D coordinate = [location coordinate];
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    PFObject *object = [PFObject objectWithClassName:@"Location"];
    [object setObject:geoPoint forKey:@"location"];
    
    [object saveEventually:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // Reload the PFQueryTableViewController
            [self loadObjects];
        }
    }];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        // Row selection
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        [segue.destinationViewController setDetailItem:object];
    }
    
        
    else if([segue.identifier isEqualToString:@"showImage"])
    {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell*) sender];
               PFObject *object = [self.objects objectAtIndex:indexPath.row];
        PFFile *theImage = object[@"picture"];
        
        NSData *imageData = [theImage getData];
        UIImage *image = [UIImage imageWithData:imageData];

        [segue.destinationViewController setImage:image];
    }
}


@end
