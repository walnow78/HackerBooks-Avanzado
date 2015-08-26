// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to POLNoteImage.m instead.

#import "_POLNoteImage.h"

const struct POLNoteImageAttributes POLNoteImageAttributes = {
	.file = @"file",
};

const struct POLNoteImageRelationships POLNoteImageRelationships = {
	.note = @"note",
};

@implementation POLNoteImageID
@end

@implementation _POLNoteImage

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"NoteImage" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"NoteImage";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"NoteImage" inManagedObjectContext:moc_];
}

- (POLNoteImageID*)objectID {
	return (POLNoteImageID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic file;

@dynamic note;

@end

