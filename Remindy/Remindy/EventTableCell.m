//
//  EventTableCell.m
//  Remindy
//
//  Created by Shaohuan Li on 8/7/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "EventTableCell.h"

@implementation EventTableCell
@synthesize eventTitle,deadline,description,moduleCode,numDislike,numLike,thumbDownButton,thumbUpButton,agreed,disagreed;
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
        
    }
    
    else{
        [thumbUpButton setImage:[UIImage imageNamed:@"thumb_up.png"] forState:UIControlStateNormal];
        
        agreed = YES;
        
        [thumbDownButton setImage:[UIImage imageNamed:@"thumb_down_grey.png"] forState:UIControlStateNormal];
        
        disagreed = NO;
    }
}
- (IBAction)thumbDownPressed:(id)sender {
    if(disagreed){
        [thumbDownButton setImage:[UIImage imageNamed:@"thumb_down_grey.png"] forState:UIControlStateNormal];
        disagreed = NO;
        
    }else{
        [thumbDownButton setImage:[UIImage imageNamed:@"thumb_down.png"] forState:UIControlStateNormal];
        disagreed = YES;
        
        [thumbUpButton setImage:[UIImage imageNamed:@"thumb_up_grey.png"] forState:UIControlStateNormal];
        agreed = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
