//
//  SettingsTableViewController.m
//  ToDoList
//
//  Created by Ayra Panganiban on 7/30/14.
//  Copyright (c) 2014 Ayra Panganiban. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "SettingCell.h"
#import "Constants.h"
#import "AppDelegate.h"
#import <MessageUI/MessageUI.h>
#import <FacebookSDK/FacebookSDK.h>
#import <Social/Social.h>

@interface SettingsTableViewController ()<MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>{
    AppDelegate *appdelegate;
}
@end

@implementation SettingsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Settings";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera."
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }

    [self.tableView registerClass:[SettingCell class] forCellReuseIdentifier:@"SettingCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return 1;
    }
    else{
        return 3;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            [cell.btnUploadPhoto addTarget:self action:@selector(uploadPhoto:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:cell.photoView];
            NSString *imagePath = [[NSUserDefaults standardUserDefaults] objectForKey:DEFAULTS_AVATAR_URL];
            if (imagePath) {
                cell.photoView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:imagePath]];
            }
            [cell.contentView addSubview:cell.btnUploadPhoto];
        }
        
    }
    
    if (indexPath.section == 1)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 0)
        {
            [cell.contentView addSubview:cell.feedbackLabel];
        }
        
        if (indexPath.row == 1)
        {
            [cell.contentView addSubview:cell.shareLabel];
        }

        if (indexPath.row == 2)
        {
            [cell.contentView addSubview:cell.logoutLabel];
        }

    }

    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return 100;
    }
    else {
        return 30;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1){
        if(indexPath.row == 0){
            [self sendFeedback:@[@"ayrap@sourcepad.com"]];
        }
        if(indexPath.row == 1){
            UIActionSheet * actionSheet2 = [[UIActionSheet alloc] initWithTitle: nil
                                                                       delegate: self
                                                              cancelButtonTitle: @"Cancel"
                                                         destructiveButtonTitle: nil
                                                              otherButtonTitles: @"Share by Text Message",
                                            @"Share by Email", @"Share via Facebook", @"Share via Twitter", nil];
            actionSheet2.tag = 2;
            [actionSheet2 showInView:self.view];
        }
        if(indexPath.row ==2){
            [appdelegate logoutUser];
        }
    }
}

-(IBAction)uploadPhoto:(UIButton *)sender {
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle: nil
                                                              delegate: self
                                                     cancelButtonTitle: @"Cancel"
                                                destructiveButtonTitle: nil
                                                     otherButtonTitles: @"Take Photo",
                                   @"Choose Existing Photo", nil];
    actionSheet.tag = 1;
    [actionSheet showFromRect: sender.frame inView: sender.superview animated: YES];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch(actionSheet.tag){
        case 1:{
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.allowsEditing = YES;
            picker.delegate = self;
            if (buttonIndex==actionSheet.cancelButtonIndex)
            {
                [actionSheet dismissWithClickedButtonIndex:actionSheet.cancelButtonIndex animated:YES];
                
            }
            else if(buttonIndex==0)
            {
                
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:picker animated:YES completion:NULL];
                
            }
            else if(buttonIndex==1)
            {
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:picker animated:YES completion:NULL];
                
            }
        }
        case 2: {
            if (buttonIndex==actionSheet.cancelButtonIndex)
            {
                [actionSheet dismissWithClickedButtonIndex:actionSheet.cancelButtonIndex animated:YES];
                
            }
            else if(buttonIndex==0)
            {
                [self sendTextMessage:@[@"09065893581"]];
                
            }
            else if(buttonIndex==1)
            {
                [self sendFeedback:@[@"ayrap@sourcepad.com"]];
            }
            else if(buttonIndex==2){
                [self shareViaFacebook];
            }
            else if(buttonIndex==3){
                [self postToTwitter];
            }
        }
    }
}

