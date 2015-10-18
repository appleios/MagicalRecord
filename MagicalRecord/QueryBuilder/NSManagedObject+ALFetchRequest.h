//
//  NSManagedObject+FetchRequest.h
//  Pods
//
//  Created by Aziz U. Latypov on 3/3/15.
//
//

#import <CoreData/CoreData.h>

@class ALFetchRequest;
@class ALManagedObjectFactory;

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


@interface NSManagedObject (Create)

/**
 A class method for creating new entities.
 
 @returns Returns en entity from caller's class name and intialized accroding to given dictionary.
 
 @code
 Item *item = [Item createWithFields:@{
 @"title":@"ABC",
 @"price":@(100)
 }];
 @endcode
 
 Example above returns object of class Item.
 */
+ (NSManagedObject*)MR_createWithFields:(NSDictionary*)fields usingFactory:(ALManagedObjectFactory*)factory;

@end

@interface NSManagedObject (FetchRequestSingleton)

/**
 Fetch request for query builder. Lets you build a query.
 
 @returns Returns fetch request which is used for quiery building.
 
 @code
 NSArray *items =
 [[[Item all] orderBy:@[@"title"]] execute];
 @endcode
 
 Example above collects all @b Items orderd by @em title.
 */
+ (ALFetchRequest*)MR_all;

/**
 Fetch request for query builder. Synonim for `all' method.
 
 @code
 NSArray *items =
 [[[Item fetch] orderBy:@[@"title"]] execute];
 @endcode
 
 */
+ (ALFetchRequest*)MR_fetch;

@end


@interface NSManagedObject (CreateSingleton)

/**
 A class method for creating new entities.
 
 @returns Returns en entity from caller's class name.
 
 @code
 Item *item = [Item create];
 @endcode
 
 Example above returns object of class Item. For building defaultFactory is used.
 */
+ (NSManagedObject*)MR_create;

/**
 A class method for creating new entities.
 
 @returns Returns en entity from caller's class name and intialized accroding to given dictionary.
 
 @code
 Item *item = [Item createWithFields:@{
 @"title":@"ABC",
 @"price":@(100)
 }];
 @endcode
 
 Example above returns object of class Item. For building defaultFactory is used.
 */
+ (NSManagedObject*)MR_createWithFields:(NSDictionary*)fields;

@end
