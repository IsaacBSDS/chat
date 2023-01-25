import { Schema, model } from "mongoose";

const MessagesSchema = Schema(
  {
    from: {
      type: Schema.Types.ObjectId,
      ref: "Users",
      required: true,
    },
    to: {
      type: Schema.Types.ObjectId,
      ref: "Users",
      required: true,
    },
    message: {
      type: String,
      require: true,
    },
  },
  {
    timestamps: true,
  }
);

MessagesSchema.method("toJSON", function () {
  const { __v, _id, password, ...object } = this.toObject();
  return object;
});

export default model("Message", MessagesSchema);
