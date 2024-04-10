# Demo

## Docker run

Run the local environment with core DB + Search with:

```
docker run -p 27017:27017 mongodb/mongodb-atlas-local
```

Connect with `mongosh` with:

```
mongosh "mongodb://localhost/?directConnection=true"
```

## Docker compose

Refer to `docker-compose.yml` for how things are set up.

With `docker compose up` the following happens:

1. the local environment is created, with core DB + Search
2. the `mongosetup` service runs and executes the scripts in `./init`. `.sh` files are executed with `bash`, `.js` files are executed with `mongosh`. This initialization step is defined in `init.sh`.

In this particular example, [00-import-data.sh](init/00-import-data.sh) downloads a JSON file from GitHub and imports it with `mongoimport`. [01-create-search-index.js](init/01-create-search-index.js) then creates a Search index for the imported `mflix.movies` collection.

We can test that the index works with this aggregation:

```javascript
db.getSiblingDB('mflix')
  .getCollection('movies')
  .aggregate([
  {
    $search: {
      index: "default",
      text: {
        query: "corner",
        path: ["title"],
        fuzzy: {
          maxEdits: 2
        }
      }
    }
  }
]);
```
