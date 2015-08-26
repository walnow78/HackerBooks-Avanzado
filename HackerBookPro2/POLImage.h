#import "_POLImage.h"
@import UIKit;


@interface POLImage : _POLImage {}

@property(nonatomic,strong) UIImage* image;

+(instancetype) initWithImage:(UIImage*) image
                      context:(NSManagedObjectContext*) context;

-(void) imageWith:(void (^) (UIImage *image, NSError *error))completionBlock;

@end
