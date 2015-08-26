//
//  POLMapViewController.h
//  HackerBookPro2
//
//  Created by Pawel Walicki on 10/6/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@class POLLocation, POLNote;

@interface POLMapViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>


@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,strong) POLNote* note;

-(instancetype) initWithLocation:(POLNote*) note;



@end
