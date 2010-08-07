//
//  XMLRPCDelegate.m
//  git-phone
//
//  Created by Gavin Gilmour on 04/05/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "XMLRPCDelegate.h"
#import "Config.h"

@implementation XMLRPCDelegate

- (void)request: (XMLRPCRequest *)request didReceiveResponse: (XMLRPCResponse *)response {
	if ([response isFault]) {
		NSLog(@"Fault code: %@", [response faultCode]);
		
		NSLog(@"Fault string: %@", [response faultString]);
	} else {
		NSLog(@"Parsed response: %@", [response object]);
	}
	

	NSLog(@"Response body: %@", [response body]);
	
	NSArray* arr = (NSArray *)[response object];
	for (NSString *s in arr) {
		NSLog(s);
	}
	
	[[Config instance] setPublicRepositories:arr];
}

- (void)request: (XMLRPCRequest *)request didFailWithError: (NSError *)error { }
- (void)request: (XMLRPCRequest *)request didReceiveAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge {}
- (void)request: (XMLRPCRequest *)request didCancelAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge { }

@end
