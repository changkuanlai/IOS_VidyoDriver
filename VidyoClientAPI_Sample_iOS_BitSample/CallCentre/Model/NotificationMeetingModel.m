//
//  NotificationMeetingModel.m
//  VidyoMobile
//
//  Created by 赖长宽 on 2017/1/6.
//  Copyright © 2017年 changkuan.lai.com. All rights reserved.
//

#import "NotificationMeetingModel.h"

@implementation NotificationMeetingModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {
        self.roomurl=dict[@"roomurl"];
        self.roomid=dict[@"roomid"];
        self.roomname=dict[@"roomname"];
        self.startdate=dict[@"startdate"];
        self.enddate=dict[@"enddate"];
        self.roomtopic=dict[@"roomtopic"];
        self.roomOrganizer=dict[@"roomOrganizer"];
    }
    return self;
}
+(instancetype) appWithDict:(NSDictionary *)dict{
    
    // 为何使用self，谁调用self方法 self就会指向谁！！
    return [[self alloc] initWithDict:dict];
    
}
@end
