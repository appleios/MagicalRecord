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
