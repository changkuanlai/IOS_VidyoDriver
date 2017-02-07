//
//  GuestloginViewController.m
//  VidyoClientSample_iOS
//
//  Created by 赖长宽 on 2017/1/24.
//
//

#import "GuestloginViewController.h"
#import "VidyoVideoViewController.h"
#import "VidyoClient.h"
#import "ESClient.h"

@interface GuestloginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *guestPortal;
@property (weak, nonatomic) IBOutlet UITextField *roomKeyField;
@property (weak, nonatomic) IBOutlet UITextField *guestnameField;
@property (weak, nonatomic) IBOutlet UITextField *roomPinField;

@property (weak, nonatomic) IBOutlet UIView *createRoomView;
@property (weak, nonatomic) IBOutlet UITextField *roomLocation;
@property (weak, nonatomic) IBOutlet UITextField *roomSubject;
@property (weak, nonatomic) IBOutlet UITextField *roomName;


@end

@implementation GuestloginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonGuestPressed:(id)sender {
    
    
    
    if (!([[_guestPortal text] hasPrefix:@"http://"] || [[_guestPortal text] hasPrefix:@"https://"]))
    {
        [_guestPortal setText:[NSString stringWithFormat:@"http://%@", [_guestPortal text]]];
    }
    
    

        
        // Initaite the local sign in process
        VidyoClientInEventRoomLink event = {0};
        NSString *guestVPortal = _guestPortal.text;
        NSString *guestVRoomKey = _roomKeyField.text;
        NSString *guestVName = _guestnameField.text;
        NSString *guestVRoomPin =_roomPinField.text;
        
        strlcpy(event.portalUri, [guestVPortal UTF8String], sizeof(event.portalUri));
        strlcpy(event.roomKey, [guestVRoomKey UTF8String], sizeof(event.roomKey));
        strlcpy(event.displayName, [guestVName UTF8String], sizeof(event.displayName));
        strlcpy(event.pin, [guestVRoomPin UTF8String], sizeof(event.pin));
        
        // hide keyboard
        [self.view endEditing:TRUE];
        
        
        // Removed this block of code on 3/18 of 3.3.4.0004 version of library, since it was causing issues on guest login.
        /* Create wait alert
         signingInAlert = [[[UIAlertView alloc] initWithTitle:@"Signing in\nPlease Wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil] autorelease];
         [signingInAlert show];
         
         UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
         
         // Adjust the indicator so it is up a few pixels from the bottom of the alert
         indicator.center = CGPointMake(signingInAlert.bounds.size.width / 2, signingInAlert.bounds.size.height - 50);
         [indicator startAnimating];
         [signingInAlert addSubview:indicator];
         [indicator release]; */
        
        // send login-event as guest to VidyoClient
        if (VidyoClientSendEvent(VIDYO_CLIENT_IN_EVENT_ROOM_LINK, &event, sizeof(VidyoClientInEventRoomLink)) == false)
        {
            UIAlertView *signingInAlert;

            
            [signingInAlert dismissWithClickedButtonIndex:0 animated:YES];
            
            NSString *alertMsg = [NSString stringWithFormat:@"Failed to sign in"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertMsg message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            
        }

    
    
    
    VidyoVideoViewController *vidyo=[[VidyoVideoViewController alloc]init];
    [self presentViewController:vidyo animated:NO completion:nil];
}
- (IBAction)createRoombutton:(id)sender {
    
    self.createRoomView.hidden=NO;
}
- (IBAction)determineCreateRoom:(id)sender {
    
    
    ESClient *client=[[ESClient alloc]init];
    
    NSDictionary *CreateRoomdict=@{
                                   @"roomName":self.roomName.text,
                                   @"roomLocation":self.roomLocation.text,
                                   @"roomSubject":self.roomSubject.text
                                   };
    
    [client  esClientCreateRoom:CreateRoomdict];
    
    
    
    client.actionBlock=^(NSDictionary *dict){
    
        [_guestPortal setText:@"http://192.168.5.47"];
        [_guestnameField setText:dict[@"userName"]];
        [_roomKeyField setText:dict[@"key"]];
        [_roomPinField setText:@""];
    
    };
    
    
    
    
    self.createRoomView.hidden=YES;

//    [self.createRoomView removeFromSuperview];
    
}
- (IBAction)queryRoom:(UIButton *)sender {
    
    
    
    
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
