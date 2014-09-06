//
//  GetSubjects.m
//  MyResults
//
//  Created by Dayanand Deshpande on 7/09/14.
//  Copyright (c) 2014 Jay Deshpande. All rights reserved.
//

#import "GetSubjects.h"
#import "subject.h"

@interface GetSubjects()
{
    NSMutableData *_downloadedSubjects;
}
@end

@implementation GetSubjects

- (void)downloadSubjects:(int)uid
{
    NSString *str1 = @"http://deshpande.net.nz/subjects.php?u_id=";
    NSString *str2 = [NSString stringWithFormat:@"%d",uid];
    NSString *str3 =[str1 stringByAppendingString:str2];
    // Download the json file
    NSURL *jsonFileUrl = [NSURL URLWithString:str3];
    
    // Create the request
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    
    // Create the NSURLConnection
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
}

#pragma mark NSURLConnectionDataProtocol Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Initialize the data object
    _downloadedSubjects = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the newly downloaded data
    [_downloadedSubjects appendData:data];
    NSLog(@"downloded subjects is %@ ",data);
    NSLog(@"jsonObject is with error");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Create an array to store the locations
    NSMutableArray *_subjects = [[NSMutableArray alloc] init];
    
    NSData *jsonData = _downloadedSubjects;
    const unsigned char *ptr = [jsonData bytes];
    
    for(int i=0; i<[jsonData length]; ++i) {
        unsigned char c = *ptr++;
        NSLog(@"char=%c hex=%x", c, c);
    }
    
    // Parse the JSON that came in
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedSubjects options:NSJSONReadingAllowFragments error:&error];
    
    // Loop through Json objects, create question objects and add them to our questions array
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *jsonElement = jsonArray[i];
        
        
        // Create a new location object and set its props to JsonElement properties
        subject *newsubject = [[subject alloc] init];
        newsubject.F_Name = jsonElement[@"F_Name"];
        newsubject.L_Name = jsonElement[@"L_Name"];
        newsubject.U_ID = jsonElement[@"U_ID"];
        newsubject.Subject_Name = jsonElement[@"Subject_Name"];
        newsubject.Year = jsonElement[@"Year"];
        newsubject.Total_Credits = jsonElement[@"Total_Credits"];
        newsubject.Pass_Credits = jsonElement[@"Pass_Credits"];
        newsubject.S_ID = jsonElement[@"S_ID"];
        
        
        // Add this question to the locations array
        [_subjects addObject:newsubject];
    }
    NSLog(@"jsonObject is %@ with error %@",jsonArray, error);
    
    // Ready to notify delegate that data is ready and pass back items
    if (self.delegate)
    {
        [self.delegate SubjectsDownloaded:_subjects];
    }
}

@end
