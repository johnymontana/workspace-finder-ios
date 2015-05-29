//
//  SubmitNewViewController.h
//  WherezWill
//
//  Created by lyonwj on 5/14/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SubmitNewViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *sqftLabel;
@property (weak, nonatomic) IBOutlet UISlider *sqftSlider;
@property (weak, nonatomic) IBOutlet UITextField *descriptionText;
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (weak, nonatomic) NSData* imageData;


- (IBAction)submit:(id)sender;
- (IBAction)takePhoto:(id)sender;
- (IBAction)sliderDoneSlid:(UISlider *)sender;
@end
