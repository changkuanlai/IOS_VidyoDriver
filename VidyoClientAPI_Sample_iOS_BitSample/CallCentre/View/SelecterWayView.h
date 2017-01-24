//
//  SelecterWayView.h
//  VidyoMobile
//
//  Created by 赖长宽 on 2017/1/4.
//  Copyright © 2017年 changkuan.lai.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelecterWayView : UIView

@property (nonnull,copy) void (^Block)();


+(instancetype)showXib;


@end
