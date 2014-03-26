//
//  AboutViewController.m
//  RecipeBook
//
//  Created by Simon Ng on 24/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"
#import "AFNetworking.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

@synthesize webView;

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
	// Add code to load web content in UIWebView
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"about.html" ofType:nil]];
    //NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
    
    // old school way to load the contents of the web view element
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];

    //
    //PLAYING WITH AFNetworking stuff.
    //
    //1. JSON: by default AFHTTPRequestOperationManager only has JSON acceptable content types
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"https://powerful-reef-1950.herokuapp.com/api/gigs" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
    //2. HTML: now try to make a request without the 'request manager'. build the url, request and use
    //   AFHTTPRequestOperation class.
    NSURL *URL = [NSURL URLWithString:@"https/www.google.com"];
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:URL];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
    //op.responseSerializer = [AFJSONResponseSerializer serializer]; //this by default has JSON acceptable content types
    op.responseSerializer = [AFHTTPResponseSerializer serializer]; //this by default is nil
    op.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSLog(@"%@", op.responseSerializer.acceptableContentTypes);
    
    //set the blocks or which are another name for callbacks
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
