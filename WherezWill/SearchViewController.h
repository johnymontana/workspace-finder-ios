

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SearchViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) IBOutlet UISlider *slider;
@property (nonatomic, retain) CLLocationManager* locationManager;

- (void)setInitialLocation:(CLLocation *)aLocation;

@end
