//
//  DistanceModel.m
//  WherezWill
//
//  Created by lyonwj on 4/18/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import "DistanceModel.h"

#define LINE_GRAPH_TYPE 1
#define BAR_GRAPH_TYPE 2

@implementation DistanceModel

-(id) initWithData:(NSArray*) theData
{
    self = [super init];
    
    if (self)
    {
        self.plotData = [self getDistances:theData];
        self.maxValue = [self findMaxValue:self.plotData ];
        self.minValue = [self findMinValue:self.plotData ];
        self.graphType = BAR_GRAPH_TYPE;
    }
    
    return self;
}

-(NSArray*) getDistances:(NSArray*) theData
{
    return @[@1, @2, @3, @4];
}
-(double)findMaxValue:(NSArray*) array_of_doubles
{
    double tempMax = 0.;
    
    for (NSNumber* myNum in array_of_doubles)
    {
        if ([myNum doubleValue] > tempMax)
        {
            tempMax = [myNum doubleValue];
        }
        
        
    }
    
    return tempMax;
}

-(double)findMinValue:(NSArray*) array_of_doubles
{
    double tempMin = [[array_of_doubles objectAtIndex:0] doubleValue];
    
    for (NSNumber* myNum in array_of_doubles)
        if ([myNum doubleValue] < tempMin)
        {
            tempMin = [myNum doubleValue];
        }
    
    return tempMin;
}

@end
