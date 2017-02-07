/*
 *  LoginWindow.m
 *  VidyoClientSample_iOS
 *
 *  Created by Chetan Gandhi on 08/19/11.
 *  Copyright 2011 Vidyo Inc. All rights reserved.
 *
 */

#import "LoginWindow.h"
#import "VidyoClientConstants.h"
#include "VidyoClient.h"
#import "CallCentreViewController.h"
#import "ESClient.h"
#import "GuestloginViewController.h"

@implementation LoginWindow




@synthesize signingInAlert,isSigningIn;



-(void) viewDidLoad
{
    [super viewDidLoad];

    
//    UIButton *Guestbutton=[[UIButton alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width)-70, 25, 55, 30)];
//    [Guestbutton addTarget:self action:@selector(Guestlogin) forControlEvents:UIControlEventTouchUpInside];
//    [Guestbutton setTitle:@"客人进入" forState:UIControlStateNormal];
//    Guestbutton.backgroundColor=[UIColor lightGrayColor];
//    Guestbutton.titleLabel.font=[UIFont systemFontOfSize:13];
//    [self.view addSubview:Guestbutton];
    
    //    [ESClient login];
    
}
-(void)Guestlogin
{
    
    GuestloginViewController *guestloginView=[[GuestloginViewController alloc]init];
    
    
    [self presentViewController:guestloginView animated:NO completion:nil];
    
}


- (IBAction)buttonPressed:(id)sender {
	

    /* If portal URL does not start with schema than put it there explicetly */
	
    if(  !usernameField.hasText || !passwordField.hasText){
      
        
        NSString *alertMsg = [NSString stringWithFormat:@"账号密码不能为空"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertMsg message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [alert release];

        return;
        
    }
    
	 
    ESClient *client=[[ESClient alloc]init];
        
    [client esClientLogin:usernameField.text  userName:passwordField.text  userPwd:@"" userDept:@"" userTel:@"" userEmail:@""];
    CallCentreViewController *coview=[[CallCentreViewController alloc]init];
    coview.textName=passwordField.text;
    
    [self presentViewController:coview animated:NO completion:nil];
    
    
       
    
    
	}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

-(void)successfully
{

    CallCentreViewController *coview=[[CallCentreViewController alloc]init];
    [self presentViewController:coview animated:NO completion:nil];

}


- (void)dealloc {
    [super dealloc];
}



- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[[self view] endEditing:YES];
}

-(BOOL) shouldAutorotate
{

    
    return YES;
}

/*-(NSUInteger) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}*/



@end
