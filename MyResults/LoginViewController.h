//
//  LoginViewController.h
//  MyResults
//
//  Created by Dayanand Deshpande on 7/09/14.
//  Copyright (c) 2014 Jay Deshpande. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *Username_Login;
@property (strong, nonatomic) IBOutlet UITextField *Password_Login;
- (IBAction)signinClicked:(id)sender;
- (IBAction)backgroundClicked:(id)sender;

@end
