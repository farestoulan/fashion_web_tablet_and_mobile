<!-- ## Flutter Web Chatbot Widget (`flutter-chatbot-widget.js`)

This project includes a small JavaScript widget that shows a floating chat button on **desktop / tablet web** and opens your chatbot inside an iframe.

### 1. Configure your chatbot URL

Open `web/flutter-chatbot-widget.js` and set your own chatbot URL:

```javascript
// Put your chatbot URL here
var FLUTTER_CHATBOT_URL = "https://chat-bot-three-tan.vercel.app/";
```

Replace the value with the URL where your chatbot web app is hosted (for example, a Flutter web deployment on Vercel, Firebase Hosting, etc.).

### 2. Include the widget in `index.html`

Make sure your `web/index.html` includes the script after the Flutter bootstrap script:

```html
<body>
  <script src="flutter_bootstrap.js" async></script>
  <script src="flutter-chatbot-widget.js"></script>
</body>
```

When the page loads:

- **On desktop/tablet**: a floating circular chat button (💬) appears at the bottom-right.
- Clicking the button opens/closes a chat window that loads your chatbot in an iframe.
- **On mobile**: the widget automatically **does not initialize** (no button is shown).

### 3. Customization (optional)

Inside `flutter-chatbot-widget.js` you can adjust:

- **Button styles**: color, size, position (e.g. `bottom`, `right`, `background`).
- **Chat window size**: width/height and responsive behavior inside `adjustForScreenSize()`.
- **Title text**: currently set to `"Chatbot"` in the header.

The widget is completely self-contained; you only need to:

1. Set `FLUTTER_CHATBOT_URL`.
2. Ensure the script is loaded in `web/index.html`. -->

---

## How to use the chatbot widget on the web

### First: What is this file?

The `flutter-chatbot-widget.js` file is a small JavaScript snippet that:

- Adds a **floating chat button** at the bottom-right of the page (desktop and tablet browsers only).
- When the button is clicked, it opens a **chat window** that contains an iframe showing your chatbot website.
- On **mobile devices**, the widget detects the device type and does **not** initialize (the button is hidden).

### 1) Copy the files into another project

To use the widget in any Flutter Web project or a regular website:

1. Copy the file `flutter-chatbot-widget.js` into the `web` folder of the new project  
   - Example: `your_new_project/web/flutter-chatbot-widget.js`
2. Make sure you have an `index.html` file in the same folder (`web/index.html`).

### 2) Set your chatbot URL

Open `web/flutter-chatbot-widget.js` in the new project and look for:

```javascript
var FLUTTER_CHATBOT_URL = "https://chat-bot-three-tan.vercel.app/";
```

- Replace `"https://chat-bot-three-tan.vercel.app/"` with the URL of your own chatbot  
  (for example, a Flutter Web project deployed on Vercel, Firebase, or any other hosting).

### 3) Link the script in the web page (`index.html`)

Open `web/index.html` in the new project and make sure you add the script tag inside `<body>`, after the Flutter script (if it exists):

```html
<body>
  <!-- Flutter web bootstrap script -->
  <script src="flutter_bootstrap.js" async></script>

  <!-- Chatbot widget script -->
  <script src="flutter-chatbot-widget.js"></script>
</body>
```

If your project is not Flutter Web (just a plain HTML site), it is enough to include:

```html
<body>
  <!-- Your normal page content here -->

  <!-- Chatbot widget script -->
  <script src="flutter-chatbot-widget.js"></script>
</body>
```

### 4) What happens after running the project?

When you open the site in a browser on a desktop or tablet:

- A blue circular button with a 💬 icon appears at the bottom-right corner.
- When you click the button:
  - A chat window appears above the page.
  - Inside the window there is an iframe that loads the URL you set in `FLUTTER_CHATBOT_URL`.
- There is a (×) button in the chat header to close the window.

On mobile:

- The code checks the screen size and device type.
- If it is a mobile device, the widget **does not initialize** (no button is shown).

### 5) Customizing the design (optional)

You can customize the design inside `flutter-chatbot-widget.js`:

- To change the **button color or position**:
  - Edit properties like `chatButton.style.bottom`, `chatButton.style.right`, `chatButton.style.background`.
- To change the **chat window size**:
  - Adjust the values inside the `adjustForScreenSize()` function (width and height).
- To change the **chat header title**:
  - Look for:
    ```javascript
    title.innerText = "Chatbot";
    ```
    and change the text to whatever fits your project, e.g. `"Support Assistant"`.

### Summary: using it in any new project

1. Copy `flutter-chatbot-widget.js` to the `web` folder of the new project.
2. Set `FLUTTER_CHATBOT_URL` to your chatbot URL.
3. Add:
   ```html
   <script src="flutter-chatbot-widget.js"></script>
   ```
   inside the `<body>` of `index.html`.
