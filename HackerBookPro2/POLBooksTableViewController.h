//
//  POLBooksTableViewController.h
//  HackerBookPro2
//
//  Created by Pawel Walicki on 5/5/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "POLCoreDataTableViewController.h"

@class POLBooksTableViewController;
@class POLBook;

// Creación del protocolo

@protocol POLBooksTableViewControllerDelegate <NSObject>

-(void) booksTableViewControllerDelegate:(POLBooksTableViewController*) tableVC
                            didChangeRow:(POLBook*) book;

@end

@interface POLBooksTableViewController : POLCoreDataTableViewController <UISearchBarDelegate, POLBooksTableViewControllerDelegate>;

@property (nonatomic,weak) id <POLBooksTableViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic,strong) NSManagedObjectContext *context;

-(instancetype) initWithContext:(NSManagedObjectContext*) context style:(UITableViewStyle) style;


@end
