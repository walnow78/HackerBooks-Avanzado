//
//  POLAnotation.h
//  HackerBookPro2
//
//  Created by Pawel Walicki on 2/6/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

@import Foundation;
@import MapKit;

@interface POLAnotation : NSObject <MKAnnotation>

@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *subtitle;
@property(nonatomic,readonly) CLLocationCoordinate2D coordinate;

- (instancetype)initWithTitle:(NSString*) title subtitle:(NSString*) subtitle coordinate:(CLLocationCoordinate2D) coordinate;

@end
