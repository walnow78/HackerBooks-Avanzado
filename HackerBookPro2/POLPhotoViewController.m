//
//  POLPhotoViewController.m
//  HackerBookPro2
//
//  Created by Pawel Walicki on 29/5/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import "POLPhotoViewController.h"
#import "POLImage.h"
#import "POLNote.h"

@interface POLPhotoViewController ()

@end

@implementation POLPhotoViewController


- (instancetype)initWithNote:(POLNote *)note{
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _note = note;
        self.title = self.note.title;
    }
    
    return self;
}


- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self syncViewModel];
    
}

#pragma mark - Actions

- (IBAction)photoButton:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    picker.delegate = self;
    
    picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:picker animated:YES completion:nil];
    
    
}

- (IBAction)deleteButton:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:self.note.title
                              message:@"Está seguro de eliminar la imagen de la nota?"
                              delegate:self
                              cancelButtonTitle:@"Cancelar"
                              otherButtonTitles:@"Eliminar", nil];
    
    [alertView show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex  == 1) {
        self.note.image.file = nil;
        
        [UIView animateWithDuration:1
                              delay:0
                            options:0 animations:^{
                                
                                self.imageView.alpha = 0;
                                
                                
                            } completion:^(BOOL finished) {
                                
                                self.imageView.image = nil;
                                self.imageView.alpha = 1;
                                
                                
                            }];
        
    }
    
}

#pragma mark - UIImagePickerControllerDelegate

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // Compruebo que la imagen existe
    
    self.note.image.image = image;
    
    
    if (!self.note.image.file) {
        self.note.image.file =  UIImageJPEGRepresentation(image, 0.9);
    }
    
    self.imageView.image = image;
    
    image = nil;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private

- (void) syncViewModel{
    
    if (self.note.image.file) {
        self.imageView.image = [UIImage imageWithData:self.note.image.file];
    }
}

@end
