//
//  EventTableCell.h
//  Remindy
//
//  Created by Shaohuan Li on 8/7/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventTableCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *eventTitle;
@property (strong, nonatomic) IBOutlet UILabel *deadline;
@property (strong, nonatomic) IBOutlet UILabel *moduleCode;
@property (strong, nonatomic) IBOutlet UILabel *description;
@property (strong, nonatomic) IBOutlet UILabel *numLike;
@property (strong, nonatomic) IBOutlet UILabel *numDislike;
@property (strong, nonatomic) IBOutlet UIButton *thumbUpButton;
@property (strong, nonatomic) IBOutlet UIButton *thumbDownButton;

@property (strong, nonatomic) IBOutlet UILabel *agreeNumLabel;
@property (strong, nonatomic) IBOutlet UILabel *disagreeNumLabel;


@property (nonatomic) Boolean agreed;
@property (nonatomic) Boolean disagreed;

@end
