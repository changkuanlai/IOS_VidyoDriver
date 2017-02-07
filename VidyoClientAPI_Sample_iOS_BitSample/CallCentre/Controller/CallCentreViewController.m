//
//  CallCentreViewController.m
//  VidyoMobile
//
//  Created by 赖长宽 on 2017/1/4.
//  Copyright © 2017年 changkuan.lai.com. All rights reserved.
//

#import "CallCentreViewController.h"
#import "SelecterWayView.h"
#import "VidyoVideoViewController.h"
#import "NotificationMeetingCell.h"
#import "NotificationMeetingModel.h"
#import "QueueStatusViewController.h"
#import "NSString+Base64.h"
#import "ESClient.h"
#import "GuestloginViewController.h"
#include "VidyoClient.h"

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
@interface CallCentreViewController ()<UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *userNameLable;

@property(     weak, nonatomic) IBOutlet UITableView *TableView;
/** 数组*/
@property(nonatomic, strong) NSMutableArray * meetings;

@property(nonatomic, retain) NSMutableData *webData;
@property(nonatomic, retain) NSMutableString *vidyoEntityID;
@property(nonatomic, retain) NSXMLParser *xmlParser;
@property(nonatomic, assign) BOOL joinStatus;
@property(nonatomic, assign) BOOL isSigningIn;
@property(nonatomic, assign) BOOL isInCall;
@property(nonatomic, copy) NSString *vidyoClientStatus;
@property(nonatomic, copy) NSMutableString *soapResults;
@property(nonatomic, copy) NSMutableString *vidyoMemberStatus;

@property(nonatomic, assign) BOOL entityIDResult;
@property(nonatomic, assign) BOOL memberStatusResult;


@end
static NSString *const NotMeetingcellID=@"meeting";

@implementation CallCentreViewController
-(NSMutableArray *)meetings
{
    if (_meetings==nil) {
        _meetings=[NSMutableArray array];
        
        
    }
    return  _meetings;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _entityIDResult = FALSE;
    _memberStatusResult = FALSE;
    _joinStatus = FALSE;
    _vidyoMemberStatus = nil;
    _isSigningIn = TRUE;
    self.TableView.separatorStyle=0;
    self.TableView.backgroundColor=[UIColor grayColor];
   
   
      [self.TableView registerNib:[UINib nibWithNibName:NSStringFromClass([NotificationMeetingCell  class]) bundle:nil] forCellReuseIdentifier:NotMeetingcellID];
    
    [self setUprequest];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notifiLogin) name:@"loginSuccessful" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notifSignedin) name:@"Successfullysignedin" object:nil];

    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(20, 25, 40, 30)];
    [button addTarget:self action:@selector(exitlogin) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"退出" forState:UIControlStateNormal];
    button.backgroundColor=[UIColor lightGrayColor];
    
    [self.view addSubview:button];
    
    self.userNameLable.text=self.textName;
    
    UIButton *Guestbutton=[[UIButton alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width)-70, 25, 60, 30)];
    [Guestbutton addTarget:self action:@selector(Guestlogin) forControlEvents:UIControlEventTouchUpInside];
    [Guestbutton setTitle:@"客人加入" forState:UIControlStateNormal];
    Guestbutton.backgroundColor=[UIColor lightGrayColor];
        Guestbutton.titleLabel.font=[UIFont systemFontOfSize:13];

    [self.view addSubview:Guestbutton];
    
    
}
-(void)notifiLogin
{
    VidyoVideoViewController *vidyo=[[VidyoVideoViewController alloc]init];
    [self presentViewController:vidyo animated:NO completion:nil];
    
    
}
-(void)notifSignedin
{
    
    
    NSString *userPortal = @"http://192.168.5.47";
    
    
    /* The joinConference is broken into 2 steps
     * Step1: get the entityID from VidyoPortal using WS User::myAccount() API
     * Step2: if entityID is successfully retrieved and the entity is 'online', do WS User::joinConference
     */
    _vidyoEntityID = nil;
    NSString *urlString = [NSString stringWithFormat:@"%@/services/v1_1/VidyoPortalUserService", userPortal];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    // Get the EntityId from VidyoPortal using WS User::myAccount
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
                             "<env:Envelope xmlns:env=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:ns1=\"http://portal.vidyo.com/user/v1_1\">"
                             "<env:Body>"
                             "<ns1:MyAccountRequest/>"
                             "</env:Body>"
                             "</env:Envelope>"];
    
    // NSLog(@"%@", soapMessage);
    
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"myAccount" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    
    NSString *base64 = [[NSString stringWithFormat:@"%@:%@", @"test5", @"123456"] base64];
    NSString *auth = [NSString stringWithFormat:@"Basic %@", base64];
    [theRequest addValue: auth forHTTPHeaderField:@"Authorization"];
    
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if( theConnection )
    {
        _webData = [[NSMutableData data] init];
    }
    else
    {
        NSLog(@"theConnection is NULL");
    }
    
    _joinStatus = TRUE;
    //    NSLog(@"*********************SENT SOAP Request myAccount() ******************************");
    
    
    
    
    

}
// 退出登录
-(void)exitlogin
{
  
    
    
    

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   


}
-(void)Guestlogin
{
  
    GuestloginViewController *guestloginView=[[GuestloginViewController alloc]init];
    
    
    [self presentViewController:guestloginView animated:NO completion:nil];

}

                       
-(void)setUprequest
{

    
    dispatch_queue_t queue =  dispatch_queue_create("yx", NULL);
    
        dispatch_async(queue, ^{
            
            NSURLSession *session = [NSURLSession sharedSession];
            
            NSURL *url = [NSURL URLWithString:@"http://192.168.5.49:8580/Every360/Every360Api"];
            
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            
            //.修改请求方法为POST
            request.HTTPMethod = @"POST";
            
            request.HTTPBody = [@"operation=notifyVidyoRoom.action&userid=test5" dataUsingEncoding:NSUTF8StringEncoding];
       
            NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                
                //.解析数据
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                
                NSArray *arr=dict[@"conference"];
                for (NSDictionary  * dic in arr) {
                    NotificationMeetingModel *de=[NotificationMeetingModel appWithDict:dic];
                    [self.meetings addObject:de];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    [self.TableView reloadData];

                    
                });
                
                
            }];
            
            //.执行任务
            [dataTask resume];
            
            
        });

    

    

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.meetings.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotificationMeetingCell *cell=[tableView dequeueReusableCellWithIdentifier:NotMeetingcellID];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.meeting=self.meetings[indexPath.row];
    return cell;
}

