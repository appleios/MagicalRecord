//
//  _EntityForQueryBuilder.m
//  MagicalRecord
//
//  Created by Aziz Latypov on 18/10/15.
//  Copyright © 2015 Magical Panda Software LLC. All rights reserved.
//

#import "_EntityForQueryBuilder.h"

const struct EntityForQueryBuilderAttributes EntityForQueryBuilderAttributes = {
    .titleAttribute   = @"titleAttribute",
    .priceAttribute   = @"priceAttribute",
    .amountAttribute  = @"amountAttribute",
    .countryAttribute = @"countryAttribute",
};

@implementation EntityForQueryBuilderID
@end

@implementation _EntityForQueryBuilder

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
    NSParameterAssert(moc_);
    return [NSEntityDescription insertNewObjectForEntityForName:@"EntityForQueryBuilder" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
    return @"SingleRelatedEntity";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
    NSParameterAssert(moc_);
    return [NSEntityDescription entityForName:@"EntityForQueryBuilder" inManagedObjectContext:moc_];
}

- (EntityForQueryBuilderID*)objectID {
    return (EntityForQueryBuilderID*)[super objectID];
}

@dynamic titleAttribute;

@dynamic priceAttribute;

@dynamic amountAttribute;

@dynamic contryAttribute;

@end
