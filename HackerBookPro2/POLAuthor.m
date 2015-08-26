#import "POLAuthor.h"

@interface POLAuthor ()

// Private interface goes here.

@end

@implementation POLAuthor

+(instancetype) authorInitWithName:(NSString*) name
                           context:(NSManagedObjectContext*) context{
    
    // Busco si ya tengo un objeto
    
    POLAuthor *author = [POLAuthor checkAuthorWithName:name context:context];
    
    if (!author) {
        
        // No existe, creo uno nuevo
        
        author = [POLAuthor insertInManagedObjectContext:context];
        
        // Asigno las propiedades
        
        author.name = name;
    }
    
    // Retorno el autor
    
    return author;
}

+(POLAuthor*) checkAuthorWithName:(NSString*) name context:(NSManagedObjectContext*) context{
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[POLAuthor entityName]];
    
    req.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    
    NSError *error;
    
    POLAuthor *author = [[context executeFetchRequest:req
                                                error:&error] lastObject];
    
    return author;
    
}


@end
