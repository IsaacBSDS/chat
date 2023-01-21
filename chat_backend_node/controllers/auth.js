import { response } from "express";
import mongoose from "mongoose";
import Users from "../models/users.js";

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
    await user.save();
    res.json({
      ok: true,
      msg: user,
    });
  } catch (error) {
    return res.json({
      ok: false,
      msg_error: "There is a error. Try again later.",
    });
  }
};

export { create_user };