- (void)shareViaFacebook {
    // Check if the Facebook app is installed and we can present the share dialog
    FBLinkShareParams *params = [[FBLinkShareParams alloc] init];
    params.link = [NSURL URLWithString:@"https://developers.facebook.com/docs/ios/share/"];
    
    // If the Facebook app is installed and we can present the share dialog
    if ([FBDialogs canPresentShareDialogWithParams:params]) {
        [self presentShareFBDialog:params];
    } else {
        [self presentFeedFBDialog];
    }
}

- (void)presentShareFBDialog:(FBLinkShareParams *) params {
    [FBDialogs presentShareDialogWithLink:params.link handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
        if(error) {
            // An error occurred, we need to handle the error
            // See: https://developers.facebook.com/docs/ios/errors
            NSLog(@"Error publishing story: %@", error.description);
        } else {
            // Success
            NSLog(@"result %@", results);
        }
    }];
}

-(void)presentFeedFBDialog {
    // Put together the dialog parameters
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Sharing Tutorial", @"name",
                                   @"Build great social apps and get more installs.", @"caption",
                                   @"Allow your users to share stories on Facebook from your app using the iOS SDK.", @"description",
                                   @"https://developers.facebook.com/docs/ios/share/", @"link",
                                   @"http://i.imgur.com/g3Qc1HN.png", @"picture",
                                   nil];
    
    // Show the feed dialog
    [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                           parameters:params
                                              handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                  if (error) {
                                                      // An error occurred, we need to handle the error
                                                      // See: https://developers.facebook.com/docs/ios/errors
                                                      NSLog(@"Error publishing story: %@", error.description);
                                                  } else {
                                                      if (result == FBWebDialogResultDialogNotCompleted) {
                                                          // User cancelled.
                                                          NSLog(@"User cancelled.");
                                                      } else {
                                                          // Handle the publish feed callback
                                                          NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                          
                                                          if (![urlParams valueForKey:@"post_id"]) {
                                                              // User cancelled.
                                                              NSLog(@"User cancelled.");
                                                              
                                                          } else {
                                                              // User clicked the Share button
                                                              NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                              NSLog(@"result %@", result);
                                                          }
                                                      }
                                                  }
                                              }];
}

// A function for parsing URL parameters returned by the Feed Dialog.
- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    SettingCell *cell = (SettingCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    cell.photoView.image = chosenImage;
    
    NSData *imageData = UIImageJPEGRepresentation(chosenImage, 1);

    NSString *imagePath = [self documentsPathForFileName:[NSString stringWithFormat:@"image_%f.jpg", [NSDate timeIntervalSinceReferenceDate]]];
    
    [imageData writeToFile:imagePath atomically:YES];
    
    [[NSUserDefaults standardUserDefaults] setObject:imagePath forKey:DEFAULTS_AVATAR_URL];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void) sendTextMessage:(NSArray *)recipients {
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
	if([MFMessageComposeViewController canSendText])
	{
		controller.body = @"To-Do List App";
        controller.body = @"Hello!";
		controller.recipients = recipients;
		controller.messageComposeDelegate = self;
		[self dismissViewControllerAnimated:NO completion:nil];
	}
}

- (void) postToTwitter {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Just sharing my Todo app."];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}

- (void) sendFeedback:(NSArray *)recipients
{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailComposeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
        
        [mailComposeViewController setMailComposeDelegate:self];
        
        [mailComposeViewController setToRecipients:recipients];
        
        [mailComposeViewController setSubject:@"ToDoList Feedback"];
        
        [mailComposeViewController setMessageBody:@"This app is helpful." isHTML:NO];
        
        [self presentViewController:mailComposeViewController animated:YES completion:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    if (error) {
        NSLog(@"Mailer Error: %@", error);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
	switch (result) {
		case MessageComposeResultCancelled:
			NSLog(@"Cancelled");
			break;
		case MessageComposeResultFailed:
            NSLog(@"Failed");
			break;
		case MessageComposeResultSent:
        
			break;
		default:
			break;
	}
    
	[self dismissViewControllerAnimated:NO completion:nil];
}

- (NSString *)documentsPathForFileName:(NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:name];
}



@end
