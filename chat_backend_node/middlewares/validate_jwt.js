import jwt from "jsonwebtoken";

const validate_jwt = (req, res, next) => {
  const token = req.header("Authorization");

  if (!token) {
    return res.status(401).json({ ok: false, msg_error: "No Authorization" });
  }

  if (!token.includes("Bearer ")) {
    return res.status(401).json({ ok: false, msg_error: "Invalid token" });
  }

  try {
    const parsed_token = token.replace("Bearer ", "");
    const payload = jwt.verify(parsed_token, process.env.JWT_secret_word);
    req.uid = payload.uid;
  } catch (error) {
    return res.status(401).json({ ok: false, msg_error: "Invalid token" });
  }
  next();
};

export { validate_jwt };
