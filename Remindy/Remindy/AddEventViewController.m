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
	// Do any additional setup after loading the view.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (IBAction)addNewEvent:(id)sender {
    if((eventTitle.text.length >0)&&(description.text.length>0))
    {
    event = [[EventModel alloc] initWithModuleCode:moduleCode andEventTitle:eventTitle.text andDescription:description.text andDeadline:myDateTime.date];
    [serverUtil user:uid addEvent:event];
    [self.navigationController popViewControllerAnimated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error Creating Events!"                        message:@"Please check the title and description" delegate:self
cancelButtonTitle:@"Cancel"otherButtonTitles:@"OK",nil];
        [alert show];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
