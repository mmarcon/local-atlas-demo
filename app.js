import express from "express";
import { MongoClient } from "mongodb";

const app = express();
const port = process.env.APP_PORT || 3334;
const connectionString = process.env.MONGO_URI;

const client = new MongoClient(connectionString);
let conn;

(async () => {
  try {
    conn = await client.connect();
    console.log("Connected to MongoDB");
    app.get("/", async (req, res) => {
      console.log("GET /");
      let db = conn.db("mflix");
      let collection = db.collection("movies");
      const docs = await collection.aggregate([{$sample: {size: 10}}]).toArray();
      res.json(docs);
    });

    app.listen(port, () => {
      console.log(`Express app listening on port ${port}`);
    });
  } catch (e) {
    console.error(e);
  }
})();
