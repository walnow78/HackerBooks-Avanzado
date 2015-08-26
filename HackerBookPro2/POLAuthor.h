#import "_POLAuthor.h"

@interface POLAuthor : _POLAuthor {}

+(instancetype) authorInitWithName:(NSString*) name
                           context:(NSManagedObjectContext*) context;

@end
