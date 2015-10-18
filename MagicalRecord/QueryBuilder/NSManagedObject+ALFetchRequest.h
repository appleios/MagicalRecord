//
//  NSManagedObject+FetchRequest.h
//  Pods
//
//  Created by Aziz U. Latypov on 3/3/15.
//
//

#import <CoreData/CoreData.h>

@class ALFetchRequest;

@interface NSManagedObject (ALFetchRequest)

/**
 Fetch request for query builder. Lets you build a query.
 
 @returns Returns fetch request which is used for quiery building.
 
 @param managedObjectContext Context for fetch request.
 
 @code
 NSArray *items =
 [[[Item MR_fetchRequestWithManagedObjectContext] orderBy:@[@"title"]] execute];
 @endcode
 
 Example above collects all @b Items orderd by @em title.
 */
+ (ALFetchRequest*)MR_fetchRequestWithManagedObjectContext:(NSManagedObjectContext*)managedObjectContext;

@end
