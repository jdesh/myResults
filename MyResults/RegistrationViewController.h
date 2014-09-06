//
//  RegistrationViewController.h
//  MyResults
//
//  Created by Dayanand Deshpande on 7/09/14.
//  Copyright (c) 2014 Jay Deshpande. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *F_Name_Label;
@property (strong, nonatomic) IBOutlet UILabel *L_Name_Label;
@property (strong, nonatomic) IBOutlet UILabel *Email_Label;
@property (strong, nonatomic) IBOutlet UILabel *Username_Label;
@property (strong, nonatomic) IBOutlet UILabel *Password_Label;
@property (strong, nonatomic) IBOutlet UITextField *F_Name_Text;
@property (strong, nonatomic) IBOutlet UITextField *L_Name_Text;
@property (strong, nonatomic) IBOutlet UITextField *Email_Text;
@property (strong, nonatomic) IBOutlet UITextField *Username_Text;
@property (strong, nonatomic) IBOutlet UITextField *Password_Text;
- (IBAction)RegisterMeClicked:(id)sender;
- (IBAction)BackgroundTap:(id)sender;

@end