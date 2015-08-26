//
//  POLNoteViewController.m
//  HackerBookPro2
//
//  Created by Pawel Walicki on 22/5/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import "POLNoteViewController.h"
#import "POLNote.h"
#import "POLBook.h"
#import "POLPhotoViewController.h"
#import "POLPhotoViewController.h"
#import "POLImage.h"
#import "POLLocation.h"
#import "POLMapViewController.h"

@interface POLNoteViewController ()

@property(nonatomic) BOOL newNote;

@end

@implementation POLNoteViewController 

#pragma mark - Inits


- (instancetype)initWithNote:(POLNote *)note{
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _note = note;
    }
    
    return self;
}

#pragma mark LifeCycle

- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    // Creo el tap a la imagen.
    
    UITapGestureRecognizer *tapPhoto = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPhotoView:)];
    UITapGestureRecognizer *tapMap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMap:)];
    
    [self.photoView addGestureRecognizer:tapPhoto];
    [self.photoMapView addGestureRecognizer:tapMap];
    
    [self syncViewModel];
    
    [self setupKVO];

}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self saveToModel];
    
    [self tearDownKVO];
}

#pragma mark - Actions

-(void) showPhotoView:(id) sender{
    
    //  En el caso de que no exista ninguna imagen anterior, directamente lanzo el picker.
    
    if (self.note.image.file == nil) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }else{
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        
        picker.delegate = self;
        
        picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        
        // Si la imagen existe, hago push a POLPhotoViewController.
        
        POLPhotoViewController *photoVC = [[POLPhotoViewController alloc] initWithNote:self.note];
        
        [self.navigationController pushViewController:photoVC animated:YES];
    }
}

-(void) showMap:(id) sender{
    
    POLMapViewController *mapVC = [[POLMapViewController alloc] initWithLocation:self.note];
    
    [self.navigationController pushViewController:mapVC animated:YES];
    
}

// En caso que no exista la imagen se lanza el picket así que implemento el delegado.
// En el caso de que ya existe, se encarga de la imagen POLPhotoViewController.

#pragma mark - UIImagePickerControllerDelegate

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

    POLImage *img = [POLImage insertInManagedObjectContext:self.note.managedObjectContext];
    
    img.file = UIImageJPEGRepresentation(image, 0.9);
    
    self.note.image = img;
    
    self.photoView.image = [UIImage imageWithData:self.note.image.file];

    image = nil;
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
}

#pragma mark - KVO

-(void)setupKVO{

        // Por cada propiedad de la nota lo añado al observer
        
        [self addObserver:self forKeyPath:@"self.note.location.image.file" options:NSKeyValueObservingOptionNew context:NULL];
}

-(void)tearDownKVO{
    
    // Por cada propiedad de la nota lo quito del observer
        
    [self removeObserver:self forKeyPath:@"self.note.location.image.file"];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    // En el caso que me llega una notificación del cambio, modifico la fecha de modificación de la nota
    
    if (self.note.location.image != nil) {
        self.photoMapView.image = [UIImage imageWithData: self.note.location.image.file]; // [UIImage imageWithData:self.note.location.image.file];
        
        self.photoMapView.image = [UIImage imageWithData: self.note.location.image.file];
        
    }
}

#pragma mark - Private

- (void) syncViewModel{
    
    NSDateFormatter *fr = [[NSDateFormatter alloc] init];
    fr.dateStyle = NSDateFormatterMediumStyle;
    
    self.titleView.text = self.note.title;
    self.textNoteView.text = self.note.text;
    
    self.creationDateView.text = [NSString stringWithFormat:@"C.: %@", [fr stringFromDate:self.note.creationDate]];
    self.modificationDateView.text = [NSString stringWithFormat:@"M.: %@", [fr stringFromDate:self.note.modificationDate]];

    // Aplico borde redondeado
    
    self.photoView.layer.cornerRadius =  15;
    self.photoView.clipsToBounds = YES;
    
    self.photoMapView.layer.cornerRadius = 15;
    self.photoMapView.clipsToBounds = YES;
    
    if (self.note.image.file != nil) {
        self.photoView.image = [UIImage imageWithData:self.note.image.file];
    }else{
        self.photoView.image = [UIImage imageNamed:@"no_photo.png"];
    }
    
    // Localización
    
    if (self.note.location.image != nil) {
        self.photoMapView.image = [UIImage imageWithData: self.note.location.image.file]; // [UIImage imageWithData:self.note.location.image.file];
        
        self.photoMapView.image = [UIImage imageWithData: self.note.location.image.file];

    }
}

- (void) saveToModel{
    
    self.note.title = self.titleView.text;
    self.note.text = self.textNoteView.text;
    self.note.modificationDate = [NSDate date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)hideKeyboard:(id)sender {
    
    [self.view endEditing:YES];
    
}

@end
