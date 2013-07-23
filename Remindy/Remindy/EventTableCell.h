//
//  EventTableCell.h
//  Remindy
//
//  Created by Shaohuan Li on 8/7/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface EventTableCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *eventTitle;
@property (strong, nonatomic) IBOutlet UILabel *deadline;
@property (strong, nonatomic) IBOutlet UILabel *moduleCode;
@property (strong, nonatomic) IBOutlet UILabel *description;
@property (strong, nonatomic) IBOutlet UIButton *thumbUpButton;
@property (strong, nonatomic) IBOutlet UIButton *thumbDownButton;

@property (strong, nonatomic) IBOutlet UILabel *agreeNumLabel;
@property (strong, nonatomic) IBOutlet UILabel *disagreeNumLabel;

@property (strong, nonatomic) NSString *viewerMatricNumber;
@property (strong, nonatomic) NSString *eventID;
@property (strong, nonatomic) PFObject *agreement;

@property (nonatomic) Boolean agreed;
@property (nonatomic) Boolean disagreed;

- (IBAction)thumbDownPressed:(id)sender;
- (IBAction)thumbUpPressed:(id)sender;

@end
