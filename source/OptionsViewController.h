//
//  OptionsViewController.h
//  passwordmatrix
//
//  Created by Chris Comeau on 10-02-12.
//  Copyright 2010 Games Montreal. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OptionsViewController : UIViewController <UITextFieldDelegate> {

	NSString *keyString;
	//passwordmatrixAppDelegate *appDelegate;
	id appDelegate;
    
    bool isVisible;
	
    UIScrollView *backScrollView;
    
	IBOutlet UITextField *keyText;
	IBOutlet UIButton *keyButton;
	IBOutlet UIButton *helpButton;
	IBOutlet UIButton *emailButton;

	IBOutlet UISwitch *switchUppercase;
	IBOutlet UISwitch *switchRememberKey;
	IBOutlet UISwitch *switchSymbols;
	IBOutlet UISwitch *switchNumbers;
	IBOutlet UISwitch *switchSound;
	IBOutlet UISwitch *switchDefaultConvert;

    IBOutlet UILabel *label1;
    IBOutlet UILabel *label2;
    IBOutlet UILabel *label3;
    IBOutlet UILabel *label4;
    IBOutlet UILabel *label5;
    IBOutlet UILabel *label6;
    IBOutlet UILabel *label7;
}

- (void)setupUI;
- (void)notifyForeground;

@property(nonatomic,retain) IBOutlet UITextField *keyText;
@property(nonatomic,retain) IBOutlet UIButton *keyButton;
@property(nonatomic,retain) IBOutlet UIButton *helpButton;
@property(nonatomic,retain) IBOutlet UIButton *emailButton;
@property (nonatomic, retain) IBOutlet UIScrollView *backScrollView;

@property(nonatomic,retain) IBOutlet UISwitch *switchUppercase;
@property(nonatomic,retain) IBOutlet UISwitch *switchRememberKey;
@property(nonatomic,retain) IBOutlet UISwitch *switchSymbols;
@property(nonatomic,retain) IBOutlet UISwitch *switchNumbers;
@property(nonatomic,retain) IBOutlet UISwitch *switchSound;
@property(nonatomic,retain) IBOutlet UISwitch *switchDefaultConvert;

@property(nonatomic,retain) IBOutlet UILabel *label1;
@property(nonatomic,retain) IBOutlet UILabel *label2;
@property(nonatomic,retain) IBOutlet UILabel *label3;
@property(nonatomic,retain) IBOutlet UILabel *label4;
@property(nonatomic,retain) IBOutlet UILabel *label5;
@property(nonatomic,retain) IBOutlet UILabel *label6;
@property(nonatomic,retain) IBOutlet UILabel *label7;


@end
