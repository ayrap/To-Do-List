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
                                            @"Share by Email", nil];
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
        }
    }
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
