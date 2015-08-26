//
//  POLBooksTableViewController.m
//  HackerBookPro2
//
//  Created by Pawel Walicki on 5/5/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import "POLBooksTableViewController.h"
#import "POLTag.h"
#import "POLBook.h"
#import "POLImage.h"
#import "POLBooksTableViewCell.h"
#import "POLBooksTableViewHeader.h"
#import "POLBookViewController.h"
#import "Constaint.h"

@interface POLBooksTableViewController ()


@end

@implementation POLBooksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Hacker Books";
    
    // Registro el nib de la celda y la cabecera
    
    UINib *nibCell = [UINib nibWithNibName:@"POLBooksTableViewCell" bundle:[NSBundle mainBundle]];
    UINib *nibHeader = [UINib nibWithNibName:@"POLBooksTableViewHeader" bundle:[NSBundle mainBundle]];
    
    [self.tableView registerNib:nibCell forCellReuseIdentifier:[POLBooksTableViewCell cellId]];
    [self.tableView registerNib:nibHeader forCellReuseIdentifier:[POLBooksTableViewHeader headerId]];
    
    // Asignación de delegados
    
    self.searchBar.delegate = self;
    
    [self filterResulWithFilter:@""];
    
}

-(instancetype) initWithContext:(NSManagedObjectContext*) context style:(UITableViewStyle) style{
    
    if (self = [super initWithStyle:style]) {
        _context = context;
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // Me doy de alta en las notificaciones
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self
           selector:@selector(didChangeStateFavorite:)
               name:NOTIFICATION_CHANGE_FAVORITE object:nil];
    
    [nc addObserver:self
           selector:@selector(didChangeStateFavorite:)
               name:NOTIFICATION_CHANGE_FAVORITE_FROM_BOOK object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark - Datasource

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{

    return [self.fetchedResultsController.fetchedObjects count];

}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    // Recupero el tag actual

    POLTag *tag = [self.fetchedResultsController.fetchedObjects objectAtIndex:section];
    
    return [[tag.book allObjects] count];
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    POLBooksTableViewHeader * customHeaderCell = [tableView dequeueReusableCellWithIdentifier:[POLBooksTableViewHeader headerId]];
    
    POLTag *tag = [self.fetchedResultsController.fetchedObjects objectAtIndex:section];
    
    customHeaderCell.titleView.text = tag.name;
    
    
    
    if ([tag.name isEqualToString:@"Favorite"]) {
        [customHeaderCell.titleView setTextColor:[UIColor orangeColor]];
    }else{
        [customHeaderCell.titleView setTextColor:[UIColor blackColor]];
    }
    
    return customHeaderCell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 26;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Creo la celda personalizada
    
    POLBooksTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[POLBooksTableViewCell cellId]
                                                                  forIndexPath:indexPath];
    
    // Saco el tag actual
    
    POLTag *tag = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.section];
    
    // Saco el libro
    
    POLBook *book = [tag bookAtIndex:indexPath.row];
     
    [cell createObserver:book];
    
     return cell;
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Saco el tag actual
    
    POLTag *tag = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.section];

    // Saco el libro
    
    POLBook *book = [tag bookAtIndex:indexPath.row];
    
    // Aviso al delegado
    
    [self.delegate booksTableViewControllerDelegate:self didChangeRow:book];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    // Notifico el cambio de la fila
    
    [nc postNotificationName:NOTIFICATION_CHANGE_ROW_TABLE_VIEW
                      object:self
                    userInfo:@{KEY_NOTIFICATION_CHANGE_ROW_TABLE_VIEW : book}];

    
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    [self filterResulWithFilter:searchText];

}

#pragma mark - Private

-(void) filterResulWithFilter:(NSString*) filter{
    
    
    NSFetchRequest *requestTag = [NSFetchRequest fetchRequestWithEntityName:[POLTag entityName]];
    
    if (![filter isEqual:@""]){
        
        requestTag.predicate = [NSPredicate predicateWithFormat:@"book.title CONTAINS[cd] %@", filter];
    }
    
    NSSortDescriptor *tag = [NSSortDescriptor sortDescriptorWithKey:POLTagAttributes.name
                                                          ascending:YES
                                                           selector:@selector(compare:)];
    
    
    requestTag.sortDescriptors = @[tag];
    
    
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc] initWithFetchRequest:requestTag
                                                                         managedObjectContext:self.context
                                                                           sectionNameKeyPath:nil
                                                                                    cacheName:nil];
    
    
    
    self.fetchedResultsController = fc;

}


#pragma mark - Notification

- (void)didChangeStateFavorite:(NSNotification*) info{
    
    [self filterResulWithFilter:@""];
    
    [self.tableView reloadData];
}



#pragma mark POLBooksTableViewControllerDelegate

-(void) booksTableViewControllerDelegate:(POLBooksTableViewController *)tableVC didChangeRow:(POLBook *)book{
    
    POLBookViewController *bookVC = [[POLBookViewController alloc] initWithModel:book];
    
    [self.navigationController pushViewController:bookVC animated:YES];
    
}



@end
