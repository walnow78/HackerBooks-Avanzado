//
//  POLNoteCollectionViewCell.m
//  HackerBookPro2
//
//  Created by Pawel Walicki on 22/5/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import "POLNoteCollectionViewCell.h"

@implementation POLNoteCollectionViewCell

+(NSString*) cellId{
    
    return NSStringFromClass(self);
    
}

- (void)awakeFromNib {

    self.photoView.image = [UIImage imageNamed:@"no_photo.png"];
    self.titleView.text = nil;
    self.dateView.text = nil;
    
}

@end