- (IBAction)CellManager:(UIButton *)sender {
    
    [self CreateSelecterWayView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
- (IBAction)CallCenterButton:(UIButton *)sender {
    
    [self CreateSelecterWayView];
}
-(void)CreateSelecterWayView
{
//    SelecterWayView *wayView=[SelecterWayView showXib];
//    wayView.frame=CGRectMake(0, 0, Width, Height);
//    [self.view addSubview:wayView];
    
    
//    __block CallCentreViewController* blockSelf = self;
//    wayView.Block=^{
//        
//      __block  QueueStatusViewController *vc=[[QueueStatusViewController alloc]init];
//    
//        [blockSelf presentViewController:vc animated:NO completion:nil];
//        
//    };
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 110;
}
-(void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    VidyoClientInEventLogIn event = {0};
    NSString *userVPortal = @"http://192.168.5.47";
    NSString *userVName = @"test5";
    NSString *userVPass = @"123456";
    
    strlcpy(event.portalUri, [userVPortal UTF8String], sizeof(event.portalUri));
    strlcpy(event.userName, [userVName UTF8String], sizeof(event.userName));
    strlcpy(event.userPass, [userVPass UTF8String], sizeof(event.userPass));
    
    // hide keyboard
    //        [self.view endEditing:TRUE];
    
    //        /* Create wait alert */
    //        signingInAlert = [[[UIAlertView alloc] initWithTitle:@"Signing in\nPlease Wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil] autorelease];
    //        [signingInAlert show];
    //
    //        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //
    //        // Adjust the indicator so it is up a few pixels from the bottom of the alert
    //        indicator.center = CGPointMake(signingInAlert.bounds.size.width / 2, signingInAlert.bounds.size.height - 50);
    //        [indicator startAnimating];
    //        [signingInAlert addSubview:indicator];
    //        [indicator release];
    
    // send login-event to VidyoClient
    if (VidyoClientSendEvent(VIDYO_CLIENT_IN_EVENT_LOGIN, &event, sizeof(VidyoClientInEventLogIn)) == false)
    {
        //            [signingInAlert dismissWithClickedButtonIndex:0 animated:YES];
        
        NSString *alertMsg = [NSString stringWithFormat:@"Failed to sign in"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertMsg message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        //            [alert release];
        
    }
    else
    {
        _isSigningIn = TRUE;
        
        
    }
    
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_webData setLength: 0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"ERROR with theConenction");
   
}
// 数据请求完成调用
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"DONE. Received Bytes: %lu", (unsigned long)[_webData length]);
//    NSString *theXML = [[NSString alloc] initWithBytes: [_webData mutableBytes] length:[_webData length] encoding:NSUTF8StringEncoding];
//    NSLog(@"%@", theXML);
    
    
    
    
    _xmlParser = [[NSXMLParser alloc] initWithData: _webData];
    [_xmlParser setDelegate: self];
    [_xmlParser setShouldResolveExternalEntities: YES];
    [_xmlParser parse];
    
    
    // NSLog(@"entityID = %@", vidyoEntityID);
    /* Step2: Send the joinConference if the status is online */
    if ( _joinStatus )
    {
        NSString *urlString = [NSString stringWithFormat:@"%@/services/v1_1/VidyoPortalUserService",@"http://192.168.5.47"];
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableURLRequest *theJoinRequest = [NSMutableURLRequest requestWithURL:url];
        
        // Get the EntityId from VidyoPortal using WS User::myAccount
        
        NSString *soapJoinMessage = [NSString stringWithFormat:
                                     @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
                                     "<env:Envelope xmlns:env=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:ns1=\"http://portal.vidyo.com/user/v1_1\">"
                                     "<env:Body>"
                                     "<ns1:JoinConferenceRequest>"
                                     "<ns1:conferenceID>%@</ns1:conferenceID>"
                                     "</ns1:JoinConferenceRequest>"
                                     "</env:Body>"
                                     "</env:Envelope>", _vidyoEntityID];
        
        // NSLog(@"%@", soapJoinMessage);
        
        NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapJoinMessage length]];
        
        [theJoinRequest addValue: @"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [theJoinRequest addValue: @"joinConference" forHTTPHeaderField:@"SOAPAction"];
        [theJoinRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
        
        NSString *base64 = [[NSString stringWithFormat:@"%@:%@",@"test5", @"123456"] base64];
        NSString *auth = [NSString stringWithFormat:@"Basic %@", base64];
        [theJoinRequest addValue: auth forHTTPHeaderField:@"Authorization"];
        [theJoinRequest setHTTPMethod:@"POST"];
        [theJoinRequest setHTTPBody: [soapJoinMessage dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSURLConnection *theJoinConnection = [[NSURLConnection alloc] initWithRequest:theJoinRequest delegate:self];
        if( theJoinConnection )
        {
            _webData = [[NSMutableData data] init];
        }
        else
        {
            NSLog(@"theConnection is NULL");
        }
        
        _joinStatus = FALSE;
        NSLog(@"*********************SENT SOAP Request joinConference() ******************************/n");
    }
    
}

- (NSString*) getElementFromElementName: (NSString *) elementName
{
    NSArray *split = [elementName componentsSeparatedByString:@":"];
    
    if (!split || ([split count] != 2))
    {
        NSLog(@"Not a valid elementName '%@'", elementName);
        return NULL;
    }
    NSString *element = [split objectAtIndex:1];
    if (!element)
    {
        NSLog(@"Element is null");
        return NULL;
    }
    return [NSString stringWithString:element];
}

// 解析第一个代理

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
    NSString *element = [self getElementFromElementName:elementName];
    if (!element)
    {
        return;
    }
    /* separate namespace from element name */
    if( [element isEqualToString:@"entityID"])
    {
        if(!_vidyoEntityID)
        {
            _vidyoEntityID = [[NSMutableString alloc] initWithCapacity:256];
        }
        _entityIDResult = TRUE;
    }
    else if( [element isEqualToString:@"MemberStatus"])
    {
        if(!_vidyoMemberStatus)
        {
            _vidyoMemberStatus = [[NSMutableString alloc] initWithCapacity:256];
        }
        _memberStatusResult = TRUE;
        
    }
}
// 第二个代理
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if( _entityIDResult )
    {
        [_vidyoEntityID appendString: string];
        _entityIDResult = FALSE;
        // NSLog(@"entityID = %@", vidyoEntityID);
    }
    else if (_memberStatusResult)
    {
        [_vidyoMemberStatus appendString: string];
        _memberStatusResult = FALSE;
        
        // NSLog(@"Endpoint is %@", vidyoMemberStatus);
        if(![_vidyoMemberStatus isEqualToString:@"Online"])
        {
            _joinStatus = FALSE;
            
            // Show the alert with the XML that was received
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *alertMsg = [NSString stringWithFormat:@"User NOT online. Make sure User is Logged In"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertMsg message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
                
            });
        }else{
            [[NSNotificationCenter defaultCenter]postNotificationName:@"loginSuccessful" object:nil];

        }
    }
    
}
 // 第三个
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSString *element = [self getElementFromElementName:elementName];
    if (!element)
    {
        return;
    }
    

    
    if( [element isEqualToString:@"MyAccountResponse"])
    {
        _entityIDResult = FALSE;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
