/*
 *  LoginWindow.h
 *  VidyoClientSample_iOS
 *
 *  Created by Chetan Gandhi on 08/19/11.
 *  Copyright 2011 Vidyo Inc. All rights reserved.
 *
 */

#import <UIKit/UIKit.h>


@interface LoginWindow : UIViewController 
{

    IBOutlet UITextField *usernameField;
    IBOutlet UITextField *passwordField;
    
    //IBOutlet UIButton *buttontestURI;
    
	
    BOOL isSigningIn;
    UIAlertView *signingInAlert;
}



@property                    BOOL isInCall;

@property                    BOOL isSigningIn;


@property(nonatomic, retain) UIAlertView *signingInAlert;

- (IBAction)buttonPressed:(id)sender;


@end
