//
//  SettingControllerViewController.m
//  ToDoList
//
//  Created by Ayra Panganiban on 7/14/14.
//  Copyright (c) 2014 Ayra Panganiban. All rights reserved.
//

#import "SettingControllerViewController.h"

@interface SettingControllerViewController ()
@end



@implementation SettingControllerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Settings";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.btnSelectPhoto];
    [self.view addSubview:self.btnTakePhoto];

    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera."
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20,80,100,100)];
        _imageView.image = [UIImage imageNamed:@"avatar.png"];
    }
    return _imageView;
}


-(UIButton *)btnSelectPhoto{
    if(!_btnSelectPhoto){
        _btnSelectPhoto = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btnSelectPhoto addTarget:self
                 action:@selector(selectPhoto:)
       forControlEvents:UIControlEventTouchUpInside];
        [_btnSelectPhoto setTitle:@" Select Photo " forState:UIControlStateNormal];
        [_btnSelectPhoto setFrame:CGRectMake(_imageView.frame.origin.x, _imageView.frame.origin.y + 110, 200, 50)];
        [_btnSelectPhoto setBackgroundColor:[UIColor blackColor]];
        [_btnSelectPhoto setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnSelectPhoto sizeToFit];
    }
    return _btnSelectPhoto;
}

-(UIButton *)btnTakePhoto{
    if(!_btnTakePhoto){
        _btnTakePhoto = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btnTakePhoto addTarget:self
                            action:@selector(takePhoto:)
                  forControlEvents:UIControlEventTouchUpInside];
        [_btnTakePhoto setTitle:@" Take Photo " forState:UIControlStateNormal];
        [_btnTakePhoto setFrame:CGRectMake(_btnSelectPhoto.frame.origin.x, _btnSelectPhoto.frame.origin.y + 40, 200, 50)];
        [_btnTakePhoto setBackgroundColor:[UIColor blackColor]];
        [_btnTakePhoto setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnTakePhoto sizeToFit];
    }
    return _btnTakePhoto;
}


- (IBAction)takePhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

-(IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    _imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
@end
