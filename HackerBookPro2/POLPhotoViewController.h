//
//  POLPhotoViewController.h
//  HackerBookPro2
//
//  Created by Pawel Walicki on 29/5/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import <UIKit/UIKit.h>

@class POLNote;

@interface POLPhotoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property(nonatomic,strong) POLNote *note;

- (IBAction)photoButton:(id)sender;
- (IBAction)deleteButton:(id)sender;

- (instancetype) initWithNote:(POLNote*) note;



@end
