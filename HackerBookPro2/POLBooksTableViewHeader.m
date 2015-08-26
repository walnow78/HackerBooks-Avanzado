//
//  POLBooksTableViewHeader.m
//  HackerBookPro2
//
//  Created by Pawel Walicki on 5/5/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import "POLBooksTableViewHeader.h"

@implementation POLBooksTableViewHeader

+(NSString*) headerId{
    
    // Retorno el nombre de la clase
    
    return NSStringFromClass(self);
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
