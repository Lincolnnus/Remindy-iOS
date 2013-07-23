//
//  ModuleViewController.m
//  Remindy
//
//  Created by Shaohuan Li on 6/7/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "ModuleViewController.h"
#import "EventViewController.h"
#import "constants.h"
#import "serverUtil.h"
#import "dataUtil.h"

@interface ModuleViewController ()

@end

@implementation ModuleViewController

@synthesize modules,moduleTableView,selectedModule,uid,destViewController,eventList,token,moduleData;

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
    moduleTableView.dataSource = self;
    moduleTableView.delegate = self;
    uid = [[dataUtil sharedInstance] uid];
    token = [[dataUtil sharedInstance]token];
    modules = [[NSArray alloc]init];
    [self checkForModules];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [modules count];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedModule =[modules objectAtIndex:[indexPath row]];
    
    [self performSegueWithIdentifier:@"showEventView" sender:self];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ModuleCell";
    NSDictionary *module = [modules objectAtIndex:[indexPath row]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    [[cell textLabel] setText:[module objectForKey:@"CourseCode"]];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showEventView"]) {
        destViewController = [[EventViewController alloc] init];
        destViewController = segue.destinationViewController;
        [destViewController setModuleCode:[selectedModule objectForKey:@"CourseCode" ] andUid:uid];
    }
}
- (void)checkForModules{
    NSString *apikey = @"ziGsQQOz1ymvjT2ZRQzDp";
    NSString *moduleUrlString = [NSString stringWithFormat:@"https://ivle.nus.edu.sg/api/Lapi.svc/Modules?APIKey=%@&AuthToken=%@&Duration=%d&IncludeAllInfo=%@", apikey, token,1000,@"true"];
    NSURL *url = [NSURL URLWithString:moduleUrlString];
    
    moduleData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (theConnection) {
        // Create the NSMutableData to hold the received data.
        // receivedData is an instance variable declared elsewhere.
        NSLog(@"success");
        //moduleData = [NSMutableData data];
    } else {
        // Inform the user that the connection failed.
        NSLog(@"failed");
    }
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [moduleData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"receivedData");
    [moduleData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    NSLog(@"Connection failed: %@", [error description]);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:moduleData options:NSJSONReadingMutableLeaves error:&myError];
    
    // extract specific value...
    modules = [res objectForKey:@"Results"];
    [[dataUtil sharedInstance] setModules:modules];
    NSLog(@"here");
    [moduleTableView reloadData];
    
}

@end
