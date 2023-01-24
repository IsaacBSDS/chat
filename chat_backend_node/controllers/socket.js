import Users from "../models/users.js";

const handle_online_status_of_user = async (uid = "", isConnected = false) => {
  try {
    const user = await Users.findById(uid);
    user.online = isConnected;
    await user.save();
    return user;
  } catch (error) {
    console.log(error);
  }
};

export default handle_online_status_of_user;
