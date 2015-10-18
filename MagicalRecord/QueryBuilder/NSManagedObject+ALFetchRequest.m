//
//  NSManagedObject+FetchRequest.m
//  Pods
//
//  Created by Aziz U. Latypov on 3/3/15.
//
//

#import "NSManagedObject+ALFetchRequest.h"
#import "NSManagedObject+Helper.h"
#import "ALFetchRequest.h"

#import "NSManagedObject+MagicalRecord.h"
#import "ALManagedObjectFactory.h"

#import "NSManagedObjectContext+MagicalRecord.h"

@implementation NSManagedObject (ALFetchRequest)

+ (ALFetchRequest*)MR_fetchRequestWithManagedObjectContext:(NSManagedObjectContext*)managedObjectContext

{
	ALFetchRequest *fetchRequest = [[ALFetchRequest alloc] init];
	fetchRequest.MR_managedObjectContext = managedObjectContext;
	NSEntityDescription *entity = [self MR_entityDescriptionWithMangedObjectContext:managedObjectContext];
	
	[fetchRequest setEntity:entity];
	[fetchRequest setIncludesPendingChanges:YES];
	
	return fetchRequest;
}

@end

@implementation NSManagedObject (Create)

+ (NSManagedObject*)MR_createWithFields:(NSDictionary*)fields usingFactory:(ALManagedObjectFactory*)factory
{
    NSString *entityName = [self MR_entityName];
    NSManagedObject *object = [factory createObjectForEntityName:entityName];
    
    for (NSString *key in fields) {
        id value = [fields valueForKey:key];
        [object setValue:value
                  forKey:key];
    }
    return object;
}

@end


@implementation NSManagedObject (FetchRequestSingleton)

+ (ALFetchRequest*)MR_all
{
    NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext MR_defaultContext];
    return [self MR_fetchRequestWithManagedObjectContext:managedObjectContext];
}

+ (ALFetchRequest*)MR_fetch
{
    return [self MR_all];
}

@end


@implementation NSManagedObject (CreateSingleton)

+ (NSManagedObject*)MR_createWithFields:(NSDictionary*)fields
{
    ALManagedObjectFactory *factory = [ALManagedObjectFactory defaultFactory];
    return [self MR_createWithFields:fields usingFactory:factory];
}

+ (NSManagedObject *)MR_create
{
    return [self MR_createWithFields:nil];
}

@end
