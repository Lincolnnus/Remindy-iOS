//
//  EventViewController.m
//  Remindy
//
//  Created by Shaohuan Li on 8/7/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "EventViewController.h"
#import "EventTableCell.h"
#import "serverUtil.h"
#import "constants.h"

@interface EventViewController ()

@end

@implementation EventViewController
@synthesize moduleCode,matricNumber,eventList,eventTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [eventList count];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected");
}

- (EventTableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EventTableCell";
    EventModel *event = [eventList objectAtIndex:[indexPath row]];
    EventTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EventTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    // Configure the cell
    cell.eventTitle.text = event.eventTitle;
    cell.description.text = event.description;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-mm-dd"];
    
    //Optionally for time zone converstions
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Singapore"]];
    cell.deadline.text = [formatter stringFromDate:event.deadline];
    cell.moduleCode.text = event.moduleCode;
    NSLog(@"hoho");
    return cell;
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

- (void)setEventList:(NSMutableArray *)eList{
    eventList = eList;
    //NSLog(@"elist%@",eList);
    for (EventModel* event in eList) {
        NSLog(@"Event title: %@ description: %@", event.eventTitle, event.description);
    }
    [eventTable reloadData];
}
-(void) setModuleCode:(NSString *)code andUid:(NSString *)uid{
    moduleCode = code;
    matricNumber = uid;
}

@end
