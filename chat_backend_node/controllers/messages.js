import Messages from "../models/messages.js";

const get_messages = async (req, res) => {
  try {
    const my_uid = req.uid;
    const message_from = req.params.from;

    const messages = await Messages.find({
      $or: [
        { from: my_uid, to: message_from },
        { from: message_from, to: my_uid },
      ],
    });
    return res.json({
      ok: true,
      messages,
    });
  } catch (error) {
    return res.status(500).json({
      ok: false,
      msg_error: "Error",
    });
  }
};

export { get_messages };
