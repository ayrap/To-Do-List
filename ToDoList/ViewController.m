//
//  ViewController.m
//  ToDoList
//
//  Created by Ayra Panganiban on 6/23/14.
//  Copyright (c) 2014 Ayra Panganiban. All rights reserved.
//

#import "ViewController.h"
#import "TabBarController.h"
#import "Constants.h"
#import <FacebookSDK/FacebookSDK.h>

@interface ViewController ()
@property (strong, nonatomic) UILabel *appLabel;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UITextField *nameText;
@property (strong, nonatomic) UIButton *btn;
@property (nonatomic) BOOL isLoggedInToFacebook;
@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.appLabel];
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.nameText];
    [self.view addSubview:self.btn];
    
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), self.btn.frame.origin.y + 100);
    [self.view addSubview:loginView];
    loginView.delegate = self;
    // Facebook login
    loginView.readPermissions = @[@"public_profile", @"email", @"user_photos"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)clickButton:(UIButton *)sender {
    if (_nameText.text.length == 0) {
        [self addAlertView];
    }
    else {
        _appLabel.text = [NSString stringWithFormat:@"%@%@!", @"Hello ", _nameText.text];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:DEFAULTS_USER_DID_SIGN_IN_WITH_FACEBOOK];
        [[NSUserDefaults standardUserDefaults] setObject:_nameText.text forKey:DEFAULTS_SAVED_USER_NAME];
        UITabBarController *tbc = [[TabBarController alloc]
                                   initWithNibName:@"MainTabBarController"
                                   bundle:nil];
        tbc.selectedIndex=0;
        [self presentViewController:tbc animated:YES completion:nil];
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([_nameText isFirstResponder] && [touch view] != _nameText) {
        [_nameText resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}


-(UILabel *)appLabel {
    if(!_appLabel) {
        _appLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 50, 200, 40)];
        [_appLabel setText: @"My To-Do App"];
        [_appLabel setTextColor: [UIColor orangeColor]];
    }
    return _appLabel;
}

-(UILabel *)nameLabel {
    if(!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 200, 30)];
        [_nameLabel setText: @"Enter your Name:"];
    }
    return _nameLabel;
}

-(UITextField *)nameText{
    if(!_nameText){
        _nameText = [[UITextField alloc] initWithFrame:CGRectMake(_nameLabel.frame.origin.x, 140, 260, 40)];
        _nameText.textColor = [UIColor colorWithRed:0/256.0 green:84/256.0 blue:129/256.0 alpha:1.0];
        _nameText.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        _nameText.backgroundColor=[UIColor whiteColor];
        _nameText.placeholder=@"Name...";
        _nameText.layer.cornerRadius=8.0f;
        _nameText.layer.masksToBounds=YES;
        _nameText.layer.borderColor=[[UIColor redColor]CGColor];
        _nameText.layer.borderWidth= 1.0f;
        _nameText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _nameText.textAlignment = NSTextAlignmentCenter;
    }
    return _nameText;
}

-(UIButton *)btn{
    if(!_btn){
        _btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btn addTarget:self
                action:@selector(clickButton:)
      forControlEvents:UIControlEventTouchDown];
        [_btn setTitle:@" Submit " forState:UIControlStateNormal];
        [_btn setFrame:CGRectMake(_nameText.frame.origin.x, 190, 260, 40)];
        [_btn setBackgroundColor:[UIColor blackColor]];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn sizeToFit];
    }
    return _btn;
}

-(void)addAlertView{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                              @"Warning!" message:@"Please enter name" delegate:nil
                                             cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - Facebook login view delegate

// This method will be called when the user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
  
}

// Logged-in user experience
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
}

// Logged-out user experience
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    
}

// Handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}



@end
