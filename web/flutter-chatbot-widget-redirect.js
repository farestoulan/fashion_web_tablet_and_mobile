(function () {
  // === SETTINGS ===
  // ضع رابط الشات بوت الخاص بك هنا
  var FLUTTER_CHATBOT_URL = "https://chat-bot-three-tan.vercel.app/"; // Put your chatbot URL here

  // إظهار الزر فقط على الويب (ديسكتوب/تابلت)، إخفاؤه على الموبايل
  function isMobileDevice() {
    return (
      window.innerWidth <= 768 ||
      /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(
        navigator.userAgent
      )
    );
  }

  if (isMobileDevice()) {
    return;
  }

  // === زر الشات العائم (Floating Button) ===
  var chatButton = document.createElement("div");
  chatButton.id = "flutter-chatbot-redirect-button";
  chatButton.innerHTML = "💬";
  chatButton.style.position = "fixed";
  chatButton.style.bottom = "20px";
  chatButton.style.right = "20px";
  chatButton.style.width = "60px";
  chatButton.style.height = "60px";
  chatButton.style.background = "#0084ff";
  chatButton.style.color = "#fff";
  chatButton.style.borderRadius = "50%";
  chatButton.style.display = "flex";
  chatButton.style.alignItems = "center";
  chatButton.style.justifyContent = "center";
  chatButton.style.boxShadow = "0 4px 10px rgba(0,0,0,0.3)";
  chatButton.style.cursor = "pointer";
  chatButton.style.zIndex = "999999";
  chatButton.style.fontSize = "26px";

  function openInNewTab() {
    window.open(FLUTTER_CHATBOT_URL, "_blank");
  }

  function initChatbotRedirect() {
    if (!document.body) {
      setTimeout(initChatbotRedirect, 50);
      return;
    }

    document.body.appendChild(chatButton);
    chatButton.addEventListener("click", openInNewTab);
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", initChatbotRedirect);
  } else {
    initChatbotRedirect();
  }
})();

