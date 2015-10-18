//
//  NSFetchRequest+QueryBuilder.m
//  Pods
//
//  Created by Aziz U. Latypov on 3/3/15.
//
//

#import "ALFetchRequest+QueryBuilder.h"

#import "NSManagedObject+ALFetchRequest.h"

NSString *const kAggregatorSum = @"sum:";
NSString *const kAggregatorCount = @"count:";
NSString *const kAggregatorMin = @"min:";
NSString *const kAggregatorMax = @"max:";
NSString *const kAggregatorAverage = @"average:";
NSString *const kAggregatorMedian = @"median:";

NSString *const kOrderASC = @"ASC";
NSString *const kOrderDESC = @"DESC";

@implementation ALFetchRequest (QueryBuilder)

- (ALFetchRequest*)MR_properties:(NSArray*)properties
{
	NSArray *properiesToFetch = [self MR_internal_propertiesFromDescription:properties];
	self.resultType = NSDictionaryResultType;
	self.propertiesToFetch = properiesToFetch;
	return self;
}

- (ALFetchRequest*)MR_orderedBy:(NSArray*)description
{
	self.sortDescriptors = [self MR_internal_sortDescriptorsFromDescription:description];
	return self;
}

- (ALFetchRequest*)MR_where:(NSPredicate*)predicate
{
	self.predicate = predicate;
	return self;
}

- (ALFetchRequest*)MR_aggregatedBy:(NSArray*)description
{
	NSArray *aggregators = [self MR_internal_aggregatorsFromDescription:description];
	if (aggregators.count) {
		self.resultType = NSDictionaryResultType;
		[self setPropertiesToFetch:aggregators];
	}
	return self;
}

- (ALFetchRequest*)MR_groupedBy:(NSArray*)description
{
	NSArray *properties = [self MR_internal_propertiesFromDescription:description];
	if (properties.count) {
		self.resultType = NSDictionaryResultType;
		
		NSArray *aggregators = [self propertiesToFetch];
		NSMutableArray *propertiesAndAggregators = [NSMutableArray arrayWithArray:properties];
		[propertiesAndAggregators addObjectsFromArray:aggregators];
		
		[self setPropertiesToGroupBy:properties];
		[self setPropertiesToFetch:propertiesAndAggregators];
	}
	return self;
}

- (ALFetchRequest*)MR_having:(NSPredicate*)predicate
{
	self.havingPredicate = predicate;
	return self;
}

- (ALFetchRequest*)MR_limit:(NSInteger)limit
{
	self.fetchLimit = limit;
	return self;
}

- (ALFetchRequest*)MR_distinct
{
	self.returnsDistinctResults = YES;
	return self;
}

- (ALFetchRequest*)MR_count
{
	[self setResultType:NSCountResultType];
	return self;
}

- (NSArray*)MR_execute
{
	NSError *error;
	NSManagedObjectContext *managedObjectContext = self.MR_managedObjectContext;
	NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:self error:&error];
	if (!fetchedObjects || error) {
		NSLog(@"Error: Execution of the fetchRequest: %@, Failed with Description: %@",self,error);
	}
	return fetchedObjects;
}

- (NSFetchRequest *)MR_request
{
	return (NSFetchRequest*)self;
}

#pragma mark - Helpers -

- (NSArray*)MR_internal_sortDescriptorsFromDescription:(NSArray*)description
{
	NSMutableArray *sortDescriptors = [NSMutableArray new];
	for (id desc in description) {
		if(![desc respondsToSelector:@selector(count)] &&
		   ![desc respondsToSelector:@selector(objectAtIndex:)] &&	// not an Array
		   ![desc isKindOfClass:NSString.class])					// and not a String
			continue;
		
		NSString *by = nil;
		NSString *ascString = nil;
		NSNumber *asc = nil;
		
		if ([desc respondsToSelector:@selector(count)] &&
			[desc respondsToSelector:@selector(objectAtIndex:)]) {	// is an Array
			NSArray *a = (NSArray*)desc;
			if (a.count) {
				if ([a.firstObject isKindOfClass:NSString.class]) {
					by = a.firstObject;
				}
				if (a.count > 1) {
					ascString = [a  objectAtIndex:1];
					asc = @([ascString isEqualToString:kOrderASC]);
				}
			}
		}else if ([desc isKindOfClass:NSString.class]){
			by = (NSString*)desc;
			asc = @(YES);
		}
		[sortDescriptors addObject:[NSSortDescriptor sortDescriptorWithKey:by
																 ascending:asc.boolValue]];
	}
	return [sortDescriptors copy];
}

- (NSArray*)MR_internal_propertiesFromDescription:(NSArray*)description
{
	NSMutableArray *properties = [NSMutableArray new];
	for (NSString *field in description) {
        NSString *entityName = [self entityName];
        NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                                  inManagedObjectContext:self.MR_managedObjectContext];
        
        NSDictionary *availableKeys = [entity attributesByName];
        NSAttributeDescription *fieldDescription = [availableKeys valueForKey:field];
        
        if (![fieldDescription isKindOfClass:NSAttributeDescription.class]) {
            continue;
        }
        
        [properties addObject:fieldDescription];
	}
	return properties;
}

- (NSArray*)MR_internal_aggregatorsFromDescription:(NSArray*)description
{
	NSMutableArray *aggregators = [NSMutableArray new];
	for (NSArray *desc in description) {
		if ([desc respondsToSelector:@selector(count)] &&
			[desc respondsToSelector:@selector(objectAtIndex:)]) {	// is an Array
			if (desc.count > 1) {
				id first, second;
				first = [desc objectAtIndex:0];
				second = [desc objectAtIndex:1];
				
				if (![first isKindOfClass:NSString.class] || ![second isKindOfClass:NSString.class]) {
					continue;
				}
				
				NSString *agr = (NSString*)first;
				NSString *agrName = [agr stringByReplacingOccurrencesOfString:@":" withString:@""];
				
				NSString *field = (NSString*)second;
				NSInteger fieldType = NSUndefinedAttributeType;
				
				NSString *entityName = [self entityName];
				NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
														  inManagedObjectContext:self.MR_managedObjectContext];
				
				NSDictionary *availableKeys = [entity attributesByName];
				NSAttributeDescription *fieldDescription = [availableKeys valueForKey:field];
				
				if (![fieldDescription isKindOfClass:NSAttributeDescription.class]) {
					continue;
				}
				
				fieldType = [fieldDescription attributeType];
				
				NSExpression *fieldExp = [NSExpression expressionForKeyPath:field];
				NSExpression *agrExp = [NSExpression expressionForFunction:agr arguments:@[fieldExp]];
				NSExpressionDescription *resultDescription = [[NSExpressionDescription alloc] init];
				NSString *resultName =
				[NSString stringWithFormat:@"%@%@",agrName,[field capitalizedString]];
				[resultDescription setName:resultName];
				[resultDescription setExpression:agrExp];
				[resultDescription setExpressionResultType:fieldType];
				
				[aggregators addObject:resultDescription];
			}
		}
	}
	return aggregators;
}

@end
