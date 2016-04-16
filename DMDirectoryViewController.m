//
//  DMDirectoryViewController.m
//  TableView Navigation
//
//  Created by sublio on 16/04/16.
//  Copyright (c) 2016 sublio. All rights reserved.
//

#import "DMDirectoryViewController.h"

@interface DMDirectoryViewController ()

@property (strong, nonatomic) NSString* path;
@property (strong, nonatomic) NSArray* contents;

@end

@implementation DMDirectoryViewController

- (id) initWithFolderPath: (NSString*) path


{
    
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self){
        
        self.path = path;
        
        
        NSError* error = nil;
        
        self.contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.path error:&error];
        
        
        if (error) {
            
            
            NSLog(@"%@", [error localizedDescription]);
        }
        
    }
    
    return self;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = [self.path lastPathComponent];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
        
        
    }
}


@end
