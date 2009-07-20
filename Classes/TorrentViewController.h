//
//  TorrentViewController.h
//  rt-phone
//
//  Created by Gavin Gilmour on 20/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Torrent.h";

@interface TorrentViewController : UIViewController {
    Torrent *torrent;
}

@property (nonatomic, retain) Torrent *torrent;

@end
