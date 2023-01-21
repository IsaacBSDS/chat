import { Router } from "express";
import { check } from "express-validator";
import { create_user, login, renew_token } from "../controllers/auth.js";
import { field_validator } from "../middlewares/field_validator.js";
import { validate_jwt } from "../middlewares/validate_jwt.js";
const authRoutes = Router();

authRoutes.post(
  "/new",
  [
    check("name", "name is required").not().isEmpty(),
    check("username", "username is required").not().isEmpty(),
    check("password", "password is required").not().isEmpty(),
  ],
  field_validator,
  create_user
);

authRoutes.post(
  "/",
  [
    check("username", "username is required").not().isEmpty(),
    check("password", "password is required").not().isEmpty(),
  ],
  field_validator,
  login
);

authRoutes.get("/renew", [validate_jwt], renew_token);

export { authRoutes };
