//
//  DMDirectoryViewController.m
//  TableView Navigation
//
//  Created by sublio on 16/04/16.
//  Copyright (c) 2016 sublio. All rights reserved.
//

#import "DMDirectoryViewController.h"

@interface DMDirectoryViewController ()


@property (strong, nonatomic) NSArray* contents;

@end

@implementation DMDirectoryViewController

- (id) initWithFolderPath: (NSString*) path


{
    
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self){
        
        self.path = path;
    }
    
    return self;
    
}


- (void) setPath:(NSString *)path{
    
    _path = path;
    
    
    NSError* error = nil;
    
    self.contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.path error:&error];
    
    
    if (error) {
        
        
        NSLog(@"%@", [error localizedDescription]);
    }
    
    [self.tableView reloadData];
    
    self.navigationItem.title = [self.path lastPathComponent];
    
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = [self.path lastPathComponent];
    
    if ([self.navigationController.viewControllers count] >1){
        
        UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithTitle:@"BackToRoot" style:UIBarButtonItemStylePlain target:self action:@selector(actionBackToRoot:)];
        
        self.navigationItem.rightBarButtonItem = item;
    }
    
    
    if (!self.path){
        
        
        self.path = @"/Users/robert/Desktop/Projects";
    }
    
    
}

-(void) dealloc {
    
    NSLog(@"controller with path %@ has deallocated", self.path);
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    NSLog(@"path = %@", self.path);
    NSLog(@"view controllers on stack = %d", [self.navigationController.viewControllers count]);
    NSLog(@"index on stack %d", [self.navigationController.viewControllers indexOfObject:self]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark - Actions

-(void) actionBackToRoot: (UIBarButtonItem*) sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}



#pragma  mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.contents count];
}

-(BOOL) isDirectoryAtIndexPath:(NSIndexPath*) indexPath{
    
    
    
    NSString* fileName = [self.contents objectAtIndex:indexPath.row];
    NSString* filePath = [self.path stringByAppendingPathComponent:fileName];
    
    BOOL isDirectory = NO;
    
    [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    
    return isDirectory;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        
    }
    
    NSString* fileName = [self.contents objectAtIndex: indexPath.row];
    
    cell.textLabel.text = fileName;
    
    if([self isDirectoryAtIndexPath:indexPath]){
        
        
        cell.imageView.image = [UIImage imageNamed:@"case-icon.png"];
        
    }else{
        
        cell.imageView.image = [UIImage imageNamed:@"Document-icon.png"];
        
    }
    
    return cell;
}


#pragma  mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if ([self isDirectoryAtIndexPath:indexPath]){
        
        
        NSString* fileName = [self.contents objectAtIndex:indexPath.row];
        NSString* path = [self.path stringByAppendingPathComponent:fileName];
        
        DMDirectoryViewController* vc = [[DMDirectoryViewController alloc]initWithFolderPath:path];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}


@end
