//
//  AGTCoreDataStack.h
//
//  Created by Fernando Rodríguez Romero on 1/24/13.
//  Copyright (c) 2013 Agbo. All rights reserved.
//

@import Foundation;
@import CoreData;

@class NSManagedObjectContext;

@interface POLCoreDataStack : NSObject

@property (strong, nonatomic, readonly) NSManagedObjectContext *context;

+(NSString *) persistentStoreCoordinatorErrorNotificationName;

+(POLCoreDataStack *) coreDataStackWithModelName:(NSString *)aModelName
                                databaseFilename:(NSString*) aDBName;

+(POLCoreDataStack *) coreDataStackWithModelName:(NSString *)aModelName;

+(POLCoreDataStack *) coreDataStackWithModelName:(NSString *)aModelName
                                     databaseURL:(NSURL*) aDBURL;

-(id) initWithModelName:(NSString *)aModelName
            databaseURL:(NSURL*) aDBURL;

-(void) zapAllData;

-(void) saveWithErrorBlock: (void(^)(NSError *error))errorBlock;

-(NSArray *) executeFetchRequest:(NSFetchRequest *)req
                      errorBlock:(void(^)(NSError *error)) errorBlock;


@end
