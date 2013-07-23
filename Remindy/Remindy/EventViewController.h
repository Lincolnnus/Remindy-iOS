//
//  EventViewController.h
//  Remindy
//
//  Created by Shaohuan Li on 8/7/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic) NSString *moduleCode;
@property (nonatomic) NSString *matricNumber;
@property (nonatomic) NSArray *eventList;
@property (strong, nonatomic) IBOutlet UITableView *eventTable;

@end
