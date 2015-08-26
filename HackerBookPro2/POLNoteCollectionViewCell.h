//
//  POLNoteCollectionViewCell.h
//  HackerBookPro2
//
//  Created by Pawel Walicki on 22/5/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface POLNoteCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UILabel *dateView;
@property (weak, nonatomic) IBOutlet UIImageView *localizationView;

+(NSString*) cellId;

@end
