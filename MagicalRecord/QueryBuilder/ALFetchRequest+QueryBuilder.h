//
//  NSFetchRequest+QueryBuilder.h
//  Pods
//
//  Created by Aziz U. Latypov on 3/3/15.
//
//

#import <CoreData/CoreData.h>
#import "ALFetchRequest.h"
#import "ALManagedObjectFactory.h"

typedef enum : NSUInteger {
    MR_SUM,
    MR_COUNT,
    MR_MIN,
    MR_MAX,
    MR_AVERAGE
} MR_AGRGATE_FUNCTION;

@interface ALFetchRequest (QueryBuilder)

/**
 Fetch request for query builder. Lets you build a query with selecting only given properties.
 
 @returns Returns fetch request which is used for quiery building.
 
 @param properties Context for fetch request.
 
 @code
 [[Item allInManagedObjectContext:context] properties:@[@"title"]];
 @endcode
 
 Example above collects all @b Items orderd by @em title.
 
 NOTE: Don't use select: with aggreateBy:.
 NOTE: Result type is automaticaly set to NSDictionaryResultType.
 */
- (ALFetchRequest*)MR_properties:(NSArray*)properties;

/**
 Set an @b order for query.
 
 @returns Returns fetch request with sort descriptors set according to description parameter.
 
 @param description Is an array of arrays describing a desired sorting.
 
 @code
 NSArray *items =
 [[Item all] orderedBy:@[
	@["title", kOrderASC],
	@["price", kOrderDESC],
	@["amount"]
 ] execute];
 
 // or
 
 NSArray *items =
 [[[Item all] orderedBy:@[@title", @"amount"]
 ] execute];
 @endcode
 
 Example above collects all @b Items sorted by @em name ASC and @em surname DESC and @em age ASC.
 */
- (ALFetchRequest*)MR_orderedBy:(NSArray*)description;

/**
 Set a @b predicate on query.
 
 @returns Returns fetch request with predicate set accordingly.
 
 @param predicate A predicate format string as for +predicateWithFormat:.
 
 @code
 NSArray *items =
 [[[Item all] where:[NSPredicate predicateWithFormat:@"count > %d",minCount]] execute];
 @endcode
 
 Example above collects all @b Items where count is more than value of variable minCount.
 */
- (ALFetchRequest*)MR_where:(NSPredicate*)predicate;

/**
 Set an aggregator functions on query.
 
 @returns Returns fetch request with aggregations set according to description parameter.
 
 @param description Is an array of arrays describing a desired aggregations.
 Available aggregation functions are
 @b count,
 @b sum,
 @b min,
 @b max,
 @b average,
 @b median.
 
 @code
 NSArray *items =
 [[[Item all] aggregatedBy:@[
	@[kAggregatorCount, @"items"],
	@[kAggregatorSum, @"amount"]
 ]] execute];
 
 NSDictionary *d = [items firstObject];
 [d valueForKey:@"countItems"];
 @endcode
 
 Example above aggregates @b Items and counts @em items ASC and sums @em amount.
 */
- (ALFetchRequest*)MR_aggregatedBy:(NSArray*)description;

/**
 Set grouping on aggregated query.
 
 @returns Returns fetch request with grouping set according to description parameter.
 
 @param description Is an array
 
 @code
 NSArray *items =
 [[[[Item all] aggregatedBy:@[
	@["count:", @"items"],
	@["sum:", @"amount"]
 ]] groupedBy:@[@"county"]
 ] execute];
 
 NSDictionary *d = [items firstObject];
 [d valueForKey:@"countItems"];
 @endcode
 
 Example above aggregates @b Items and counts @em items ASC and sums @em amount and groups by @em county.
 */
- (ALFetchRequest*)MR_groupedBy:(NSArray*)description;

/**
 Set an @em having on aggregated query.
 
 @returns Returns fetch request with having set according to description parameter.
 
 @param predicate Predicate for filtering.
 
 @code
 NSArray *items =
 [[[[Item all] aggregatedBy:@[
	@["count:", @"items"],
	@["sum:", @"amount"]
 ]] groupedBy:@[@"county"]
 ] having:[NSPredicate predicateWithFormat:@"sum > 100"]
 ] execute];
 
 NSDictionary *d = [items firstObject];
 [d valueForKey:@"countItems"];
 @endcode
 
 Example above aggregates @b Items and counts @em items ASC and sums @em amount and groups by @em county.
 */
- (ALFetchRequest*)MR_having:(NSPredicate*)predicate;

/**
 Set limit on query.
 
 @returns Returns fetch request with fetch limit set accordingly.
 
 @param limit A value for fetchLimit.
 
 
 @code
 NSArray *item =
 [[[[Item all] where:[NSPredicate predicateWithFormat:@"title = %@",title]] limit:1] execute];
 @endcode
 
 Example above gets not more than 1 @b Item with given @em title.
 */
- (ALFetchRequest*)MR_limit:(NSInteger)limit;

/**
 Set returnsDistinctResults to YES.
 
 @returns Returns fetch request with only distinct set to YES.
 
 
 @code
 NSArray *item =
 [[[[Item all] where:[NSPredicate predicateWithFormat:@"title = %@",title]] distinct] execute];
 @endcode
 
 Example above gets only distinct @b Item with given @em title.
 */
- (ALFetchRequest*)MR_distinct;

/**
 Set returnsDistinctResults to YES.
 
 @returns Returns fetch request with only distinct set to YES.
 
 
 @code
 NSArray *item =
 [[[[Item all] where:@"title == %@",title] distinct] execute];
 @endcode
 
 Example above gets only distinct @b Item with given @em title.
 */
- (ALFetchRequest*)MR_count;

/**
 Execute given request.
 
 @returns Returns fetch request result (NSArray or NSDictionary).
 
 @code
 NSArray *item =
 [[[[Item all] where:@"title == %@",title] distinct] execute];
 @endcode
 
 Example above gets only distinct @b Item with given @em title.
 */
- (NSArray*)MR_execute;

/**
 Casts a ALFetchRequest to NSFetchRequest.
 
 @returns Returns NSFetchRequest.
 
 @code
 NSFetchRequest *request =
 [[[Item fetchReques] orderBy:@[@"title"]] request];
 @endcode
 
 Example above collects all @b Items orderd by @em title. The default managed context is used.
 */
- (NSFetchRequest *)MR_request;

@end

extern NSString *const kAggregatorSum;
extern NSString *const kAggregatorCount;
extern NSString *const kAggregatorMin;
extern NSString *const kAggregatorMax;
extern NSString *const kAggregatorAverage;
extern NSString *const kAggregatorMedian;

extern NSString *const kOrderASC;
extern NSString *const kOrderDESC;
