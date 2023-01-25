import Messages from "../models/messages.js";

const get_messages = async (req, res) => {
  try {
    const my_uid = req.uid;
    const message_from = req.params.from;

    const last_30 = await Messages.find({
      $or: [
        { from: my_uid, to: message_from },
        { from: message_from, to: my_uid },
      ],
    })
      .sort({ createdAt: "desc" })
      .limit(30);

    return res.json({
      ok: true,
      last_30,
    });
  } catch (error) {
    return res.status(500).json({
      ok: false,
      msg_error: "Error",
    });
  }
};

export { get_messages };
