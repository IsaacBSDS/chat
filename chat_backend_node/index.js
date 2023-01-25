import express from "express";
import { Server } from "socket.io";
import dbConnection from "./database/config.js";
import { authRoutes } from "./routes/auth.js";
import dotenv from "dotenv";
import path from "path";
import * as url from "url";
import { createServer } from "http";
import cors from "cors";
import { validate_token } from "./helpers/jwt.js";
import handle_online_status_of_user, {
  save_message,
} from "./controllers/socket.js";
import { usersRoutes } from "./routes/users.js";
import { messageRouter } from "./routes/messages.js";
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
app.use("/api/users", usersRoutes);
app.use("/api/messages", messageRouter);

//socket conf
const io = new Server(server);

//WebSocket
io.on("connection", (socket) => {
  console.log("New Connection");
  const [valid, uid] = validate_token(
    socket.handshake.headers["authorization"]
  );
  if (!valid) {
    return socket.disconnect();
  }
  console.log("Client Authenticated");

  handle_online_status_of_user(uid, true).then((value) =>
    socket.broadcast.emit("user_connect", JSON.stringify(value))
  );

  // add user to room
  socket.join(uid);

  // listen message
  socket.on("message", async (payload) => {
    await save_message(payload);
    io.to(payload.to).emit("message", payload);
  });

  socket.on("disconnect", () => {
    handle_online_status_of_user(uid, false).then((value) =>
      socket.broadcast.emit("user_connect", JSON.stringify(value))
    );
    console.log("Disconnected");
  });
});

server.listen(app.get("port"), (err) => {
  if (err) throw new Error(err);
  console.log("Servidor corriendo en puerto", app.get("port"));
});
