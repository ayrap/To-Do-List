//
//  AddViewController.m
//  ToDoList
//
//  Created by Ayra Panganiban on 7/1/14.
//  Copyright (c) 2014 Ayra Panganiban. All rights reserved.
//

#import "AddViewController.h"
#import "ListTableViewController.h"
#import "AppDelegate.h"
#import "Utility.h"
#import "Item.h"

@interface AddViewController (){
    AppDelegate *appdelegate;
}
@property (strong, nonatomic) UITextView *descriptionText;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UITextField *itemTextField;
@property (strong, nonatomic) UILabel *dueDateLabel;
@property (strong, nonatomic) UIDatePicker *dueDate;
@property (strong, nonatomic) UIButton *doneButton;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@end

@implementation AddViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.itemTextField];
    [self.view addSubview:self.descriptionLabel];
    [self.view addSubview:self.descriptionText];
    [self.view addSubview:self.dueDateLabel];
    [self.view addSubview:self.dueDate];
    [self.view addSubview:self.doneButton];
    
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = appdelegate.managedObjectContext;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([_itemTextField isFirstResponder] && [touch view] != _itemTextField) {
        [_itemTextField resignFirstResponder];
    }
    if ([_descriptionText isFirstResponder] && [touch view] != _descriptionText) {
        [_descriptionText resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

- (IBAction)clickButton:(UIButton *)sender {
  
    /*
    ToDoItem *toDoItem = [[ToDoItem alloc] init];
    toDoItem.itemName = _itemTextField.text;
    toDoItem.itemDescription = _descriptionText.text;
    toDoItem.itemDueDate = [Utility formatDate:_dueDate.date];
    toDoItem.completed = NO;
    
    [appdelegate.toDoItems addObject:toDoItem];
    */

    Item * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Item"
                                                      inManagedObjectContext:self.managedObjectContext];
    newEntry.title = _itemTextField.text;
    newEntry.detail = _descriptionText.text;
    newEntry.dueDate = _dueDate.date;
    newEntry.completed = [NSNumber numberWithBool:NO];
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    [self clearAllText];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(UITextField *)itemTextField {
    _itemTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 30, 250, 30)];
    _itemTextField.textColor = [UIColor colorWithRed:0/256.0 green:84/256.0 blue:129/256.0 alpha:1.0];
    _itemTextField.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    _itemTextField.backgroundColor=[UIColor whiteColor];
    _itemTextField.layer.cornerRadius=8.0f;
    _itemTextField.layer.masksToBounds=YES;
    _itemTextField.layer.borderColor=[[UIColor redColor]CGColor];
    _itemTextField.layer.borderWidth= 1.0f;
    _itemTextField.placeholder=@"Title...";
    return _itemTextField;
}

-(UILabel *)descriptionLabel{
    _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(_itemTextField.frame.origin.x, 70, 250, 20)];
    [_descriptionLabel setText: @"Description:"];
    return _descriptionLabel;
}

-(UITextView *)descriptionText{
    _descriptionText = [[UITextView alloc] initWithFrame:CGRectMake(_descriptionLabel.frame.origin.x, 100, 250, 60)];
    _descriptionText.textColor = [UIColor colorWithRed:0/256.0 green:84/256.0 blue:129/256.0 alpha:1.0];
    _descriptionText.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    _descriptionText.backgroundColor=[UIColor whiteColor];
    _descriptionText.layer.cornerRadius=8.0f;
    _descriptionText.layer.masksToBounds=YES;
    _descriptionText.layer.borderColor=[[UIColor redColor]CGColor];
    _descriptionText.layer.borderWidth= 1.0f;
    return _descriptionText;
}


-(UILabel*)dueDateLabel{
    _dueDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(_descriptionText.frame.origin.x, 170, 250, 20)];
    [_dueDateLabel setText: @"Due Date:"];
    return _dueDateLabel;
}

-(UIDatePicker*)dueDate{

    _dueDate = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,190,0,0)];
    return _dueDate;
}

-(UIButton*)doneButton{
    _doneButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_doneButton addTarget:self
                action:@selector(clickButton:)
      forControlEvents:UIControlEventTouchDown];
    [_doneButton setTitle:@" Done " forState:UIControlStateNormal];
    [_doneButton setFrame:CGRectMake(_dueDateLabel.frame.origin.x, 390, 160, 40)];
    [_doneButton sizeToFit];
    [_doneButton setBackgroundColor:[UIColor blackColor]];
    [_doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return _doneButton;
}

-(void)clearAllText {
    _itemTextField.text = nil;
    _descriptionText.text = nil;
    _dueDate.date = [NSDate date];

}
@end
