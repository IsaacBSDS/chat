import Users from "../models/users.js";
import Message from "../models/messages.js";

const handle_online_status_of_user = async (uid = "", isConnected = false) => {
  try {
    const user = await Users.findById(uid);
    user.online = isConnected;
    await user.save();
    return user;
  } catch (error) {
    return res.status(500).json({
      ok: false,
      msg_error: "Error",
    });
  }
};

const save_message = async (payload) => {
  try {
    const message = new Message(payload);
    await message.save();
    return true;
  } catch (error) {
    return false;
  }
};

export default handle_online_status_of_user;
export { save_message };
