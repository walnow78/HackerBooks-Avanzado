//
//  POLAnotation.m
//  HackerBookPro2
//
//  Created by Pawel Walicki on 2/6/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import "POLAnotation.h"

@implementation POLAnotation

- (instancetype)initWithTitle:(NSString*) title subtitle:(NSString*) subtitle coordinate:(CLLocationCoordinate2D) coordinate{
  
    if (self = [super init]) {
        
        _title = title;
        _subtitle = subtitle;
        _coordinate = coordinate;
    }
    
    return self;

}

@end
