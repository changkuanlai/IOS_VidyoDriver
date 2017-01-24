//
//  VidyoVideoViewController.m
//  VidyoMobile
//
//  Created by 赖长宽 on 2017/1/5.
//  Copyright © 2017年 changkuan.lai.com. All rights reserved.
//

#import "VidyoVideoViewController.h"
#include "VidyoClient.h"
#import "VidyoClientSample_iOS_AppDelegate.h"
#import "LoginWindow.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height



@interface VidyoVideoViewController ()
@property (weak, nonatomic) IBOutlet UIView *headerLogoView;

@property (weak, nonatomic) IBOutlet UIView *chatTextView;
@property (weak, nonatomic) IBOutlet UITextField *fieldText;
@property (nonatomic ,strong) UILabel *label ;
@property (weak, nonatomic) IBOutlet UIView *tbBarView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;




@property (nonatomic ,strong) UIView * myCaptureLayer;


@end

@implementation VidyoVideoViewController



bool getBool(VidyoVoidPtr param,VidyoClientInEvent event){
    
    VidyoClientInEventMute *eventmute;
    
    if (event < VIDYO_CLIENT_IN_EVENT_MIN) {
        
        
        
    }
    event = (VidyoClientInEventMute *)param;
    VidyoBool isWillou= eventmute->willMute;
    
    NSLog(@"%d",isWillou);
    
    
    return NO;
}

-(void)viewDidLoad
{
    
    [super viewDidLoad];
    
    
    
  
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    VidyoClientInEventEnable cons={0};
    VidyoClientSendEvent(VIDYO_CLIENT_IN_EVENT_ENABLE_BUTTON_BAR, &cons, sizeof(cons));
    cons.willEnable=VIDYO_FALSE;
    
    
}
#pragma s 聊天
- (IBAction)textBtn:(id)sender {
    
    
    self.chatTextView.hidden=NO;
    
    VidyoClientDeviceInfo info={0};
    (void)VidyoClientSendEvent(VIDYO_CLIENT_IN_EVENT_TOGGLE_CAMERA , &info, sizeof(info));
    
    info.location=VIDYO_VIDEOCAPTURERLOCATION_Back;
    
    
}
 // 禁止话筒输入
- (IBAction)switchBtn:(id)sender {
    
    
   
    
    
    VidyoClientFeatureControl  conf={0};
    
    VidyoClientSendEvent(VIDYO_CLIENT_IN_EVENT_PRECALL_TEST_MICROPHONE, &conf, sizeof(VidyoClientRequestConfiguration));
    
    conf.disableLocalMicrophone=VIDYO_TRUE;

}

 // 扬声器
- (IBAction)theSpeakerBtn:(id)sender {
    
    VidyoClientFeatureControl  conf={0};
    VidyoClientSendEvent(VIDYO_CLIENT_IN_EVENT_SELECT_SPEAKER, &conf, sizeof(VidyoClientRequestConfiguration));
    conf.disableLocalSpeaker =VIDYO_FALSE;
    
}
 // 全屏
- (IBAction)fullScree {
    
    self.headerLogoView.hidden=YES;
    self.tbBarView.hidden=YES;
//
//    VidyoClientRequestSetLayoutRect * conf;
//    VidyoClientSendEvent(VIDYO_CLIENT_IN_EVENT_PREVIEW, &conf, sizeof(VidyoClientRequestConfiguration));

    VidyoRect videoRect
    = {(VidyoInt)(self.view.frame.origin.x), (VidyoInt)(self.view.frame.origin.y),
        (VidyoUint)(self.view.frame.size.width), (VidyoUint)(self.view.frame.size.height)};
  
    //    VidyoWindowId vidyoWin = (__bridge VidyoWindowId)(/*NULL*/window);
    //    (void)GuiSendPrivateRequest(VIDYO_CLIENT_PRIVATE_REQUEST_SET_GUI_WINDOW,
    //                                &vidyoWin, sizeof(vidyoWin), 0);
    

    (void)VidyoClientSendRequest(VIDYO_CLIENT_REQUEST_SET_LAYOUT_RECT, &videoRect, sizeof(videoRect));
    
    VidyoClientInEventResize event;
    event.height = videoRect.height;
    event.width = videoRect.width;
    event.x = videoRect.xPos;  
    event.y = videoRect.yPos;
    (void)VidyoClientSendEvent(VIDYO_CLIENT_IN_EVENT_RESIZE, &event, sizeof(event));
}
 // 关闭
- (IBAction)shutDown {
    

    
    
    //    VidyoWindowId vidyoWin = (__bridge VidyoWindowId)(/*NULL*/window);
    //    (void)GuiSendPrivateRequest(VIDYO_CLIENT_PRIVATE_REQUEST_SET_GUI_WINDOW,
    //                                &vidyoWin, sizeof(vidyoWin), 0);
    
    //    //Generate offset for the origin point
    //    videoRect.xPos = 50;
    //    videoRect.yPos = 100;
    
    
//    (void)VidyoClientSendRequest(VIDYO_CLIENT_REQUEST_SET_LAYOUT_RECT, &videoRect, sizeof(videoRect));
//    
//    VidyoClientInEventResize event;
//    event.height = 1;
//    event.width = 1;
//    event.x = 0;
//    event.y = -1;
//    (void)VidyoClientSendEvent(VIDYO_CLIENT_IN_EVENT_RESIZE, &event, sizeof(event));
//    
//    LoginWindow *ss=[[LoginWindow alloc]init];
//    VidyoClientSample_iOS_AppDelegate *app2 =[UIApplication sharedApplication].delegate;
//    
//    app2.window.rootViewController=ss;
    
    
    
   
 
//
    
    
}



// 静音
- (IBAction)muteBtn {
    
     VidyoClientInEventMute  conf = {0};
    static BOOL isopen ;
//
//    
    if (isopen) {
        
        conf.willMute=VIDYO_TRUE;
        
         VidyoClientSendEvent (VIDYO_CLIENT_IN_EVENT_MUTE_AUDIO_IN, &conf, sizeof(conf));
        
    }else{
        
//        VidyoClientSendRequest (VIDYO_CLIENT_IN_EVENT_MUTE_AUDIO_OUT, &conf, sizeof(conf));
        conf.willMute=VIDYO_FALSE;

    }
    
    isopen=!isopen;

    
}





-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
