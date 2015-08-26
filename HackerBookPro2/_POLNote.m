// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to POLNote.m instead.

#import "_POLNote.h"

const struct POLNoteAttributes POLNoteAttributes = {
	.creationDate = @"creationDate",
	.modificationDate = @"modificationDate",
	.text = @"text",
	.title = @"title",
};

const struct POLNoteRelationships POLNoteRelationships = {
	.book = @"book",
	.image = @"image",
	.location = @"location",
};

@implementation POLNoteID
@end

@implementation _POLNote

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Note";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Note" inManagedObjectContext:moc_];
}

- (POLNoteID*)objectID {
	return (POLNoteID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic creationDate;

@dynamic modificationDate;

@dynamic text;

@dynamic title;

@dynamic book;

@dynamic image;

@dynamic location;

@end

