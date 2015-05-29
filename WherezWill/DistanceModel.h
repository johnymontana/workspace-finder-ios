//
//  DistanceModel.h
//  WherezWill
//
//  Created by lyonwj on 4/18/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GraphView.h"
#import <Parse/Parse.h>

@interface DistanceModel : NSObject <GraphViewDataSource>
@property (strong, nonatomic) NSArray* plotData;
@property double maxValue;
@property int graphType;
@property double minValue;


-(id)initWithData:(NSArray*) theData;
-(NSArray*) getDistances:(NSArray*) theData;



@end
