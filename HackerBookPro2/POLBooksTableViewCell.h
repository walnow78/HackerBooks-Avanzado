//
//  POLBooksTableViewCell.h
//  HackerBookPro2
//
//  Created by Pawel Walicki on 5/5/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import <UIKit/UIKit.h>
@class POLBooksTableViewCell;
@class POLBook;

@protocol BooksTableViewCellDelegate <NSObject>

-(void) changeStateFavorite:(POLBooksTableViewCell*) cell;

@end

@interface POLBooksTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UILabel *authorsView;
@property (weak, nonatomic) IBOutlet UIButton *favoriteView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@property(nonatomic,strong) id<BooksTableViewCellDelegate> delegate;

- (IBAction)favoriteButton:(id)sender;

+(NSString*) cellId;

-(void)createObserver:(POLBook*) model;

@end
