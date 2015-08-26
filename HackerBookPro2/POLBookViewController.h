//
//  POLBookViewController.h
//  HackerBookPro2
//
//  Created by Pawel Walicki on 5/5/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "POLBook.h"

#import "POLBooksTableViewController.h"

@interface POLBookViewController : UIViewController <POLBooksTableViewControllerDelegate>

@property( nonatomic,strong) POLBook* model;

@property (weak, nonatomic) IBOutlet UILabel *authorsView;
@property (weak, nonatomic) IBOutlet UILabel *tagsView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *favoriteView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

- (IBAction)favoriteButton:(id)sender;
- (IBAction)pdfButton:(id)sender;
- (IBAction)notesButton:(id)sender;

#pragma mark - Constructor

-(instancetype) initWithModel:(POLBook*) model;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIView *backgroundViewTags;

@end
