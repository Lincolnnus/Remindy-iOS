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

@interface ModuleViewController ()

@end

@implementation ModuleViewController

@synthesize modules,moduleTableView,selectedModule,uid,destViewController,eventList;

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(retrievesEventNotification:) name:NOTIF_EVENT_OF_MODULE_RETRIEVED object:nil];
    
    [serverUtil retrieveAllEventsOfModule:(NSString *)[selectedModule objectForKey:@"CourseCode"]];
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
        [destViewController setEventList:eventList];
        [destViewController setModuleCode:[selectedModule objectForKey:@"CourseCode" ] andUid:uid];
    }
}

- (void) retrievesEventNotification:(NSNotification *) notification{
    NSLog(@"notification receieved!!!");
    
    NSDictionary *userInfo = notification.userInfo;
    
    eventList = [userInfo objectForKey: @"eventList"];
    for (EventModel *event in eventList) {
        NSLog(@"Module: %@ Event title: %@ description: %@ with deadline: %@", event.moduleCode, event.eventTitle, event.description, event.deadline);
    }
    
    [self performSegueWithIdentifier:@"showEventView" sender:self];
}

@end
