#import "POLLocation.h"

// Importo para obtener la dirección a partri de las coordenadas.
@import AddressBookUI;
@import MapKit;
#import "POLImage.h"

@interface POLLocation ()

@end

@implementation POLLocation


+(instancetype) locationInitWith:(CLLocation*) location note:(POLNote*) note context:(NSManagedObjectContext*)context{
    
    POLLocation *loc = [POLLocation insertInManagedObjectContext:context];
    
    loc.note = note;
    loc.latitudeValue = location.coordinate.latitude;
    loc.longitudeValue = location.coordinate.longitude;
    
    
    CLLocationCoordinate2D loc2D;
    
    loc2D.latitude = location.coordinate.latitude;
    loc2D.longitude = location.coordinate.longitude;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc2D, 150, 150);
    
    MKMapSnapshotOptions *options = [MKMapSnapshotOptions new];
    
    options.region = region;
    options.mapType = MKMapTypeStandard;
    options.size = CGSizeMake(250, 250);
    
    // Creamos la instantanea
    
    MKMapSnapshotter *shotter = [[MKMapSnapshotter alloc] initWithOptions:options];
    
    
    [shotter startWithCompletionHandler:^(MKMapSnapshot *snapshot, NSError *error) {
        
        if (error) {
            NSLog(@"error al crear snapshot: %@", error);
            
        }else{
            
            POLImage *img = [POLImage initWithImage:snapshot.image context:context];
            
            
            loc.image = img;
            NSLog(@"imagen %@",UIImageJPEGRepresentation(snapshot.image, 0.9));
        }
    }];

    NSLog(@"Location: %f", location.coordinate.latitude);
    
    CLGeocoder *geocoder  =[[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error) {
            NSLog(@"Error geocoder: %@", error);
        }else{
            // Si todo ha ido bien, guardo la dirección.
            loc.address = ABCreateStringWithAddressDictionary([[placemarks lastObject] addressDictionary], YES);
        }
    }];
    
    return loc;
}

@end
