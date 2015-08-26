//
//  POLPDFViewController.h
//  HackerBookPro2
//
//  Created by Pawel Walicki on 21/5/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import <UIKit/UIKit.h>

@class POLBook;

@interface POLPDFViewController : UIViewController

@property (nonatomic,strong) POLBook *model;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (instancetype) initWithModel:(POLBook *)model;

@end
