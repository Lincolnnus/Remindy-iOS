//
//  IVLELoginAppDelegate.h
//  IVLELogin
//
//  Created by Yasmin Musthafa on 5/27/11.
//  Copyright 2011 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IVLELoginViewController;

@interface IVLELoginAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    IVLELoginViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet IVLELoginViewController *viewController;

@end

