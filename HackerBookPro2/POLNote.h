#import "_POLNote.h"


@import MapKit;

@class POLBook;

@interface POLNote : _POLNote {} 

+ (instancetype) noteWithTitle:(NSString*) title
                          text:(NSString*) text
                          book:(POLBook*) book
                       context:(NSManagedObjectContext*)context;

@end
