//
//  NSManagedObject+Helper.h
//  Pods
//
//  Created by Aziz U. Latypov on 2/18/15.
//
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Helper)

/**
 A class method for getting an EntityDescription.
 
 @param managedObjectContext A context for entity description.
 
 @returns Returns en entity description using entityName method of the class.
 
 @code
 [Item MR_entityDescriptionWithMangedObjectContext:context];
 @endcode
 
 Example above returns NSEntityDescription with entity name @b Item.
 */
+ (NSEntityDescription*)MR_entityDescriptionWithMangedObjectContext:(NSManagedObjectContext*)managedObjectContext;

/**
 A class method for getting attribue description with given @em name from @em entityDescription.
 
 @param attributeName A string with name of the attribute.
 @param entityDescription An entity description for that class.
 
 @returns Returns en entity description using entityName method of the class.
 
 @code
 NSEntityDescription *e = [Item MR_entityDescriptionWithMangedObjectContext:context];
 [Item MR_attributeDescription:@"title" fromEntityDescription:e];
 @endcode
 
 Example above returns Item's NSAttributeDescription for attribute name @b title.
 */
+ (NSAttributeDescription*)MR_attributeDescription:(NSString*)attributeName fromEntityDescription:(NSEntityDescription*)entityDescription;

@end
