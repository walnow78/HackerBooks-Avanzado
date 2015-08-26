//
//  POLBooksTableViewCell.m
//  HackerBookPro2
//
//  Created by Pawel Walicki on 5/5/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import "POLBooksTableViewCell.h"
#import "POLBook.h"
#import "POLImage.h"
#import "Constaint.h"

#import "POLTag.h"

@interface POLBooksTableViewCell()

@property(nonatomic,strong) POLBook* model;

@end

@implementation POLBooksTableViewCell

+(NSString*) cellId{
    
    // Retorno el nombre de la clase
    
    return NSStringFromClass(self);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)awakeFromNib {
    // Initialization code
    
}

-(void) vaciarImagen{
    self.imageView.image = nil;
}

-(void)createObserver:(POLBook*) model{
    
    self.model = model;
    
    [self syncViewModel];
    
 }

-(void)syncViewModel{
    
    // Sincronizo el modelo
    
    self.activityView.hidden = NO;
    [self.activityView startAnimating];
    
    self.titleView.text = self.model.title;
    self.authorsView.text = [self.model authorsToString];
    
    if (self.model.isFavoriteValue) {
    [self.favoriteView setTintColor:[UIColor orangeColor]];
    }else{
        [self.favoriteView setTintColor:[UIColor blackColor]];
    }
    
    self.activityView.hidden = NO;
    [self.activityView startAnimating];
    
    [self.model.image imageWith:^(UIImage *image, NSError *error) {
        
        if (error) {
            NSLog(@"Error descarga imagen: %@", error);
        }else{
            self.photoView.image = image;
            
            [self.activityView stopAnimating];
            self.activityView.hidden = YES;
            
            self.photoView.alpha = 1;
            
        }
    }];
}

#pragma mark - Actions

- (IBAction)favoriteButton:(id)sender {
    
    
    [self.model changeFavorite];
//    
//    POLTag *tag = [POLTag tagInitWithName:@"Favorite" context:self.model.managedObjectContext];
//    
//    if (self.model.isFavoriteValue == YES) {
//        // En caso que el libro sea favorito, le quito el tag de favorito
//        
//        [self.model removeTagObject:tag];
//        [self.model setPrimitiveIsFavoriteValue:NO];
//        
//        // Compruebo si tengo algún libro con tag Favorito. En caso que no tenga ninguno
//        // borro el tag para que no me aparezca.
//        
//        if ([[tag.book allObjects] count] == 0) {
//            
//            [self.model.managedObjectContext deleteObject:tag];
//            
//        }
//        
//    }else{
//        
//        [self.model addTagObject:tag];
//        [self.model setPrimitiveIsFavoriteValue:YES];
//        
//    }
//    
//    [self.model changeFavorite];
//    self.model.isFavoriteValue = !self.model.isFavoriteValue;

    
    
//    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
//    
//    [defaultCenter postNotificationName:MODEL_GEONAME_DID_CHANGE
//                                 object:self
//                               userInfo:nil];
    
}


@end
