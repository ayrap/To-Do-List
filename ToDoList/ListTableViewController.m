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

@interface ListTableViewController ()
{
    AppDelegate *appdelegate;
}
@property (nonatomic, retain) DetailViewController * dvController;
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
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[CustomCell class] forCellReuseIdentifier:@"CustomCell"];
}

- (void) viewDidAppear:(BOOL)animated
{
   //[self.tableView setContentInset:UIEdgeInsetsMake(70, self.tableView.contentInset.left, 70, self.tableView.contentInset.right)];
    [self.tableView reloadData];
   
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
    return [appdelegate.toDoItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    static NSString *CellIdentifier = @"CustomCell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    ToDoItem *toDoItem = [appdelegate.toDoItems objectAtIndex:indexPath.row];
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
    ToDoItem *tappedItem = [appdelegate.toDoItems objectAtIndex:indexPath.row];
    tappedItem.completed = !tappedItem.completed;
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
        [appdelegate.toDoItems removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
    }   
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    ToDoItem *rowObj = [appdelegate.toDoItems objectAtIndex:fromIndexPath.row];
    [appdelegate.toDoItems removeObjectAtIndex:fromIndexPath.row];
    [appdelegate.toDoItems insertObject:rowObj atIndex:toIndexPath.row];
}

- (void)willTransitionToState:(UITableViewCellStateMask)state {
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
