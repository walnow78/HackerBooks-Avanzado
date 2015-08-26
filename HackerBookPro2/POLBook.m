#import "POLBook.h"
#import "POLAuthor.h"
#import "POLTag.h"
#import "Constaint.h"
#import "POLImage.h"
#import "POLPDF.h"

@import UIKit;

@interface POLBook ()

// Private interface goes here.

@end

@implementation POLBook

// Inicializadores

+(instancetype) bookWithTitle:(NSString*) title
                     urlImage:(NSString*) urlImage
                       urlPdf:(NSString*) urlPdf
                      authors:(NSArray*) authors
                         tags:(NSArray*) tags
                   isFavorite:(BOOL) isFavorite
                      context:(NSManagedObjectContext*) context{
    
    // Creamos el objeto
    
    POLBook *book = [POLBook insertInManagedObjectContext:context];
    
    // Asignamos las propiedades
    
    book.title = title;
    book.urlImage = urlImage;
    book.urlPdf = urlPdf;
    [book setPrimitiveIsFavoriteValue:isFavorite];
    
    // Asigno la imagen en blanco
    
    POLImage *img = [POLImage initWithImage:[[UIImage alloc] init] context:context];
    
    book.image = img;
    
    // Añado el objeto pdf
    
    POLPDF *pdf = [POLPDF initWith:[[NSData alloc] init] context:context];
    
    book.pdf = pdf;
    
    // Asignamos las relaciones de los autores recorriendo el array.
    
    for (NSString* each in authors) {
        
        POLAuthor *author = [POLAuthor authorInitWithName:each context:context];
        
        // Añado el autor a la relación
        
        [book addAuthorObject:author];
        
    }
    
    // Asignamos las relaciones de los tag corriendo el array.
    
    for (NSString *each in tags) {
        
        NSString *formatedTag = [each stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        POLTag *tag = [POLTag tagInitWithName:formatedTag context:context];
        
        // Añado el tag a la relación
        
        [book addTagObject:tag];
    }
    
    return book;
    
}

+(instancetype) bookWithDictionary:(NSDictionary*) dictionary
                           context:(NSManagedObjectContext*) context{
    
    return [POLBook bookWithTitle:[dictionary objectForKey:@"title"]
                         urlImage:[dictionary objectForKey:@"image_url"]
                           urlPdf:[dictionary objectForKey:@"pdf_url"]
                          authors:[[dictionary objectForKey:@"authors"] componentsSeparatedByString:@","]
                             tags:[[dictionary objectForKey:@"tags"] componentsSeparatedByString:@","]
                       isFavorite:NO
                          context:context];
}

#pragma mark - Utils

-(NSString*) authorsToString{
    
    NSArray *authorsString = [self.author allObjects];
    
    // Ordeno el array de autores por nombre.
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name"
                                                           ascending:YES];
    
    authorsString = [authorsString sortedArrayUsingDescriptors:@[sort]];
    
    // Retorno la concatenación de la propiedad nombre de los autores.
    
    return [[authorsString valueForKey:@"name" ] componentsJoinedByString:@", "];
    
}

-(NSString*) tagsToString{
    
    NSArray *tagsString = [self.tag allObjects];
    
    // Ordeno el array de autores por nombre.
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name"
                                                           ascending:YES];
    
    tagsString = [tagsString sortedArrayUsingDescriptors:@[sort]];
    
    // Retorno la concatenación de la propiedad nombre de los autores.
    
    return [[tagsString valueForKey:@"name" ] componentsJoinedByString:@", "];
    
}


-(void)changeFavorite{
    
    // Dependiendo si el libro es favorito o no, le cambio la propiedad y le añado el tag Favoritos
    
    POLTag *tag = [POLTag tagInitWithName:@"Favorite" context:self.managedObjectContext];
    
    if (self.isFavoriteValue == YES) {
        // En caso que el libro sea favorito, le quito el tag de favorito
        
        [self removeTagObject:tag];
        [self setPrimitiveIsFavoriteValue:NO];
        
        // Compruebo si tengo algún libro con tag Favorito. En caso que no tenga ninguno
        // borro el tag para que no me aparezca.
        
        if ([[tag.book allObjects] count] == 0) {

            [self.managedObjectContext deleteObject:tag];
  
        }
        
    }else{
        
        [self addTagObject:tag];
        [self setPrimitiveIsFavoriteValue:YES];
        
    }
    
//    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
//    
//    // Notifico el cambio del favorito.
//    
//    [nc postNotificationName:NOTIFICATION_CHANGE_FAVORITE
//                      object:self
//                    userInfo:@{KEY_NOTIFICATION_CHANGE_FAVORITE : self}];

}


@end
