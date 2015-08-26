//
//  POLBookViewController.m
//  HackerBookPro2
//
//  Created by Pawel Walicki on 5/5/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import "POLBookViewController.h"
#import "Constaint.h"
#import "POLBook.h"
#import "POLImage.h"
#import "POLPDFViewController.h"
#import "POLNote.h"
#import "POLNotesViewController.h"
#import "POLBookViewController.h"

@interface POLBookViewController () 

@end

@implementation POLBookViewController

-(instancetype) initWithModel:(POLBook*) model{
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        
        _model = model;
        
        self.title = model.title;
        
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // Me doy de alta en las notificaciones
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self
           selector:@selector(didChangeStateFavorite:)
               name:NOTIFICATION_CHANGE_FAVORITE object:nil];
    
    // Oculto en activity indicator por si el modelo está vacío.
    
    self.activityView.hidden = YES;
    self.authorsView.text = @"No se ha encontrado ningún libro";
    
    if (self.model) {
        [self syncViewModel];
    }
    
    
    //
    
    self.backgroundView.layer.cornerRadius = 10;
    self.backgroundView.clipsToBounds = YES;

    self.backgroundViewTags.layer.cornerRadius = 10;
    self.backgroundViewTags.clipsToBounds = YES;

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    // Me doy de baja en las notificaciones
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - POLBooksTableViewControllerDelegate

- (void)booksTableViewControllerDelegate:(POLBooksTableViewController *)tableVC didChangeRow:(POLBook *)book{
    
    self.model = book;
    
    [self syncViewModel];
    

    
}

#pragma mark - Actions

- (IBAction)favoriteButton:(id)sender {
    
    [self.model changeFavorite];
    
}

- (IBAction)pdfButton:(id)sender {
    
    POLPDFViewController *pdfVC = [[POLPDFViewController alloc] initWithModel:self.model];
    
    [self.navigationController pushViewController:pdfVC animated:YES];
    
}

- (IBAction)notesButton:(id)sender {
    
    // Busco las notas asociadas al libro
    
    NSFetchRequest *reqNotes  =[NSFetchRequest fetchRequestWithEntityName:[POLNote entityName]];
    
    reqNotes.predicate = [NSPredicate predicateWithFormat:@"book = %@", self.model];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES];
    
    reqNotes.sortDescriptors = @[sort];
    
    NSFetchedResultsController *fetch = [[NSFetchedResultsController alloc] initWithFetchRequest:reqNotes
                                                                            managedObjectContext:self.model.managedObjectContext
                                                                              sectionNameKeyPath:nil
                                                                                       cacheName:nil];
    // Preparo el layout
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    layout.minimumLineSpacing = 22;
    layout.minimumInteritemSpacing = 22;
    layout.itemSize = CGSizeMake(150, 191);
    layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    
    POLNotesViewController *notesVC = [[POLNotesViewController alloc] initWithFetchedResultsController:fetch layout:layout];
    
    // Asigno el libro
    
    notesVC.book = self.model;
    
    [self.navigationController pushViewController:notesVC animated:YES];
    
}

#pragma mark - Utilis

- (void)syncViewModel{
    
    self.authorsView.text = [NSString stringWithFormat:@"Authors: %@", self.model.authorsToString];
    self.tagsView.text = [NSString stringWithFormat:@"Tags: %@", self.model.tagsToString];

    
    if (self.model.isFavoriteValue) {
        [self.favoriteView setTintColor:[UIColor orangeColor]];
    }else{
        [self.favoriteView setTintColor:[UIColor blackColor]];
        
    }
    
    self.title = self.model.title;
    
    self.activityView.hidden = NO;
    [self.activityView startAnimating];
    
    [self.model.image imageWith:^(UIImage *image, NSError *error) {
        
        if (error) {
            NSLog(@"Error descarga imagen: %@", error);
        }else{
            self.imageView.image = image;
            
            [self.activityView stopAnimating];
            self.activityView.hidden = YES;
        }
    }];

}

#pragma mark - Notification

- (void)didChangeStateFavorite:(NSNotification*) info{
    
    //Recupero el libro
    
    NSDictionary *dic = [info userInfo];
    
    POLBook *book = [dic objectForKey:KEY_NOTIFICATION_CHANGE_FAVORITE];
    
    if (book.isFavoriteValue) {
        [self.favoriteView setTintColor:[UIColor orangeColor]];
    }else{
        [self.favoriteView setTintColor:[UIColor blackColor]];

    }
    
}

- (IBAction)hideKeyboard:(id)sender {
    
    [self.view endEditing:YES];
    
}



@end
