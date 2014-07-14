//
//  ListTableViewController.m
//  ToDoList
//
//  Created by Ayra Panganiban on 7/2/14.
//  Copyright (c) 2014 Ayra Panganiban. All rights reserved.
//

#import "ListTableViewController.h"
#import "AppDelegate.h"
#import "DetailViewController.h"
#import "Item.h"
#import "CustomCell.h"
#import "ToDoItem.h"
#import "Utility.h"

@interface ListTableViewController ()
{
    AppDelegate *appdelegate;
}
- (void)reloadTable;
@property (nonatomic, retain) DetailViewController * dvController;
@property (nonatomic,strong)NSArray* fetchedRecordsArray;
@end

@implementation ListTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"My To-Do List";
        self.tableView.allowsMultipleSelectionDuringEditing = NO;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.fetchedRecordsArray = [appdelegate getAllTodoItems];
    [self reloadTable];

    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[CustomCell class] forCellReuseIdentifier:@"CustomCell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTable)
                                                 name:@"reloadData"
                                               object:nil];

}

- (void) viewDidAppear:(BOOL)animated
{
   //[self.tableView setContentInset:UIEdgeInsetsMake(70, self.tableView.contentInset.left, 70, self.tableView.contentInset.right)];
    self.fetchedRecordsArray = [appdelegate getAllTodoItems];
    [self reloadTable];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //return [appdelegate.toDoItems count];
    return [self.fetchedRecordsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    static NSString *CellIdentifier = @"CustomCell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // comment out to use Core data now
    /*ToDoItem *toDoItem = [appdelegate.toDoItems objectAtIndex:indexPath.row];
    cell.nameLabel.text = toDoItem.itemName;
    cell.descriptionLabel.text = toDoItem.itemDescription;
    cell.dateLabel.text = toDoItem.itemDueDate;
    cell.accessoryButton.tag = indexPath.row;
    [cell.accessoryButton addTarget:self action:@selector(doneButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    if (toDoItem.completed) {
        cell.accessoryCheck.hidden = NO;
    }
    else
    {
        cell.accessoryCheck.hidden = YES;
    }
     */
    Item * record = [self.fetchedRecordsArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = record.title;
    cell.descriptionLabel.text = record.detail;
    cell.dateLabel.text = [Utility formatDate:record.dueDate];
    cell.accessoryButton.tag = indexPath.row;
    if ([record.completed intValue]== 1) {
        cell.accessoryCheck.hidden = NO;
    }
    else
    {
        cell.accessoryCheck.hidden = YES;
    }
    [cell.contentView addSubview:cell.nameLabel];
    [cell.contentView addSubview:cell.descriptionLabel];
    [cell.contentView addSubview:cell.dateLabel];
    [cell.contentView addSubview:cell.accessoryButton];
    [cell.contentView addSubview:cell.accessoryCheck];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    ToDoItem *tappedItem = [appdelegate.toDoItems objectAtIndex:indexPath.row];
//    tappedItem.completed = !tappedItem.completed;
    Item *tappedItem = [self.fetchedRecordsArray objectAtIndex:indexPath.row];
    if([tappedItem.completed intValue] == 1){
        tappedItem.completed = [NSNumber numberWithBool:NO];
    }
    else {
        tappedItem.completed = [NSNumber numberWithBool:YES];
    }
    [appdelegate.managedObjectContext save:nil];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)doneButtonClicked:(UIButton*)sender
{
 
    CGPoint btnRow = [sender convertPoint:CGPointZero
                                           toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:btnRow];
    
    ToDoItem *selectedObj = [appdelegate.toDoItems objectAtIndex:indexPath.row];
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    detailViewController.selectedItem = selectedObj;
    [self.navigationController pushViewController:detailViewController animated:NO];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        /* comment out to use core data now
        [appdelegate.toDoItems removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
         */
        [self.tableView beginUpdates]; // Avoid  NSInternalInconsistencyException
        
        // Delete the role object that was swiped
        Item *itemToDelete = [self.fetchedRecordsArray objectAtIndex:indexPath.row];
        
        //delete notification
        [self deleteLocalNotification:(itemToDelete.title)];
        
        [appdelegate.managedObjectContext deleteObject:itemToDelete];
        [appdelegate.managedObjectContext save:nil];
        
        // Delete the (now empty) row on the table
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        self.fetchedRecordsArray = [appdelegate getAllTodoItems];
        
        [self.tableView endUpdates];
    } else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
    }   
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)reloadTable
{
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
//    ToDoItem *rowObj = [appdelegate.toDoItems objectAtIndex:fromIndexPath.row];
//    [appdelegate.toDoItems removeObjectAtIndex:fromIndexPath.row];
//    [appdelegate.toDoItems insertObject:rowObj atIndex:toIndexPath.row];
    
}

- (void)willTransitionToState:(UITableViewCellStateMask)state {
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)deleteLocalNotification:(NSString *)notification{
    NSArray *arrayOfLocalNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications] ;
    for (UILocalNotification *localNotification in arrayOfLocalNotifications) {
        if ([localNotification.alertBody isEqualToString:notification]) {
            [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
            localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] - 1;
        }
    }

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

@end
