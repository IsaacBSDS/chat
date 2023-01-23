const socket = io();

const message = document.getElementById("message");
const username = document.getElementById("username");
const send = document.getElementById("send");
const output = document.getElementById("output");
const actions = document.getElementById("actions");

send.addEventListener("click", () => {
  socket.emit("chat:message", {
    username: username.value,
    message: message.value,
  });

  message.value = "";
});

message.addEventListener("keypress", () => {
  socket.emit("chat:typing", username.value);
});

socket.on("chat:message", (data) => {
  actions.innerHTML = "";
  output.innerHTML += `
    <p>
        <strong>
            ${data.username}: ${data.message}
        </strong>
    </p>
  `;
});

socket.on("chat:typing", (data) => {
  actions.innerHTML = `
    <p><em>${data} is typing a message</em></p>
   `;
});
