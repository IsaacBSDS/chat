import { Router } from "express";
import { get_messages } from "../controllers/messages.js";
import { validate_jwt } from "../middlewares/validate_jwt.js";
const messageRouter = Router();

messageRouter.get("/:from", validate_jwt, get_messages);

export { messageRouter };
