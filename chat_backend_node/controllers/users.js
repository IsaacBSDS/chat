import { response } from "express";
import Users from "../models/users.js";

const get_users = async (req, res = response) => {
  const from = Number(req.query.from) || 0;
  try {
    const users = await Users.find({ _id: { $ne: req.uid } })
      .sort("-online")
      .skip(from)
      .limit(20);
    return res.json({
      ok: true,
      count: users.length,
      users,
      from,
    });
  } catch (error) {
    return res.status(500).json({
      ok: false,
      msg_error: "Error",
    });
  }
};

export default get_users;
