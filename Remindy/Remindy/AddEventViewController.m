//
//  AddEventViewController.m
//  Remindy
//
//  Created by Shaohuan Li on 8/7/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "AddEventViewController.h"
#import "serverUtil.h"

@interface AddEventViewController ()

@end

@implementation AddEventViewController
@synthesize moduleCode,eventTitle,description,myDateTime,event,uid;

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
    [self.view endEditing:YES];
	// Do any additional setup after loading the view.
}
- (IBAction)addNewEvent:(id)sender {
    event = [[EventModel alloc] initWithModuleCode:moduleCode andEventTitle:eventTitle.text andDescription:description.text andDeadline:myDateTime.date];
    [serverUtil user:uid addEvent:event];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
