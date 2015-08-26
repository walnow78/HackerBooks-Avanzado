#import "_POLBook.h"

@interface POLBook : _POLBook {}

+(instancetype) bookWithTitle:(NSString*) title
                     urlImage:(NSString*) urlImage
                       urlPdf:(NSString*) urlPdf
                      authors:(NSArray*) authors
                         tags:(NSArray*) tags
                   isFavorite:(BOOL) isFavorite
                      context:(NSManagedObjectContext*) context;

+(instancetype) bookWithDictionary:(NSDictionary*) dictionary
                           context:(NSManagedObjectContext*) context;

-(NSString*) tagsToString;
-(NSString*) authorsToString;

-(void) changeFavorite;

@end
