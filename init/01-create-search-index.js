db.getSiblingDB('mflix')
  .getCollection('movies')
  .createSearchIndex({mappings: {dynamic: true}});