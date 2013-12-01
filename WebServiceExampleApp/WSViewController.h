//
//  WSViewController.h
//  WebServiceExampleApp
//  This example loads the data from the URI specified. It makes the synchronous request and loads the data to the table view.
//  Created by CMGabriel on 27/11/13.
//  Copyright (c) 2013 Example. All rights reserved.
//

//Define the MACROS to be used for the URI and the API key that is to be accessed.
//#define API_KEY @"[YOUR_API_KEY]"
#define API_KEY @"qfk5my226dgnnwwvpqf5rxm4"
#define URI @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey="

#import <UIKit/UIKit.h>

@interface WSViewController : UITableViewController<UITableViewDataSource, UITableViewDataSource,NSURLConnectionDataDelegate>

//Stores the values for the data that is returned from the webservice.
@property (strong,nonatomic) NSMutableData *wsData;

//Stores the values for the final results in an array.
@property (strong,nonatomic) NSMutableArray *results;
@property (strong,nonatomic) NSMutableDictionary *jsonData;

@end
