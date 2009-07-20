//
//  TorrentViewController.m
//  rt-phone
//
//  Created by Gavin Gilmour on 20/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TorrentViewController.h"

@implementation TorrentViewController

@synthesize torrent;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [torrent filename];

    /* TODO: Populate all the fancy torrent information here */
    /* Controls for stopping, pausing the torrent etc */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}

- (void)dealloc {
    [torrent release];
    [super dealloc];
}


@end
