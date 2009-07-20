//
//  Torrent.m
//  rt-phone
//
//  Created by Gavin Gilmour on 18/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Torrent.h"
#import "Config.h"

#import "XMLRPCRequest.h"
#import "XMLRPCResponse.h"
#import "XMLRPCConnection.h"

@implementation Torrent

@synthesize name;
@synthesize uri;
@synthesize hash;
@synthesize filename;
@synthesize bytesDone;
@synthesize bytesTotal;

+ (NSURL *)rtorrentRPCURL {

    /* Make this configurable in the settings page */
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];  
    NSString *rtorrentRPCURL = [userDefaults stringForKey:@"rtorrentRPCURL"];
    return [NSURL URLWithString: rtorrentRPCURL];
}

+  (id)fetchInfo:(NSString *)methodName param:(NSString *)param {
    XMLRPCRequest *infoRequest = [[XMLRPCRequest alloc] initWithHost:[Torrent rtorrentRPCURL]];
    [infoRequest setMethod:methodName withObject:param];
    [infoRequest setUserAgent:@"rt-phone"];
    NSString *response = [Torrent executeXMLRPCRequest:infoRequest];
    [infoRequest release];  
    return response;
}

+ (id)executeXMLRPCRequest:(XMLRPCRequest *)req {
    XMLRPCResponse *userInfoResponse = [XMLRPCConnection sendSynchronousXMLRPCRequest:req];
    return [userInfoResponse object];
}

+ (void)loadAll {

    NSLog(@"Fetching the torrent list");

    /* Fetch the main download list */
    XMLRPCRequest *request = [[XMLRPCRequest alloc] initWithHost:[Torrent rtorrentRPCURL]];	
    [request setUserAgent:@"rt-phone"];
    [request setMethod:@"download_list" withObject:@"main"];

    NSObject *response = [Torrent executeXMLRPCRequest:request];
    [request release];  

    NSMutableArray *torrents = [[[NSMutableArray alloc] init] autorelease]; 
    NSArray* hashArray = (NSArray *)response;

    /* Loop through the torrents and get more info about them */
    for (NSString *hash in hashArray) {

        /* Extended information about the torrent */
        NSString *name = [self fetchInfo:@"d.get_name" param:hash];
        NSNumber *bytesDone = [self fetchInfo:@"d.get_completed_bytes" param:hash];
        NSNumber *bytesTotal = [self fetchInfo:@"d.get_size_bytes" param:hash];

        Torrent *tempTorrent = [[[Torrent alloc] init] autorelease];
        [tempTorrent setHash:hash];
        [tempTorrent setFilename:name];
        [tempTorrent setBytesDone:bytesDone];
        [tempTorrent setBytesTotal:bytesTotal];
        [torrents addObject:tempTorrent];
    }

    /* Set these torrents in the config */
    [[Config instance] setTorrents:torrents];
}


- (void) dealloc {
    [name release];
    [hash release];
    [filename release];
    [uri release];
    [super dealloc];
}

@end
