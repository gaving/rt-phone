//
//  FirstViewController.h
//  rt-phone
//
//  Created by Gavin Gilmour on 13/07/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewController : UIViewController <UITableViewDataSource> {
    NSArray *torrents;
}

@property (nonatomic, retain) NSArray *torrents;

@end
