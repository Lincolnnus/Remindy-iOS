//
//  AddEventViewController.h
//  Remindy
//
//  Created by Shaohuan Li on 8/7/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventModel.h"
@interface AddEventViewController : UIViewController 
@property (strong, nonatomic) IBOutlet UITextField *description;
@property (strong, nonatomic) IBOutlet UITextField *eventTitle;
@property (strong, nonatomic) IBOutlet UIDatePicker *myDateTime;
@property (nonatomic) EventModel *event;
@property (nonatomic) NSString *moduleCode;
@property (nonatomic) NSString *uid;
@end
