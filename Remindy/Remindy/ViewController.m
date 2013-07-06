//
//  ViewController.m
//  Remindy
//
//  Created by Shaohuan Li on 23/6/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "ViewController.h"
//#import "AFJSONRequestOperation.h"

@interface ViewController ()
@end

@implementation ViewController

@synthesize eventTableView,events,loginView,myCache;

- (void)viewDidLoad
{
    [super viewDidLoad];
    myCache = [[NSCache alloc] init]; 
    NSLog(@"token %@",[myCache objectForKey:@"token"]);
    
	NSString *apikey = @"ziGsQQOz1ymvjT2ZRQzDp";
    
	[loginView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    
	NSString *redirectUrlString = @"http://ivle.nus.edu.sg/api/login/login_result.ashx";
	NSString *authFormatString = @"https://ivle.nus.edu.sg/api/login/?apikey=%@";
    
    NSString *urlString = [NSString stringWithFormat:authFormatString, apikey, redirectUrlString];
	NSURL *url = [NSURL URLWithString:urlString];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
	[loginView loadRequest:request];
    loginView.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
    events = [[NSMutableArray alloc] init];
    eventTableView.dataSource = self;
    eventTableView.delegate = self;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	
    NSString *urlString = request.URL.absoluteString;
	NSLog(@"urlString: %@", urlString);
	
    [self checkForAccessToken:urlString];
    
    return TRUE;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"finished lodding");
}

-(void)checkForAccessToken:(NSString *)urlString {
	
    
	NSError *error;
    
	NSLog(@"checkForAccessToken: %@", urlString);
	NSRegularExpression *regex = [NSRegularExpression
								  regularExpressionWithPattern:@"r=(.*)"
								  options:0 error:&error];
    if (regex != nil) {
        NSTextCheckingResult *firstMatch =
		[regex firstMatchInString:urlString
						  options:0 range:NSMakeRange(0, [urlString length])];
        if (firstMatch) {
            NSRange accessTokenRange = [firstMatch rangeAtIndex:1];
            NSString *success = [urlString substringWithRange:accessTokenRange];
            success = [success
                       stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
			
			//check for r=0
			NSLog(@"success: %@", success);
			
			if ([success isEqualToString:@"0"]) {
				NSURL *responseURL = [NSURL URLWithString:urlString];
                
				NSString *token = [NSString stringWithContentsOfURL:responseURL
														   encoding:NSASCIIStringEncoding
															  error:&error];
				//print out the token or save for next logon or to navigate to next API call.
				[myCache setObject:token forKey:@"token"];
                [self getUid];
                [self getModules];
               /* NSString *content = [NSString stringWithContentsOfURL:url];
                NSLog(@"content%@",content);
                NSString *moduleUrlString =[NSString stringWithFormat:@"https://ivle.nus.edu.sg/api/Lapi.svc/Modules?APIKey=%@&AuthToken=%@&Duration=%d&IncludeAllInfo=%@", apikey, token,1000,@"true"];
                url = [NSURL URLWithString:moduleUrlString];
                content = [NSString stringWithContentsOfURL:url];
                NSLog(@"content%@",content);*/
                
			}
            
            
        }
	}
    
}
- (void)getUid{
    NSString *token=[myCache objectForKey:@"token"];
    NSString *apikey = @"ziGsQQOz1ymvjT2ZRQzDp";
    NSString *useridUrlString = [NSString stringWithFormat:@"https://ivle.nus.edu.sg/api/Lapi.svc/UserID_Get?APIKey=%@&Token=%@", apikey, token];
    NSURL *url = [NSURL URLWithString:useridUrlString];
    NSLog(@"getting uid");
    NSString *uid = [NSString stringWithContentsOfURL:url];
    NSLog(@"uid%@",uid);
}
- (void)getModules{
    NSString *token=[myCache objectForKey:@"token"];
    NSString *apikey = @"ziGsQQOz1ymvjT2ZRQzDp";
    NSString *moduleUrlString = [NSString stringWithFormat:@"https://ivle.nus.edu.sg/api/Lapi.svc/Modules?APIKey=%@&AuthToken=%@&Duration=%d&IncludeAllInfo=%@", apikey, token,1000,@"true"];
    NSURL *url = [NSURL URLWithString:moduleUrlString];
    /*NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"Module Information: %@", JSON);
    } failure:nil];
    [operation start];*/
    NSString *content = [NSString stringWithContentsOfURL:url];
    
    NSLog(@"content%@",content);
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [events count];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventModel *event = [events objectAtIndex:[indexPath row]];
    //[[EventViewController alloc]init];
    NSLog(@"%@",event);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CommentCell";
    
    EventModel *event = [events objectAtIndex:[indexPath row]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    [[cell textLabel] setText:event.eventTitle];
    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
