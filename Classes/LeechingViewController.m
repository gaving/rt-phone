//
//  LeecingViewController.m
//  rt-phone
//
//  Created by Gavin Gilmour on 13/07/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "LeechingViewController.h"
#import "TorrentViewController.h"
#import "Config.h"
#import "Torrent.h"
#import "TorrentCell.h"

@implementation LeechingViewController

@synthesize torrents;
@synthesize refreshButton;
@synthesize activityIndicator;
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];

    /* Grab the leeching torrents */
    [self refreshTorrents];
}

- (void)refreshTorrents {

    /* Create a new activity item top right */
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIBarButtonItem *activityItem = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
    [activityIndicator release];

    self.navigationItem.rightBarButtonItem = activityItem;

    [activityItem release];
    [activityIndicator startAnimating];

    [NSThread detachNewThreadSelector: @selector(loadTorrents) toTarget:self withObject:nil];
}

- (void)loadTorrents {

    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    /* Grab active torrents immediately and store in config */
    if ([Torrent loadAll] == YES) {

        /* FIXME: Artificial delay */
        sleep(2);

        /* Fetch them from the config */
        torrents = [[Config instance] torrents];
    } else {

        /* Show an error as something is up */
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not connect" message:@"Cannot connect to the rtorrent RPC service. Please check your configuration settings."  delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }

    /* Focus the table now that we have the info */
    [activityIndicator stopAnimating];
    [tableView reloadData];

    [pool release];
}

- (IBAction) doRefreshButton {
    [self refreshTorrents];
}

- (UITableViewCell *)tableView:(UITableView *)mTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    TorrentCell *cell = (TorrentCell *)[mTableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[[TorrentCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }

    Torrent *torrent = (Torrent *)[torrents objectAtIndex:[indexPath row]];
    NSString *bytesDone = [Torrent stringFromFileSize:[[torrent bytesDone] intValue]];
    NSString *bytesTotal = [Torrent stringFromFileSize:[[torrent bytesTotal] intValue]];

    cell.primaryLabel.text = [torrent filename];
    cell.secondaryLabel.text = [NSString stringWithFormat:@"%@/%@", bytesDone, bytesTotal];
    cell.myImageView.image = [UIImage imageNamed:@"image-x-generic.png"];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [torrents count];
}

- (void)tableView:(UITableView *)mTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    /* Display more information about the torrent */
    TorrentViewController *torrentViewController = [[[TorrentViewController alloc] initWithNibName:@"TorrentView" bundle:nil] autorelease];
    Torrent *torrent = (Torrent *)[torrents objectAtIndex:[indexPath row]];

    [torrentViewController.torrent release];
    torrentViewController.torrent = torrent;

    [self.navigationController pushViewController:torrentViewController animated:YES];
    [mTableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}

- (void)dealloc {
    [super dealloc];
}

@end
