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

export default generate_jwt;
