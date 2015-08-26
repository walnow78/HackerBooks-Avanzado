#import "_POLTag.h"

@interface POLTag : _POLTag {}

+(instancetype) tagInitWithName:(NSString*) name
                           context:(NSManagedObjectContext*) context;

-(POLBook*) bookAtIndex:(NSUInteger) index;

// Ordenación personalizada (favorito primero)

-(NSComparisonResult) compare:(POLTag*) other;

@end
