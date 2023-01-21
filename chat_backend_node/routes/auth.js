import { Router } from "express";
import { check } from "express-validator";
import { create_user } from "../controllers/auth.js";
import { field_validator } from "../middlewares/field_validator.js";
const router = Router();

router.post(
  "/new",
  [
    check("name", "name is required").not().isEmpty(),
    check("username", "username is required").not().isEmpty(),
    check("password", "password is required").not().isEmpty(),
  ],
  field_validator,
  create_user
);

export { router };
