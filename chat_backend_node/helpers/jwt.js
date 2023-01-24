import jwt from "jsonwebtoken";

const generate_jwt = (uid) => {
  return new Promise((resolve, reject) => {
    const payload = { uid };

    jwt.sign(
      payload,
      process.env.JWT_secret_word,
      {
        expiresIn: "24h",
      },
      (err, token) => {
        if (err) {
          reject("Failed to generate JWT");
        } else {
          resolve(token);
        }
      }
    );
  });
};

const validate_token = (token = "") => {
  try {
    const { uid } = jwt.verify(token, process.env.JWT_secret_word);
    return [true, uid];
  } catch (error) {
    return [false, null];
  }
};

export default generate_jwt;
export { validate_token };
