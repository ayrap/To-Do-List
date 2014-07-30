//
//  SettingsTableViewController.m
//  ToDoList
//
//  Created by Ayra Panganiban on 7/30/14.
//  Copyright (c) 2014 Ayra Panganiban. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "SettingCell.h"

@interface SettingsTableViewController ()
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

-(IBAction)uploadPhoto:(UIButton *)sender {
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle: nil
                                                              delegate: self
                                                     cancelButtonTitle: @"Cancel"
                                                destructiveButtonTitle: nil
                                                     otherButtonTitles: @"Take Photo",
                                   @"Choose Existing Photo", nil];
    
    [actionSheet showFromRect: sender.frame inView: sender.superview animated: YES];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
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

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    SettingCell *cell = (SettingCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    cell.photoView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


@end
