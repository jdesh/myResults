//
//  HomeModel.m
//  MyResults
//
//  Created by Dayanand Deshpande on 7/09/14.
//  Copyright (c) 2014 Jay Deshpande. All rights reserved.
//

#//
//  HomeModel.m
//  Views2
//
//  Created by Dayanand Deshpande on 17/07/14.
//  Copyright (c) 2014 Jay Deshpande. All rights reserved.
//

#import "HomeModel.h"
#import "User.h"

@interface HomeModel()
{
    NSMutableData *_downloadedData;
}
@end

@implementation HomeModel

- (void)downloadItems
{
    // Download the json file
    NSURL *jsonFileUrl = [NSURL URLWithString:@"http://deshpande.net.nz/service.php"];
    //NSURL *jsonFileUrl = [NSURL URLWithString:@"http://deshpande.net.nz/user_subjects?u_id=1"];
    
    // Create the request
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    
    // Create the NSURLConnection
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
}

#pragma mark NSURLConnectionDataProtocol Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Initialize the data object
    _downloadedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the newly downloaded data
    [_downloadedData appendData:data];
    NSLog(@"downloded subjects is %@ ",data);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Create an array to store the locations
    NSMutableArray *_users = [[NSMutableArray alloc] init];
    
    // Parse the JSON that came in
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    // Loop through Json objects, create question objects and add them to our questions array
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *jsonElement = jsonArray[i];
        
        
        // Create a new location object and set its props to JsonElement properties
        User *newUser = [[User alloc] init];
        newUser.F_Name = jsonElement[@"F_Name"];
        newUser.L_Name = jsonElement[@"L_Name"];
        newUser.U_ID = jsonElement[@"U_ID"];
        
        
        // Add this question to the locations array
        [_users addObject:newUser];
    }
    NSLog(@"jsonObject is %@ with error %@",jsonArray, error);
    
    // Ready to notify delegate that data is ready and pass back items
    if (self.delegate)
    {
        [self.delegate itemsDownloaded:_users];
    }
}

@end
