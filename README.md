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

## Docker Compose

Refer to `docker-compose.yml` for how things are set up.

Run `docker compose build` to build the local image for the Node.js app.

With `docker compose up` the following happens:

1. the local environment is created, with core DB + Search.
2. Initialization scripts are loaded and run in alphanumerical order from `./init` which is mounted into the container's `/docker-entrypoint-initdb.d`.
3. a `mongo-express` container is started to inspect the database.
4. the local Node.js application is started in its own container.

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
