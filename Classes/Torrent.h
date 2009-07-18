//
//  Torrent.h
//  rt-phone
//
//  Created by Gavin Gilmour on 18/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLRPCRequest.h"

@interface Torrent : NSObject {
    NSString *name;
    NSString *owner;
    NSString *hash;
    NSString *uri;
    NSString *filename;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *owner;
@property (nonatomic, retain) NSString *uri;
@property (nonatomic, retain) NSString *hash;
@property (nonatomic, retain) NSString *filename;

+ (NSURL *) rtorrentRPCURL;
+ (id) fetchInfo:(NSString *)methodName param:(NSString *)param;
+ (id) executeXMLRPCRequest:(XMLRPCRequest *)req;
+ (void) loadAll;

@end
