(function () {
  // === الإعدادات ===
  // ضع رابط الشات بوت الخاص بك هنا
  var FLUTTER_CHATBOT_URL = "https://alwidad-chatbot.vercel.app/"; // Put your chatbot URL here

  // اختياري: تنفيذ أكشن عند الضغط على الزر العائم
  // استخدم: window.FlutterChatbotWidget.onButtonClick = function() { ... };
  // أو استمع للحدث: window.addEventListener("flutter-chatbot-button-clicked", function(e) { ... });
  window.FlutterChatbotWidget = window.FlutterChatbotWidget || {};

  // === استدعاء API الشات عند الضغط على الزر العائم ===
  var CHAT_API_URL = "https://3fhnqxqrgtaajgebpjgzeo4pbi0hmrxg.lambda-url.us-east-1.on.aws/api/chat/stream";
  var CHAT_API_INITIAL_QUERY = "هاي"; // الرسالة الأولى المرسلة عند فتح الشات
  var CALL_CHAT_API_ON_BUTTON_CLICK = true; // true = استدعاء الـ API عند الضغط على الزر
  var CHAT_API_ONCE_ONLY = true; // true = تنفيذ الاستدعاء مرة واحدة فقط (أول ضغطة فقط)
  var CHAT_API_DEBUG = true; // true = طباعة رسائل في Console للتحقق من أن الاستدعاء يعمل

  var chatApiAlreadyCalled = false; // تتبع هل تم استدعاء الـ API مسبقاً

  // === استقبال بيانات المستخدم من الـ iframe وحفظها في sessionStorage ===
  window.addEventListener("message", function (event) {
    try {
      var data = typeof event.data === "string" ? JSON.parse(event.data) : event.data;
      if (data && data.type === "chatbot-user-info") {
        sessionStorage.setItem("chatbot_user_name", data.name);
        sessionStorage.setItem("chatbot_user_contact", data.contact);
        if (CHAT_API_DEBUG) console.log("[Chatbot Widget] تم حفظ بيانات المستخدم في sessionStorage:", data.name, data.contact);
      }
    } catch (e) {}
  });

  function callChatStreamAPI(query) {
    if (!CHAT_API_URL || !CALL_CHAT_API_ON_BUTTON_CLICK) return;
    var q = query || CHAT_API_INITIAL_QUERY;
    var body = JSON.stringify({ query: q });
    if (CHAT_API_DEBUG) console.log("[Chat API] إرسال طلب POST، query = " + JSON.stringify(q));
    fetch(CHAT_API_URL, {
      method: "POST",
      headers: {
        "Accept": "text/event-stream",
        "Cache-Control": "no-cache",
        "Connection": "keep-alive",
        "Content-Type": "application/json"
      },
      body: body
    })
      .then(function (response) {
        if (CHAT_API_DEBUG) console.log("[Chat API] الرد وصل، الحالة = " + response.status);
        if (!response.ok) throw new Error("HTTP " + response.status);
        return response.body;
      })
      .then(function (stream) {
        if (!stream) return;
        if (CHAT_API_DEBUG) console.log("[Chat API] بدء استقبال الـ stream");
        var reader = stream.getReader();
        var decoder = new TextDecoder();
        var chunkCount = 0;
        var fullText = "";
        function readChunk() {
          reader.read().then(function (result) {
            if (result.done) {
              if (CHAT_API_DEBUG) {
                console.log("[Chat API] انتهى الـ stream، عدد القطع = " + chunkCount + "، إجمالي الأحرف = " + fullText.length);
                if (fullText.length > 0) console.log("[Chat API] أول 300 حرف من الرد: " + fullText.substring(0, 300));
              }
              return;
            }
            var text = decoder.decode(result.value, { stream: true });
            if (text) {
              fullText += text;
              chunkCount++;
              if (CHAT_API_DEBUG && chunkCount <= 5) {
                var preview = text.length + " حرف";
                if (text.length > 0) preview += " | " + JSON.stringify(text.substring(0, 60)) + (text.length > 60 ? "..." : "");
                console.log("[Chat API] قطعة " + chunkCount + " = " + preview);
              }
              try {
                window.dispatchEvent(new CustomEvent("flutter-chatbot-stream-chunk", { detail: { text: text } }));
              } catch (e) {}
            }
            readChunk();
          }).catch(function (e) {
            if (CHAT_API_DEBUG) console.error("[Chat API] خطأ أثناء القراءة:", e);
          });
        }
        readChunk();
      })
      .catch(function (err) {
        if (CHAT_API_DEBUG) console.error("[Chat API] فشل الطلب:", err.message);
        try {
          window.dispatchEvent(new CustomEvent("flutter-chatbot-stream-error", { detail: { error: err.message } }));
        } catch (e) {}
      });
  }

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
  iframe.setAttribute("allow", "clipboard-read; clipboard-write");
  iframe.style.border = "none";
  iframe.style.width = "100%";
  iframe.style.height = "100%";

  // عند تحميل الـ iframe، إرسال بيانات المستخدم المحفوظة إن وُجدت
  iframe.addEventListener("load", function () {
    var savedName = sessionStorage.getItem("chatbot_user_name");
    var savedContact = sessionStorage.getItem("chatbot_user_contact");
    if (savedName && savedContact) {
      iframe.contentWindow.postMessage(
        JSON.stringify({
          type: "chatbot-saved-user-info",
          name: savedName,
          contact: savedContact
        }),
        "*"
      );
      if (CHAT_API_DEBUG) console.log("[Chatbot Widget] تم إرسال بيانات المستخدم المحفوظة للـ iframe:", savedName, savedContact);
    }
  });
  
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

      function onFloatingButtonClick() {
        var willOpen = !isOpen;
        // استدعاء API الشات عند فتح النافذة (مرة واحدة فقط إن كان CHAT_API_ONCE_ONLY = true)
        if (willOpen) {
          if (CHAT_API_ONCE_ONLY) {
            if (!chatApiAlreadyCalled) {
              chatApiAlreadyCalled = true;
              callChatStreamAPI();
            }
          } else {
            callChatStreamAPI();
          }
        }
        // تنفيذ أكشن المستخدم إن وُجد
        if (typeof window.FlutterChatbotWidget.onButtonClick === "function") {
          window.FlutterChatbotWidget.onButtonClick();
        }
        // حدث مخصص يمكن للصفحة الاستماع له
        try {
          window.dispatchEvent(new CustomEvent("flutter-chatbot-button-clicked", { detail: { open: willOpen } }));
        } catch (e) {}
        toggleChat();
      }

      chatButton.addEventListener("click", onFloatingButtonClick);
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
