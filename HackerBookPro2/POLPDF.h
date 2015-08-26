#import "_POLPDF.h"

@interface POLPDF : _POLPDF {}


+ (instancetype)initWith:(NSData *)pdfData
                 context:(NSManagedObjectContext *)context;

-(void) pdfWith:(void (^) (NSData *pdf, NSError *error))completionBlock;

@end
