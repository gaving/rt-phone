//
//  LeecingViewController.h
//  rt-phone
//
//  Created by Gavin Gilmour on 13/07/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeechingViewController : UIViewController <UITableViewDataSource> {
    NSArray *torrents;
    UIBarButtonItem *refreshButton;
    UIActivityIndicatorView *activityIndicator;
    UITableView *tableView;
}

@property (nonatomic, retain) NSArray *torrents;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *refreshButton;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

- (void)refreshTorrents;
- (void)loadTorrents;
- (IBAction)doRefreshButton;

@end
