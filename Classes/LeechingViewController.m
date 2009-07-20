//
//  LeecingViewController.m
//  rt-phone
//
//  Created by Gavin Gilmour on 13/07/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "LeechingViewController.h"
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
    [self refreshTorrents];
}

- (void)refreshTorrents {
    self.activityIndicator.hidden = NO;
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

    self.activityIndicator.hidden = YES;

    [pool release];
}

- (IBAction) doRefreshButton {
    [self refreshTorrents];
}


- (UITableViewCell *)tableView:(UITableView *)mTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    TorrentCell *cell = (TorrentCell *)[mTableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[[TorrentCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }

    Torrent *torrent = (Torrent *)[torrents objectAtIndex:[indexPath row]];

    NSString *bytesDone = [[torrent bytesDone] stringValue];
    NSString *bytesTotal = [[torrent bytesTotal] stringValue];

    cell.primaryLabel.text = [torrent filename];
    cell.secondaryLabel.text = [[NSString alloc] initWithFormat:@"%d/%d", bytesDone, bytesTotal];
    cell.myImageView.image = [UIImage imageNamed:@"image-x-generic.png"];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [torrents count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    /* Display more information about the torrent */
    // TorrentViewController *torrentViewController = [[[TorrentViewController alloc] initWithNibName:@"RepoCommitsView" bu
                                                                                                          // ndle:nil] autorelease];
    // Torrent *torrent = [repositories objectAtIndex:[indexPath row]];

    // [torrentViewController.torrent release];
    // // [torrent.commits release];
    // // [torrent loadCommits];
    // torrentViewController.torrent = torrent;

    // [self.navigationController pushViewController:torrentViewController animated:YES];
    // [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}

@end