4. Run your project on the web, open it in a browser on a desktop or tablet, and you will see the floating chat button ready to use.

## شرح استخدام ودجت الشات بوت على الويب (باللغة العربية)

### أولًا: ما هو هذا الملف؟

ملف `flutter-chatbot-widget.js` عبارة عن كود JavaScript بسيط:

- يضيف **زر شات عائم** في أسفل يمين الشاشة على المتصفح (أجهزة الكمبيوتر والتابلت فقط).
- عند الضغط على الزر، يفتح **نافذة شات** تحتوي على iframe يعرض موقع الشات بوت الخاص بك.
- على **أجهزة الموبايل**، الكود يتعرف تلقائيًا على الجهاز ولا يفعّل الودجت (لا يظهر الزر).

### 1) نسخ الملفات إلى مشروع آخر

لاستخدام الودجت في أي مشروع Flutter Web أو أي موقع عادي:

1. قم بنسخ الملف `flutter-chatbot-widget.js` إلى مجلد `web` في المشروع الجديد  
   - مثال: `your_new_project/web/flutter-chatbot-widget.js`
2. تأكد أن لديك ملف `index.html` في نفس المجلد (`web/index.html`).

### 2) ضبط رابط الشات بوت الخاص بك

افتح الملف `web/flutter-chatbot-widget.js` في المشروع الجديد، وابحث عن السطر:

```javascript
var FLUTTER_CHATBOT_URL = "https://chat-bot-three-tan.vercel.app/";
```

- استبدل الرابط `"https://chat-bot-three-tan.vercel.app/"` برابط الشات بوت الخاص بك  
  (مثلًا رابط مشروع Flutter Web مرفوع على Vercel أو Firebase أو أي استضافة أخرى).

### 3) ربط السكربت مع صفحة الويب (`index.html`)

افتح `web/index.html` في المشروع الجديد، وتأكد من إضافة سطر تحميل السكربت داخل `<body>`، بعد سكربت Flutter (إن وجد):

```html
<body>
  <!-- سكربت تشغيل تطبيق Flutter على الويب -->
  <script src="flutter_bootstrap.js" async></script>

  <!-- سكربت ودجت الشات بوت -->
  <script src="flutter-chatbot-widget.js"></script>
</body>
```

إن لم يكن مشروعك Flutter Web (مجرد موقع HTML عادي)، يكفي أن تضع:

```html
<body>
  <!-- محتوى صفحتك العادي هنا -->

  <!-- سكربت ودجت الشات بوت -->
  <script src="flutter-chatbot-widget.js"></script>
</body>
```

### 4) ماذا سيحدث بعد تشغيل المشروع؟

عند فتح الموقع على المتصفح (كمبيوتر أو تابلت):

- سيظهر زر دائري أزرق يحتوي على أيقونة 💬 في أسفل يمين الصفحة.
- عند الضغط على الزر:
  - تظهر نافذة شات فوق الصفحة.
  - داخل النافذة يوجد iframe يحمّل رابط الشات بوت الذي وضعته في `FLUTTER_CHATBOT_URL`.
- يوجد زر (×) في أعلى نافذة الشات لإغلاقها.

على الموبايل:

- الكود يتحقق من عرض الشاشة ونوع الجهاز.
- إذا كان الجهاز موبايل، **لن يتم تفعيل الودجت** (لن يظهر الزر).

### 5) تعديل التصميم (اختياري)

يمكنك تعديل التصميم من داخل `flutter-chatbot-widget.js`:

- لتغيير **لون الزر** أو مكانه:
  - عدّل الخصائص مثل: `chatButton.style.bottom`, `chatButton.style.right`, `chatButton.style.background`.
- لتغيير **حجم نافذة الشات**:
  - عدّل القيم داخل الدالة `adjustForScreenSize()` (العرض والارتفاع).
- لتغيير **عنوان النافذة**:
  - ابحث عن:
    ```javascript
    title.innerText = "Chatbot";
    ```
    وغيّر النص إلى ما تريد، مثل `"مساعد الدعم"`.

### ملخص استخدامه في أي مشروع جديد

1. انسخ `flutter-chatbot-widget.js` إلى مجلد `web` في المشروع الجديد.
2. عدّل قيمة `FLUTTER_CHATBOT_URL` إلى رابط الشات بوت الخاص بك.
3. أضف السطر:
   ```html
   <script src="flutter-chatbot-widget.js"></script>
   ```
   داخل `<body>` في `index.html`.
4. شغّل مشروعك على الويب، وافتحه من المتصفح على جهاز كمبيوتر/تابلت، وسترى زر الشات العائم جاهزًا للاستخدام.

