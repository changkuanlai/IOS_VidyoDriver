//
//  SelecterWayView.m
//  VidyoMobile
//
//  Created by 赖长宽 on 2017/1/4.
//  Copyright © 2017年 changkuan.lai.com. All rights reserved.
//

#import "SelecterWayView.h"
#import "QueueStatusViewController.h"
@implementation SelecterWayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)showXib
{
  
    
    return [[NSBundle mainBundle]loadNibNamed:@"SelecterWayView"owner:nil options:nil][0];

}

-(void)awakeFromNib
{
    [super awakeFromNib];
  
    self.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.5];
}
- (IBAction)VoiceWay:(id)sender {
    
   
    [self removeFromSuperview];
}
- (IBAction)videoWay {
    
    self.Block();
    [self removeFromSuperview];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
 
    [self removeFromSuperview];
}
@end
