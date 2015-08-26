#import "_POLLocation.h"
@import CoreLocation;

@class POLNote;


@interface POLLocation : _POLLocation {}

+(instancetype) locationInitWith:(CLLocation*) location note:(POLNote*) note context:(NSManagedObjectContext*)context;

@end
