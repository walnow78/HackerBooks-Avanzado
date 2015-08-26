// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to POLImage.m instead.

#import "_POLImage.h"

const struct POLImageAttributes POLImageAttributes = {
	.file = @"file",
};

const struct POLImageRelationships POLImageRelationships = {
	.book = @"book",
	.locatation = @"locatation",
	.note = @"note",
};

@implementation POLImageID
@end

@implementation _POLImage

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Image" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Image";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Image" inManagedObjectContext:moc_];
}

- (POLImageID*)objectID {
	return (POLImageID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic file;

@dynamic book;

@dynamic locatation;

@dynamic note;

@end

