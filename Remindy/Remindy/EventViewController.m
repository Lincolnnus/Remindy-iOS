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
#import "dataUtil.h"

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


- (void)rankEvent {
    
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
    [formatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
    //Optionally for time zone converstions
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Singapore"]];
    cell.deadline.text = [formatter stringFromDate:event.deadline];
    cell.moduleCode.text = event.moduleCode;
    
    cell.agreeNumLabel.text = [NSString stringWithFormat:@"%d", event.numOfAgrees];
    cell.disagreeNumLabel.text = [NSString stringWithFormat:@"%d", event.numOfDisagrees];
    
    cell.viewerMatricNumber = matricNumber;
    cell.eventID = event.eventID;
    if ([event.deadline compare:[NSDate date]]==NSOrderedAscending){
        cell.hidden = YES;
    }else{
        cell.deadline.textColor = [UIColor blueColor];
    }
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
    moduleCode = [[dataUtil sharedInstance] moduleCode];
    matricNumber = [[dataUtil sharedInstance]uid];
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backBarButton;
    [SVProgressHUD show];
    [serverUtil retrieveAllEventsOfModule:moduleCode withViewer:matricNumber completeHandler:^(id data, NSError *error) {
        if (!error){
            [SVProgressHUD dismiss];
             eventList = [((NSArray*) data)sortedArrayUsingSelector:@selector(compare:)];
            if ([eventList count] == 0) {
                [SVProgressHUD showSuccessWithStatus:@"No event in this module"];
            }
            [eventTable reloadData];
        } else {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddEventView"]) {
        AddEventViewController* destViewController = [[AddEventViewController alloc] init];
        destViewController = segue.destinationViewController;
        destViewController.uid = matricNumber;
        destViewController.moduleCode =moduleCode;
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setNeedsDisplay];
}


@end
