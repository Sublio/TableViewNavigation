//
//  DMDirectoryViewController.h
//  TableView Navigation
//
//  Created by sublio on 16/04/16.
//  Copyright (c) 2016 sublio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMDirectoryViewController : UITableViewController

@property (strong, nonatomic) NSString* path;

- (id) initWithFolderPath: (NSString*) path;




@end
