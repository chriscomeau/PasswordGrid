//
//  NewsViewController.h
//  passwordmatrix
//
//  Created by Chris Comeau on 10-02-12.
//  Copyright 2010 Games Montreal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface NewsViewController : UIViewController <UIWebViewDelegate,  MBProgressHUDDelegate> {

    id appDelegate;
    
    IBOutlet UIWebView *webView;
    IBOutlet UIActivityIndicatorView *spin;
    IBOutlet UITextView *error_text;
    
    MBProgressHUD *HUD;
    bool doHud;
    bool alreadyLoading;
}

- (void)hudTask;
- (void)showHud;


@property(nonatomic,retain)IBOutlet UIWebView *webView;
@property(nonatomic,retain)IBOutlet UIActivityIndicatorView *spin;
@property(nonatomic,retain)IBOutlet UITextView *error_text;

@end
