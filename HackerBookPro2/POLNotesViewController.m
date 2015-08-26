//
//  POLNotesViewController.m
//  HackerBookPro2
//
//  Created by Pawel Walicki on 22/5/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import "POLNotesViewController.h"
#import "POLNoteCollectionViewCell.h"
#import "POLNote.h"
#import "POLNoteViewController.h"
#import "POLBook.h"
#import "POLImage.h"
#import "POLLocation.h"

@interface POLNotesViewController ()

@end

@implementation POLNotesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Registro de celda personalizada
    
    UINib *nib = [UINib nibWithNibName:@"POLNoteCollectionViewCell" bundle:nil];
    
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:[POLNoteCollectionViewCell cellId]];
    
    self.collectionView.backgroundColor = [UIColor colorWithRed:250 green:250 blue:250 alpha:100];
       
    // Creo el botón para la nueva nota.
    
    
    UIBarButtonItem *addButon = [[UIBarButtonItem alloc]
                                     initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                     target:self
                                     action:@selector(addNote)];
    
    self.navigationItem.rightBarButtonItem = addButon;

    
}

#pragma mark - Actions

- (void) addNote{
    
    // Creo una nueva nota
    
    POLNote *note = [POLNote noteWithTitle:@"" text:@"" book:self.book context:self.book.managedObjectContext];
    
 
    // Creo una imagen vacía para así tener siempre una imagen en la nota.
    
    POLImage *img = [POLImage insertInManagedObjectContext:note.managedObjectContext];
    
    // La asigno a la nota.
    
    note.image = img;
    
    POLNoteViewController *noteVC = [[POLNoteViewController alloc] initWithNote:note];
    
    [self.navigationController pushViewController:noteVC animated:YES];
    
}



#pragma mark - Datasource

-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath{
 
    POLNoteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[POLNoteCollectionViewCell cellId] forIndexPath:indexPath];
    
    POLNote *note = [self.fetchedResultsController objectAtIndexPath:indexPath];

    cell.titleView.text = note.title;
    
    cell.photoView.layer.cornerRadius =  15;
    cell.photoView.clipsToBounds = YES;
    
    // En caso que no exista imagen para la nota, cargo la que tengo por defecto.
    
    if (note.image.file != nil) {
        cell.photoView.image = [UIImage imageWithData:note.image.file];
    }else{
        cell.photoView.image = [UIImage imageNamed:@"no_photo.png"];
    }
    
    if (note.location.latitude) {
        cell.localizationView.hidden = NO;
    }else{
        cell.localizationView.hidden = YES;
    }
        
    
    // Formateo la fecha
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM"];
    
    cell.dateView.text = [formatter stringFromDate:note.creationDate];
    
    return cell;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // Recupero la nota seleccionada
    
    POLNote *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    POLNoteViewController *noteVC = [[POLNoteViewController alloc] initWithNote:note];
    
    [self.navigationController pushViewController:noteVC animated:YES];
    
}

@end
