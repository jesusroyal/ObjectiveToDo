//
//  ViewController.m
//  ObjectiveToDo
//
//  Created by Mike Shevelinsky on 03.02.2021.
//

#import "MainViewController.h"
#import "Task.h"

@interface MainViewController ()



@end

@implementation MainViewController

NSString *cellId = @"cell";
NSMutableArray<Task *> *array;

- (void)viewDidLoad {
    array = [[NSMutableArray alloc] init];
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellId];
    
    [self setupNavBar];
    
}

- (void)setupNavBar {
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc ] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addItem:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.title = @"Tasks";
}


- (void)pesentNewItemAlert {
    UIAlertController *addAlert = [UIAlertController alertControllerWithTitle:@"Add new Item" message:NULL preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        Task *task = [[Task alloc] initWithName:addAlert.textFields[0].text];
        [array addObject:task];
        [self.tableView reloadData];
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:NULL];
    
    [addAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"Task title";
            textField.textColor = [UIColor blackColor];
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        }];
    
    [addAlert addAction:cancel];
    [addAlert addAction: ok];
    
    
    [self presentViewController:addAlert animated:YES completion:NULL];
}


- (void)presentIsCompleteDialog: (NSInteger)index {
    UIAlertController *addAlert = [UIAlertController alertControllerWithTitle:@"Is this task complete?" message:NULL preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        array[index].isComplete = YES;
        [[self tableView] reloadData];
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:NULL];
    
    [addAlert addAction:cancel];
    [addAlert addAction:ok];
    [self presentViewController:addAlert animated:YES completion:NULL];
}


- (IBAction)addItem:(id)sender {
    [self pesentNewItemAlert ];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [array removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[[NSArray alloc] initWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[self tableView] deselectRowAtIndexPath:indexPath animated:YES];
    [self presentIsCompleteDialog: indexPath.row];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId];
    cell.textLabel.text = array[indexPath.row].name;
    if (array[indexPath.row].isComplete){
        cell.backgroundColor = UIColor.lightGrayColor;
    }
    return cell;
}


@end
