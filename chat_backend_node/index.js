import express from "express";
import { Server } from "socket.io";
import dbConnection from "./database/config.js";
import { field_validator } from "./middlewares/field_validator.js";
import { router } from "./routes/auth.js";

dbConnection();
const app = express();

app.set("port", process.env.PORT || 3000);

app.use(express.json());

//server
const server = app.listen(app.get("port"), () => {
  console.log("server on port:", app.get("port"));
});

// Routes

app.use("/api/login", router);

//socket conf
const io = new Server(server);

//WebSocket
io.on("connection", (socket) => {
  console.log("new connection");
});
