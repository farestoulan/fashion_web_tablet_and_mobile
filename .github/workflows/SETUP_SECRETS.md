# إعداد Secrets في GitHub

## المشكلة الحالية
الـ workflow لا يعمل لأن الـ Secrets غير موجودة في GitHub.

## الحل: إضافة Secrets

### الخطوات:

1. **اذهب إلى مستودعك على GitHub**
   - https://github.com/YOUR_USERNAME/fashion_international_group

2. **اذهب إلى Settings**
   - اضغط على **Settings** في أعلى المستودع

3. **اذهب إلى Secrets**
   - من القائمة الجانبية: **Secrets and variables** → **Actions**

4. **أضف الـ Secrets التالية:**

   اضغط **New repository secret** وأضف:

   #### Secret 1: `VERCEL_TOKEN`
   - **Name**: `VERCEL_TOKEN`
   - **Value**: `kb0puaev8ybtvWEWKcluaJBD`
   - اضغط **Add secret**

   #### Secret 2: `VERCEL_ORG_ID`
   - **Name**: `VERCEL_ORG_ID`
   - **Value**: `team_cciblLiEnlW4r1Av4CMFpz5p`
   - اضغط **Add secret**

   #### Secret 3: `VERCEL_PROJECT_ID`
   - **Name**: `VERCEL_PROJECT_ID`
   - **Value**: `prj_uoBslnvsnwXpiMK231PWBgab6E9o`
   - اضغط **Add secret**

5. **تحقق من الـ Secrets**
   - يجب أن ترى 3 secrets في القائمة:
     - ✅ VERCEL_TOKEN
     - ✅ VERCEL_ORG_ID
     - ✅ VERCEL_PROJECT_ID

## اختبار الـ Workflow

بعد إضافة الـ Secrets:

1. **ارفع أي تغيير بسيط إلى main**
   ```bash
   git add .
   git commit -m "test deployment"
   git push origin main
   ```

2. **تحقق من الـ Workflow**
   - اذهب إلى تبويب **Actions** في GitHub
   - يجب أن ترى workflow جديد اسمه "Deploy to Vercel"
   - اضغط عليه لرؤية التقدم

3. **إذا فشل الـ Workflow - كيفية العثور على الأخطاء:**

   **الخطوة 1: اذهب إلى تبويب Actions**
   - في صفحة المستودع على GitHub، اضغط على **Actions** (في الأعلى بجانب Code, Issues, Pull requests)
   
   **الخطوة 2: اختر الـ Workflow الفاشل**
   - سترى قائمة بجميع الـ workflows
   - ابحث عن "Deploy to Vercel" مع علامة ❌ حمراء (إذا فشل) أو ⏳ صفراء (إذا ما زال يعمل)
   - اضغط على الـ workflow الفاشل
   
   **الخطوة 3: اقرأ الأخطاء**
   - سترى قائمة بالـ jobs (مثل "deploy")
   - اضغط على الـ job الفاشل
   - سترى قائمة بالخطوات (steps)
   - اضغط على الخطوة التي فشلت (ستكون حمراء ❌)
   - اقرأ الرسائل الحمراء في الـ logs
   
   **الأخطاء الشائعة:**
   - ❌ `Secret not found` → الـ Secret غير موجود، أضفه من Settings → Secrets
   - ❌ `Invalid token` → الـ VERCEL_TOKEN غير صحيح
   - ❌ `Project not found` → الـ VERCEL_PROJECT_ID غير صحيح
   - ❌ `Build failed` → مشكلة في بناء Flutter (تحقق من pubspec.yaml)
   
   **الخطوة 4: أصلح المشكلة**
   - إذا كانت المشكلة في Secrets، أضفها أو صححها من Settings → Secrets
   - إذا كانت المشكلة في الكود، أصلحها وارفع مرة أخرى

## ملاحظات

- ⚠️ **لا تضع القيم مباشرة في ملف `.github/workflows/deploy.yml`**
- ✅ **استخدم دائماً Secrets للأمان**
- ✅ **الـ Secrets محمية ولا يمكن لأحد رؤيتها**

