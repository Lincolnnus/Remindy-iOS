//
//  EventTableCell.m
//  Remindy
//
//  Created by Shaohuan Li on 8/7/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "EventTableCell.h"
#import "serverUtil.h"

@implementation EventTableCell
@synthesize eventTitle,deadline,description,moduleCode,thumbDownButton,thumbUpButton,agreed,disagreed,viewerMatricNumber,eventID,agreeNumLabel,disagreeNumLabel,agreement;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
- (IBAction)thumbUpPressed:(id)sender {
    // Agreed before, cancel it:
    if(agreed){
        [thumbUpButton setImage:[UIImage imageNamed:@"thumb_up_grey.png"] forState:UIControlStateNormal];
        agreed = NO;
        [serverUtil user:viewerMatricNumber cancelAgreeOrDisagreeOfEvent:eventID completeHandler:^(id data, NSError *error) {
            if (error) {
                agreeNumLabel.text = [NSString stringWithFormat:@"%d", agreeNumLabel.text.integerValue + 1];
                [SVProgressHUD showErrorWithStatus:error.localizedDescription];
            }
        }];
        agreeNumLabel.text = [NSString stringWithFormat:@"%d", agreeNumLabel.text.integerValue - 1];
    }
    
    else{
        [thumbUpButton setImage:[UIImage imageNamed:@"thumb_up.png"] forState:UIControlStateNormal];
        
        agreed = YES;
        
        agreeNumLabel.text = [NSString stringWithFormat:@"%d", agreeNumLabel.text.integerValue + 1];
        
        [serverUtil user:viewerMatricNumber agrees:YES EventWithID:eventID completeHandler:^(id data, NSError *error) {
            if (error) {
                [SVProgressHUD showErrorWithStatus:error.localizedDescription];
            }
        }];

        if (disagreed){
            
            [thumbDownButton setImage:[UIImage imageNamed:@"thumb_down_grey.png"] forState:UIControlStateNormal];
        
            disagreed = NO;
                        
            disagreeNumLabel.text = [NSString stringWithFormat:@"%d", disagreeNumLabel.text.integerValue - 1];

        }
    }
}


- (IBAction)thumbDownPressed:(id)sender {
    if(disagreed){
        [thumbDownButton setImage:[UIImage imageNamed:@"thumb_down_grey.png"] forState:UIControlStateNormal];
        disagreed = NO;
        
        [serverUtil user:viewerMatricNumber cancelAgreeOrDisagreeOfEvent:eventID completeHandler:^(id data, NSError *error) {
            if (error) {
                disagreeNumLabel.text = [NSString stringWithFormat:@"%d", disagreeNumLabel.text.integerValue + 1];
                [SVProgressHUD showErrorWithStatus:error.localizedDescription];
            }
        }];
        disagreeNumLabel.text = [NSString stringWithFormat:@"%d", disagreeNumLabel.text.integerValue - 1];
    }else{
        [thumbDownButton setImage:[UIImage imageNamed:@"thumb_down.png"] forState:UIControlStateNormal];
        disagreed = YES;
        disagreeNumLabel.text = [NSString stringWithFormat:@"%d", disagreeNumLabel.text.integerValue + 1];

        [serverUtil user:viewerMatricNumber agrees:NO EventWithID:eventID completeHandler:^(id data, NSError *error) {
            if (error){
                [SVProgressHUD showErrorWithStatus:error.localizedDescription];
            }
        }];

        if (agreed){
            
            [thumbUpButton setImage:[UIImage imageNamed:@"thumb_up_grey.png"] forState:UIControlStateNormal];
           
            agreed = NO;
        
            agreeNumLabel.text = [NSString stringWithFormat:@"%d", agreeNumLabel.text.integerValue - 1];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
