//
//  NotificationMeetingCell.m
//  VidyoMobile
//
//  Created by 赖长宽 on 2017/1/6.
//  Copyright © 2017年 changkuan.lai.com. All rights reserved.
//

#import "NotificationMeetingCell.h"

@interface NotificationMeetingCell()


@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *startdateAndEnd;
@property (weak, nonatomic) IBOutlet UILabel *roomtopic;

@property (weak, nonatomic) IBOutlet UILabel *roomOrganizer;

@end



@implementation NotificationMeetingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setMeeting:(NotificationMeetingModel *)meeting
{
    _meeting=meeting;
    
    self.startdateAndEnd.text=[NSString stringWithFormat:@"%@ %@",meeting.startdate,meeting.enddate];
    self.roomtopic.text=meeting.roomtopic;
    self.roomOrganizer.text=[NSString stringWithFormat:@"组织者:%@",meeting.roomOrganizer];

}
-(void)setFrame:(CGRect)frame
{
    
    frame.origin.y+=5;
  frame.size.height=frame.size.height-5;
    [super setFrame:frame];

}
@end
