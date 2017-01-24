//
//  NotificationMeetingModel.h
//  VidyoMobile
//
//  Created by 赖长宽 on 2017/1/6.
//  Copyright © 2017年 changkuan.lai.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationMeetingModel : NSObject
/** 房间地址*/
@property (nonatomic ,copy) NSString * roomurl;

/** 房间地址id*/
@property (nonatomic ,copy) NSString * roomid;

/** 房间名字 */
@property (nonatomic ,copy) NSString * roomname;

/** 开始时间 */
@property (nonatomic ,strong) NSString * startdate;

/** 结束时间 */
@property (nonatomic ,strong) NSString * enddate;

/** 房间主题 */
@property (nonatomic ,copy) NSString * roomtopic;

/** 房间组织者*/
@property (nonatomic ,copy) NSString * roomOrganizer;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype) appWithDict:(NSDictionary *)dict;
@end
