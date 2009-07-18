//
//  Config.m
//  rt-phone
//
//  Created by Gavin Gilmour on 18/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Config.h"

@implementation Config

@synthesize torrents;

// Make model a singleton
+ (Config *)instance
{
    static Config *gInstance = NULL;

    @synchronized(self)
    {
        if (gInstance == NULL)
            gInstance = [[self alloc] init];
    }
    return(gInstance);
}

- (void) dealloc {
    [torrents     release];
    [super dealloc];
}

@end
