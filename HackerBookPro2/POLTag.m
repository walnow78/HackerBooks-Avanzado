#import "POLTag.h"
#import "POLBook.h"

@interface POLTag ()

// Private interface goes here.

@end

@implementation POLTag

+(instancetype) tagInitWithName:(NSString*) name
                           context:(NSManagedObjectContext*) context{
    
    // Busco si ya tengo un objeto
    
    POLTag *tag = [POLTag checkTagWithName:name context:context];
    
    if (!tag) {
        
        // No existe, creo uno nuevo
        
        tag = [POLTag insertInManagedObjectContext:context];
        
        // Asigno las propiedades quitando los espacios en blanco
        
        tag.name = name;
    }
    
    // Retorno el tag
    
    return tag;
}

+(POLTag*) checkTagWithName:(NSString*) name context:(NSManagedObjectContext*) context{
    
    // Busco si existe un objeto con el nombre del tag, en caso que exista lo retorno.
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[POLTag entityName]];
    
    req.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    
    NSError *error;
    
    POLTag *tag = [[context executeFetchRequest:req
                                          error:&error] lastObject];
    
    if (error) {
        NSLog(@"error busqueda tag: %@", error);
    }
    
    return tag;
    
}

#pragma mark - Utils

-(POLBook*) bookAtIndex:(NSUInteger) index{
    
    NSArray *books = [self.book allObjects];
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title"
                                                 ascending:YES];
    
    books = [books sortedArrayUsingDescriptors:@[sortDescriptor]];
        
    POLBook *book = [books objectAtIndex:index];
    
    return book;
}

#pragma mark - Compare

-(NSInteger) booksCount{
    
    return [[self.book allObjects] count];
}

// Compare personalizado para mostrar el tag Favorite como primero.

-(NSComparisonResult) compare:(POLTag*) other{
    
    static NSString* favorito = @"Favorite";
    
    if ([self.name isEqualToString:other.name]) {
        return NSOrderedSame;
        
    }else if ([self.name isEqualToString:favorito]){
        return NSOrderedAscending;
        
    }else if ([other.name isEqualToString:favorito]){
        return NSOrderedDescending;
        
    }else{
        return [self.name compare:other.name];
    }
}


@end
