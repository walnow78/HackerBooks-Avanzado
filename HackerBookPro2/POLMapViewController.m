//
//  POLMapViewController.m
//  HackerBookPro2
//
//  Created by Pawel Walicki on 10/6/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import "POLMapViewController.h"
#import "POLLocation.h"
#import "POLAnotation.h"
#import "POLNote.h"
#import "POLImage.h"

@interface POLMapViewController ()

@end

@implementation POLMapViewController

-(instancetype) initWithLocation:(POLNote*) note{

    if (self = [super initWithNibName:nil bundle:nil]) {
        _note = note;
        self.title = note.location.address;
    }
    
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.mapView.delegate = self;
    
     [self syncViewModel];
}


#pragma mark - Private

-(void) syncViewModel{
    
    CLLocationCoordinate2D loc2D;
    
    loc2D.latitude = self.note.location.latitudeValue;
    loc2D.longitude = self.note.location.longitudeValue;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc2D, 150, 150);
    
    [self.mapView setRegion:region animated:YES];
    
    NSString *title;
    
    if ([self.note.title length]>0) {
        title = self.note.title;
    }else{
        title = @"Nota sin título";
    }
  
    POLAnotation *point = [[POLAnotation alloc] initWithTitle:title subtitle:self.note.location.address coordinate:loc2D];
    
    self.adressLabel.text = self.note.location.address;
    
    [self.mapView addAnnotation:point];


}

-(UIImage *)resizeImage:(UIImage *) photo size:(CGSize)size {
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
    
    [photo drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    static NSString *reuseId = @"reuseId";
    
    // Convertimos el mkannotationview en mkpinannotationview
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseId];
    
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseId];
        
        // Cambio de color
        
        annotationView.pinColor = MKPinAnnotationColorPurple;
        
        annotationView.canShowCallout = YES;
       
        UIImage *reduct = [self resizeImage:[UIImage imageWithData:self.note.image.file] size:CGSizeMake(40, 40)];
        
        UIImageView *miImage = [[UIImageView alloc] initWithImage:reduct];
        
        annotationView.leftCalloutAccessoryView = miImage;
        
    }
    
    return annotationView;
    
}

-(void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
    MKMapSnapshotOptions *options = [MKMapSnapshotOptions new];
    
    options.region = self.mapView.region;
    options.mapType = MKMapTypeHybrid;
    
}



@end
