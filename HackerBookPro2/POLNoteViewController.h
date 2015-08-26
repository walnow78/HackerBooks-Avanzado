//
//  POLNoteViewController.h
//  HackerBookPro2
//
//  Created by Pawel Walicki on 22/5/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import <UIKit/UIKit.h>

@class POLNote;
@class POLBook;

@interface POLNoteViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleView;
@property (weak, nonatomic) IBOutlet UITextView *textNoteView;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@property (weak, nonatomic) IBOutlet UILabel *creationDateView;
@property (weak, nonatomic) IBOutlet UILabel *modificationDateView;
@property(nonatomic,strong) POLNote* note;
@property (weak, nonatomic) IBOutlet UIImageView *photoMapView;

- (instancetype) initWithNote:(POLNote*) note;

@end
