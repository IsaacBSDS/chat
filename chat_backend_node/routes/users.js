import { Router } from "express";
import get_users from "../controllers/users.js";
import { validate_jwt } from "../middlewares/validate_jwt.js";
const usersRoutes = Router();

usersRoutes.get("/", validate_jwt, get_users);

export { usersRoutes };
