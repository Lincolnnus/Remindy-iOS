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
#import "AddEventViewController.h"

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EventTableCell";
    EventModel *event = [eventList objectAtIndex:[indexPath row]];
    
    EventTableCell *cell = (EventTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EventTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    // Configure the cell
    cell.eventTitle.text = event.eventTitle;
    cell.description.text = event.description;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-mm-dd"];
    
    //Optionally for time zone converstions
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Singapore"]];
    cell.deadline.text = [formatter stringFromDate:event.deadline];
    cell.moduleCode.text = event.moduleCode;
    
    cell.agreeNumLabel.text = [NSString stringWithFormat:@"%d", event.numOfAgrees];
    cell.disagreeNumLabel.text = [NSString stringWithFormat:@"%d", event.numOfDisagrees];
    
    cell.viewerMatricNumber = matricNumber;
    cell.eventID = event.eventID;
    
    if (event.isCurrentViewerAgrees == kAGREED){
                
        cell.agreed = YES;
        [cell.thumbUpButton setImage:[UIImage imageNamed:@"thumb_up.png"] forState:UIControlStateNormal];

    }
    else if (event.isCurrentViewerAgrees == kDISAGREED){
                
        cell.disagreed = YES;
        [cell.thumbDownButton setImage:[UIImage imageNamed:@"thumb_down.png"] forState:UIControlStateNormal];

    }
    
    else{
        cell.agreed = NO;
        cell.disagreed = NO;
    }
    
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    eventTable.delegate = self;
    eventTable.dataSource =self;
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backBarButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setEventList:(NSMutableArray *)eList{
    eventList = eList;
    [eventTable reloadData];
}
-(void) setModuleCode:(NSString *)code andUid:(NSString *)uid{
    moduleCode = code;
    matricNumber = uid;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddEventView"]) {
        AddEventViewController* destViewController = [[AddEventViewController alloc] init];
        destViewController = segue.destinationViewController;
        destViewController.uid = matricNumber;
        destViewController.moduleCode =moduleCode;
    }
}

@end
