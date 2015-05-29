//
//  GraphViewController.m
//  WherezWill
//
//  Created by lyonwj on 4/18/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import "GraphViewController.h"

@interface GraphViewController ()

@end

@implementation GraphViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        NSLog(@"WHEN DOES THIS GET CALLED???");
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _graph_view = [[GraphView alloc] init];
    _graph_view.dataSource = @[@1, @2, @3, @4];
    [self.graph_view setNeedsDisplay];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)  setDistanceData:(NSArray *)theData
{
    _graph_view = [[GraphView alloc] init];
    _graph_view.dataSource = @[@1, @2, @3, @4];
    [self.graph_view setNeedsDisplay];

}

@end
