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

@implementation FirstViewController

@synthesize torrents;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

    /* Grab active torrents immediately and store in config */
    [Torrent loadAll];

    /* Fetch them from the config */
    torrents = [[Config instance] torrents];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recipeCell"];
    if(nil == cell) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"recipeCell"] autorelease];
    }

    cell.text = [(Torrent *)[torrents objectAtIndex:[indexPath row]] filename];
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
