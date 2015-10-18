//
//  NSManagedObject+Helper.m
//  Pods
//
//  Created by Aziz U. Latypov on 2/18/15.
//
//

#import "NSManagedObject+Helper.h"
#import "NSManagedObject+MagicalRecord.h"

@implementation NSManagedObject (Helper)

+ (NSEntityDescription*)MR_entityDescriptionWithMangedObjectContext:(NSManagedObjectContext*)managedObjectContext
{
	NSString *entityName = [self MR_entityName];
	NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
											  inManagedObjectContext:managedObjectContext];
	return entity;
}

+ (NSAttributeDescription*)MR_attributeDescription:(NSString*)attributeName fromEntityDescription:(NSEntityDescription*)entityDescription
{
	NSDictionary *availableKeys = [entityDescription attributesByName];
	return [availableKeys valueForKey:attributeName];
}

@end
