#import "POLImage.h"
#import "POLBook.h"



@interface POLImage ()

// Private interface goes here.

@end

@implementation POLImage

@synthesize image;

#pragma mark - Properties

-(void) setImage:(UIImage *)img{
    
    // Convierto UIImage a NSData para meterlo en el modelo.
    
    self.file = UIImagePNGRepresentation(image);
    
}

-(UIImage*) Image{
    
    UIImage *img = [UIImage imageWithData:self.file];
    
    return img;
}

#pragma mark - Constructores

+(instancetype) initWithImage:(UIImage*) image
                      context:(NSManagedObjectContext*) context{
    
    POLImage *img = [POLImage insertInManagedObjectContext:context];
    
    img.file = UIImageJPEGRepresentation(image, 0.9);
    
    return img;
    
}

#pragma mark - Blocks

-(void) imageWith:(void (^) (UIImage *image, NSError *error))completionBlock {
    
    // Creo una cola
    
    NSError *err;
    
    if (self.file != nil) {
        completionBlock([UIImage imageWithData:self.file], err);
        
    }else{
        
        dispatch_queue_t download = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        // Lanzo en segundo plano
        
        dispatch_async(download, ^{
            
            // Compruebo que la imagen existe
            
            NSData *data;
            
            NSError *error;
            
            // Descargo la imagen
            
            NSURL *url = [NSURL URLWithString:self.book.urlImage];
            
            data = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:&error];
            
            self.file = data;
            
            dispatch_queue_t main = dispatch_get_main_queue();
            
            dispatch_async(main, ^{
                
                completionBlock([UIImage imageWithData:self.file], error);
                
            });
        });
        
    }
}

@end


