//
//  ModuleViewController.h
//  Remindy
//
//  Created by Shaohuan Li on 6/7/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModuleViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *moduleTableView;
@property (nonatomic) NSArray *modules;
@property (nonatomic) NSDictionary *selectedModule;
@end
