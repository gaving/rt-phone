//
//  FirstViewController.m
//  rt-phone
//
//  Created by Gavin Gilmour on 13/07/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "FirstViewController.h"
#import "Config.h"
#import "Torrent.h"
#import "TorrentCell.h"

@implementation FirstViewController

@synthesize torrents;
@synthesize refreshButton;
@synthesize activityIndicator;
@synthesize tableView;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
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
    [Torrent loadAll];

    /* FIXME: Artifical delay */
    sleep(2);

    /* Fetch them from the config */
    torrents = [[Config instance] torrents];

    /* Focus the table now that we have the info */
    [activityIndicator stopAnimating];
    [tableView reloadData];

    self.activityIndicator.hidden = YES;

    [pool release];
}

- (IBAction) doRefreshButton {
    [self refreshTorrents];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    TorrentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[[TorrentCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }

    Torrent *torrent = (Torrent *)[torrents objectAtIndex:[indexPath row]];

    NSNumber *bytesDone = [[torrent bytesDone] stringValue];
    NSNumber *bytesTotal = [[torrent bytesTotal] stringValue];

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
