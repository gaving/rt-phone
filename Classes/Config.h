//
//  Config.h
//  rt-phone
//
//  Created by Gavin Gilmour on 18/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Config : NSObject {
    NSMutableArray *torrents;
}

@property (copy) NSMutableArray *torrents;

+ (Config *)instance;

@end
