//
//  EventViewController.h
//  Remindy
//
//  Created by Shaohuan Li on 7/7/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface EventViewController : PFQueryTableViewController
@property (nonatomic) NSString *moduleCode;

-(void) setModuleCode:(NSString *)code;
@end
