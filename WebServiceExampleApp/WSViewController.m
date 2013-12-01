//
//  WSViewController.m
//  WebServiceExampleApp
//
//  Created by CMGabriel on 27/11/13.
//  Copyright (c) 2013 Example. All rights reserved.
//

#import "WSViewController.h"

@interface WSViewController ()

@end

@implementation WSViewController

@synthesize wsData;
@synthesize results;
@synthesize jsonData;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Initiate the variables to store data to be used in the application.
    self.jsonData = [NSMutableDictionary dictionary];
    self.results = [NSMutableArray array];
    self.wsData = [[NSMutableData alloc] init];
    
    //Create the URL String using URI and API Key
    NSString *uriString = [NSString stringWithFormat:@"%@%@",URI,API_KEY];
    
    //Intial setup to make a call to webservice.
    NSURL *url = [NSURL URLWithString:uriString];
    
    //Create a request object to make a request to the URL.
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSData *data = [NSURLConnection
                    sendSynchronousRequest:request
                    returningResponse:&response
                    error:&error];
    
    if(error == nil)
    {
        [self.wsData appendData:data];
        self.jsonData = (NSMutableDictionary *)[NSJSONSerialization
                                                JSONObjectWithData:(NSMutableData *)self.wsData
                                                options:NSJSONReadingMutableContainers
                                                error:nil];
        
        self.results = [self.jsonData
                        objectForKey:@"movies"];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableView Datasource Methods
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.jsonData count];
}

#pragma mark TableView Delegate Methods

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CELL_IDENTIFIER = @"WEBSERVICETABLECELL";
    
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CELL_IDENTIFIER];
    }
    
    //Mainuplate data and set the cell text and image values.
    
    NSDictionary *resultDictionary = [self.results objectAtIndex:indexPath.row];
    NSDictionary *posterDictionary = [resultDictionary objectForKey:@"posters"];
    
    cell.textLabel.text = [resultDictionary objectForKey:@"title"];
    
    
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[posterDictionary objectForKey:@"thumbnail"]]]];
    return cell;
}


#pragma mark - NSURLConnectionDataDelegate methods

//These delegate methods are called when the call is made Asynchronously
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"Response Received %@",response.description);
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"Received Data ");
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //Code to handle the error conditions.
    NSLog(@"Cannot connect With the URL");
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Connection Did Finish Launching");
    
}

@end
