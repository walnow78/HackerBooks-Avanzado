// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to POLBook.m instead.

#import "_POLBook.h"

const struct POLBookAttributes POLBookAttributes = {
	.isFavorite = @"isFavorite",
	.title = @"title",
	.urlImage = @"urlImage",
	.urlPdf = @"urlPdf",
};

const struct POLBookRelationships POLBookRelationships = {
	.author = @"author",
	.image = @"image",
	.note = @"note",
	.pdf = @"pdf",
	.tag = @"tag",
};

@implementation POLBookID
@end

@implementation _POLBook

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Book";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Book" inManagedObjectContext:moc_];
}

- (POLBookID*)objectID {
	return (POLBookID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"isFavoriteValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isFavorite"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic isFavorite;

- (BOOL)isFavoriteValue {
	NSNumber *result = [self isFavorite];
	return [result boolValue];
}

- (void)setIsFavoriteValue:(BOOL)value_ {
	[self setIsFavorite:@(value_)];
}

- (BOOL)primitiveIsFavoriteValue {
	NSNumber *result = [self primitiveIsFavorite];
	return [result boolValue];
}

- (void)setPrimitiveIsFavoriteValue:(BOOL)value_ {
	[self setPrimitiveIsFavorite:@(value_)];
}

@dynamic title;

@dynamic urlImage;

@dynamic urlPdf;

@dynamic author;

- (NSMutableSet*)authorSet {
	[self willAccessValueForKey:@"author"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"author"];

	[self didAccessValueForKey:@"author"];
	return result;
}

@dynamic image;

@dynamic note;

- (NSMutableSet*)noteSet {
	[self willAccessValueForKey:@"note"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"note"];

	[self didAccessValueForKey:@"note"];
	return result;
}

@dynamic pdf;

@dynamic tag;

- (NSMutableSet*)tagSet {
	[self willAccessValueForKey:@"tag"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"tag"];

	[self didAccessValueForKey:@"tag"];
	return result;
}

@end

