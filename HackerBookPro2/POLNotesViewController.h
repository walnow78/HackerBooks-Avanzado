//
//  POLNotesViewController.h
//  HackerBookPro2
//
//  Created by Pawel Walicki on 22/5/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import "POLCoreDataCollectionViewController.h"

@class POLBook;

@interface POLNotesViewController : POLCoreDataCollectionViewController

@property(nonatomic,strong) POLBook* book;

@end
