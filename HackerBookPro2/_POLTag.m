// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to POLTag.m instead.

#import "_POLTag.h"

const struct POLTagAttributes POLTagAttributes = {
	.name = @"name",
};

const struct POLTagRelationships POLTagRelationships = {
	.book = @"book",
};

@implementation POLTagID
@end

@implementation _POLTag

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Tag" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Tag";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Tag" inManagedObjectContext:moc_];
}

- (POLTagID*)objectID {
	return (POLTagID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic name;

@dynamic book;

- (NSMutableSet*)bookSet {
	[self willAccessValueForKey:@"book"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"book"];

	[self didAccessValueForKey:@"book"];
	return result;
}

@end

