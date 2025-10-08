import consumer from "channels/consumer";

const NotificationsChannel = consumer.subscriptions.create("NotificationsChannel", {
  connected() {
    console.log("✅ Connected to NotificationsChannel WebSocket!");
  },

  disconnected() {
    console.log("⚠️ Disconnected from NotificationsChannel WebSocket!");
  },

  received(data) {
    console.log("📩 Received data from ActionCable:", data);

    // Test behavior
    if (data && data.type === "test") {
      alert("🎉 WebSocket test message received from the server!");
    }

    // Your actual logic (you can add this later)
    const badge = document.getElementById("inbox-badge");
    if (!data || !badge) return;

    if (data.type === "message") {
      let count = parseInt(badge.textContent) || 0;
      badge.textContent = count + 1;
      badge.classList.remove("d-none");
    }

    if (data.type === "badge_reset") {
      badge.textContent = "0";
      badge.classList.add("d-none");
    }
  }
});

export default NotificationsChannel;
