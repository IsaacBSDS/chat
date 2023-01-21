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
    console.log("error create user");
    console.log(error);
    return res.json({
      ok: false,
      msg_error: "There is a error. Try again later.",
    });
  }
};

const login = async (req, res = response) => {
  try {
    const { username, password } = req.body;

    let user = await Users.findOne({ username });

    if (!user) {
      return res.status(404).json({ ok: false, msg: "user is not found" });
    }

    const validPassword = bcrypt.compareSync(password, user.password);

    if (!validPassword) {
      return res.status(400).json({ ok: false, msg: "password is wrong" });
    }

    const token = await generate_jwt(user.id);

    return res.json({ ok: true, user, token });
  } catch (error) {
    console.log("error login user");

    console.log(error);

    return res.status(500).json({
      ok: false,
      msg_error: "There is a error. Try again later.",
    });
  }
};

const renew_token = async (req, res) => {
  try {
    const uid = req.uid;
    const token = await generate_jwt(uid);
    let user = await Users.findById(uid);
    return res.json({ ok: true, user, token });
  } catch (error) {
    console.log("error renew user");

    console.log(error);
    return res.status(500).json({
      ok: false,
      msg_error: "There is a error. Try again later.",
    });
  }
};

export { create_user, login, renew_token };
