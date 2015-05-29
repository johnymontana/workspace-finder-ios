//
//  GraphViewController.h
//  WherezWill
//
//  Created by lyonwj on 4/18/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphView.h"

@interface GraphViewController : UIViewController
@property (strong, nonatomic) IBOutlet GraphView *graph_view;

-(void) setDistanceData:(NSArray*)theData;

@end
