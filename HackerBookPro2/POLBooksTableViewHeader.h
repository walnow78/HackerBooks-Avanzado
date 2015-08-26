//
//  POLBooksTableViewHeader.h
//  HackerBookPro2
//
//  Created by Pawel Walicki on 5/5/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface POLBooksTableViewHeader : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleView;

+(NSString*) headerId;

@end
