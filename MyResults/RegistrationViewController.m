//
//  RegistrationViewController.m
//  MyResults
//
//  Created by Dayanand Deshpande on 7/09/14.
//  Copyright (c) 2014 Jay Deshpande. All rights reserved.
//

//
//  RegistrationViewController.m
//  Registration
//
//  Created by Dayanand Deshpande on 24/08/14.
//  Copyright (c) 2014 Jay Deshpande. All rights reserved.
//

#import "RegistrationViewController.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)RegisterMeClicked:(id)sender {
    
    NSInteger success = 0;
    @try {
    
     if([[self.Username_Text text] isEqualToString:@""] || [[self.Password_Text text] isEqualToString:@""]|| [[self.Email_Text text] isEqualToString:@""]||[[self.F_Name_Text text] isEqualToString:@""] ||[[self.L_Name_Text text] isEqualToString:@""]  ) {
         
        [self alertStatus:@"Please enter Email and Password" :@"Sign in Failed!" :0];
     
     }
     
     else {
         
         NSString *url = [NSString stringWithFormat:@"http://deshpande.net.nz/Registration.php?F_Name='%@'&L_Name='%@'&Email='%@'&Username='%@'&Password='%@'",[self.F_Name_Text text],[self.L_Name_Text text],[self.Email_Text text], [self.Username_Text text],[self.Password_Text text]];
    
         NSLog(@"URL: %@", url);
    // build the request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSMutableData *body= [NSMutableData data];
    [request setHTTPBody:body];
    
    NSError *error = [[NSError alloc] init];
     NSHTTPURLResponse *response = nil;
    
    
    // getting answer from the server.
    // you can echo message from the server let's say :"Update finish" or something like that...
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
         // NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"returned: %@", returnString);
    
         NSLog(@"Response code: %ld", (long)[response statusCode]);
         
         if ([response statusCode] >= 200 && [response statusCode] < 300)
         {
             NSString *responseData = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
             NSLog(@"Response ==> %@", responseData);
             
             NSError *error = nil;
             NSDictionary *jsonData = [NSJSONSerialization
                                    JSONObjectWithData:returnData
                                       options:NSJSONReadingMutableContainers
                                       error:&error];
             
             
             success = [jsonData[@"success"] integerValue];
            // NSString *substring = [aString substringWithRange:NSMakeRange(15, 5)];
             NSLog(@"Success: %ld",(long)success);
             
             if(success == 1)
            {
                NSLog(@"Username already registered");
                 NSString *error_msg = (NSString *) jsonData[@"error_message"];
                 [self alertStatus:error_msg :@"Username not available!" :0];
             }
             else if(success==2){
                 NSLog(@"Registration SUCCESS");

             
             }
            
         }else {
             //if (error) NSLog(@"Error: %@", error);
             [self alertStatus:@"Connection Failed" :@"Sign in Failed!" :0];
         }

     }
}

    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Registration Failed." :@"Error!" :0];
    }
    if (success==2) {
        [self performSegueWithIdentifier:@"registration_success" sender:self];
    }
}

- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
}
- (IBAction)BackgroundTap:(id)sender {
    [self.view endEditing:YES];
}
- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}

@end
