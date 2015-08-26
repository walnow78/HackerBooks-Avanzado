#import "POLPDF.h"
#import "POLBook.h"

@interface POLPDF ()

// Private interface goes here.

@end

@implementation POLPDF

+ (instancetype)initWith:(NSData *)pdfData
                 context:(NSManagedObjectContext *)context{
    
    POLPDF *pdf = [POLPDF insertInManagedObjectContext:context];
    
    pdf.file = pdfData;
    
    return pdf;
    
}

- (void) pdfWith:(void (^)(NSData *, NSError *))completionBlock{
    
    NSError *error;
    
    if (self.file !=nil) {
        completionBlock(self.file, error);
    }else{
        
        dispatch_queue_t download = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        dispatch_async(download, ^{
            
            NSData *data;
            NSError *error;
            
            NSURL *url = [NSURL URLWithString:self.book.urlPdf];
            
            data = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:&error];
            
            self.file = data;

            dispatch_queue_t main = dispatch_get_main_queue();
            
            dispatch_async(main, ^{
                
                completionBlock(self.file, error);
            });
            
        });
    }
}

@end
