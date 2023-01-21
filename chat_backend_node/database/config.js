import mongoose from "mongoose";

const dbConnection = async () => {
  try {
    mongoose.connect(
      "mongodb+srv://root:pass@cluster0.uibresk.mongodb.net/chat?retryWrites=true&w=majority"
    );
    mongoose.set("strictQuery", true);
  } catch (error) {
    console.error(error);
    throw new Error("Error in database.");
  }
};

export default dbConnection;
