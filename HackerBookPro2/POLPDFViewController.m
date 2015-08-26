//
//  POLPDFViewController.m
//  HackerBookPro2
//
//  Created by Pawel Walicki on 21/5/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import "POLPDFViewController.h"
#import "POLBook.h"
#import "POLPDF.h"
#import "Constaint.h"

@interface POLPDFViewController ()

@end

@implementation POLPDFViewController

- (instancetype)initWithModel:(POLBook *)model{
    
    if (self = [super init]) {
        _model = model;
        
        self.title = model.title;
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    // Me doy de alta en las notificaciones
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self
           selector:@selector(didChangeRowTableView:)
               name:NOTIFICATION_CHANGE_ROW_TABLE_VIEW object:nil];
    
    [self syncViewModel];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // Me doy de baja en las notificaciones
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)syncViewModel{
    
    self.title = self.model.title;
    
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    
    [self.model.pdf pdfWith:^(NSData *pdf, NSError *error) {
        
        [self.webView loadData:pdf MIMEType:@"application/pdf" textEncodingName:nil baseURL:nil];

        [self.activityIndicator stopAnimating];
        self.activityIndicator.hidden = YES;
        
    }];
}

#pragma mark - NOTIFICATION_CHANGE_ROW_TABLE_VIEW

- (void)didChangeRowTableView:(NSNotification*) info{
    
    //Recupero el libro
    
    NSDictionary *dic = [info userInfo];
    
    POLBook *book = [dic objectForKey:KEY_NOTIFICATION_CHANGE_ROW_TABLE_VIEW];
    
    self.model = book;
    
    [self syncViewModel];
}

@end
