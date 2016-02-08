//
//  PTDBeanRemoteFirmwareVersionManager.h
//  Bean Loader
//
//  Created by Zeke Shearer on 12/1/14.
//  Copyright (c) 2014 Punch Through Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTDBean.h"

typedef void(^PTDFirmwareVersionCheckCompletion) (NSString *mostRecentFirmwareVersion, NSError *error);
typedef void (^PTDFirmwareFetchCompletion)(NSString *pathA, NSString *pathB, NSError *error);

@interface PTDBeanRemoteFirmwareVersionManager : NSObject

+ (PTDBeanRemoteFirmwareVersionManager *)sharedInstance;

- (void)checkForNewFirmwareWithCompletion:(PTDFirmwareVersionCheckCompletion)completion;
- (void)fetchFirmwareForVersion:(NSString *)version withCompletion:(PTDFirmwareFetchCompletion)completion;

@end