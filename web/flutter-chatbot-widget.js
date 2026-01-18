(function () {
  // === الإعدادات ===
  // ضع رابط الشات بوت الخاص بك هنا
  var FLUTTER_CHATBOT_URL = "https://chat-bot-three-tan.vercel.app/"; // Put your chatbot URL here
  
  // إظهار الودجت فقط على الويب (ديسكتوب/تابلت)، إخفاؤه على الموبايل
  function isMobileDevice() {
    return window.innerWidth <= 768 || /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
  }
  
  // عدم تهيئة الودجت على أجهزة الموبايل
  if (isMobileDevice()) {
    return;
  }
  
  // === زر الشات العائم (Floating Button) ===
  var chatButton = document.createElement("div");
  chatButton.id = "flutter-chatbot-button";
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
  
  // === صندوق الشات (Chat Container) ===
  var chatContainer = document.createElement("div");
  chatContainer.id = "flutter-chatbot-container";
  chatContainer.style.position = "fixed";
  chatContainer.style.bottom = "90px";
  chatContainer.style.right = "20px";
  chatContainer.style.width = "400px";
  chatContainer.style.height = "550px";
  chatContainer.style.maxWidth = "calc(100vw - 40px)";
  chatContainer.style.maxHeight = "calc(80vh - 100px)";
  
  // Responsive adjustments
  function adjustForScreenSize() {
    if (window.innerWidth < 1024) {
      chatContainer.style.width = "350px";
      chatContainer.style.height = "500px";
    } else {
      chatContainer.style.width = "400px";
      chatContainer.style.height = "550px";
    }
  }
  
  window.addEventListener("resize", adjustForScreenSize);
  adjustForScreenSize();
  chatContainer.style.background = "#ffffff";
  chatContainer.style.borderRadius = "12px";
  chatContainer.style.boxShadow = "0 10px 30px rgba(0,0,0,0.3)";
  chatContainer.style.overflow = "hidden";
  chatContainer.style.display = "none"; // Hidden initially
  chatContainer.style.flexDirection = "column";
  chatContainer.style.zIndex = "999998";
  
  // === هيدر الشات (Chat Header) ===
  var chatHeader = document.createElement("div");
  chatHeader.style.background = "#0084ff";
  chatHeader.style.color = "#fff";
  chatHeader.style.padding = "10px 14px";
  chatHeader.style.display = "flex";
  chatHeader.style.justifyContent = "space-between";
  chatHeader.style.alignItems = "center";
  
  var title = document.createElement("div");
  title.innerText = "Chatbot";
  
  var closeBtn = document.createElement("span");
  closeBtn.innerHTML = "&times;";
  closeBtn.style.cursor = "pointer";
  closeBtn.style.fontSize = "24px";
  
  chatHeader.appendChild(title);
  chatHeader.appendChild(closeBtn);
  
  // === iframe الخاص بالشات بوت ===
  var iframe = document.createElement("iframe");
  iframe.src = FLUTTER_CHATBOT_URL;
  iframe.style.border = "none";
  iframe.style.width = "100%";
  iframe.style.height = "100%";
  
  // === iframe Wrapper ===
  var iframeWrapper = document.createElement("div");
  iframeWrapper.style.flex = "1";
  iframeWrapper.appendChild(iframe);
  
  chatContainer.appendChild(chatHeader);
  chatContainer.appendChild(iframeWrapper);
  
  // === Add elements to the page ===
  // Wait for DOM to be ready
  function initChatbot() {
    if (document.body) {
      document.body.appendChild(chatButton);
      document.body.appendChild(chatContainer);
      
      // === الأحداث (فتح/إغلاق) ===
      // عند الضغط على الزر العائم، يتم فتح/إغلاق نافذة الشات
      var isOpen = false;
      function toggleChat() {
        isOpen = !isOpen;
        chatContainer.style.display = isOpen ? "flex" : "none";
      }
      
      chatButton.addEventListener("click", toggleChat);
      closeBtn.addEventListener("click", toggleChat);
    } else {
      // If body is not ready, wait for it
      setTimeout(initChatbot, 100);
    }
  }
  
  // Initialize when DOM is ready
  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", initChatbot);
  } else {
    initChatbot();
  }
})();
