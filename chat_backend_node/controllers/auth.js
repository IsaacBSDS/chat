import { response } from "express";
import Users from "../models/users.js";
import bcrypt from "bcryptjs";
import generate_jwt from "../helpers/jwt.js";

const create_user = async (req, res = response) => {
  try {
    const { username, password, name } = req.body;
    let email = await Users.findOne({ username });
    if (email) {
      return res
        .status(400)
        .json({ ok: false, msg_error: "Username already exist" });
    }
    const only_used_fields = {
      username,
      password,
      name,
    };
    const user = new Users(only_used_fields);

    // encrypt password
    const salt = bcrypt.genSaltSync();
    user.password = bcrypt.hashSync(password, salt);
    await user.save();

    // generate JWT
    const token = await generate_jwt(user.id);

    res.json({
      ok: true,
      user: user,
      token: token,
    });
  } catch (error) {
    return res.json({
      ok: false,
      msg_error: "There is a error. Try again later.",
    });
  }
};

export { create_user };
