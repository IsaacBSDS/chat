import express from "express";
import { Server } from "socket.io";
import dbConnection from "./database/config.js";
import { authRoutes } from "./routes/auth.js";
import dotenv from "dotenv";
import path from "path";
import * as url from "url";
import { createServer } from "http";
import cors from "cors";
dotenv.config();

dbConnection();

const app = express();

app.set("port", process.env.PORT || 3000);

const __dirname = url.fileURLToPath(new URL(".", import.meta.url));

const static_path = path.join(__dirname, "public");

// statics files
app.use(express.static(static_path));

app.use(express.json());

app.use(
  cors({
    origin: "*",
  })
);

//server
const server = createServer(app);

// Routes
app.use("/api/login", authRoutes);

//socket conf
const io = new Server(server);

//WebSocket
io.on("connection", (socket) => {
  console.log("new connection");
  socket.on("disconnect", () => {
    console.log("Disconnected");
  });
});

server.listen(app.get("port"), (err) => {
  if (err) throw new Error(err);
  console.log("Servidor corriendo en puerto", app.get("port"));
});
