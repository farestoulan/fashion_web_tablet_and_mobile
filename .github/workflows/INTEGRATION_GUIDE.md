# دليل إعداد Vercel Integration مع GitHub

## الطريقة 1: إعداد Integration من Vercel Dashboard (الأسهل والأفضل) ⭐

هذه الطريقة أسهل ولا تحتاج إلى إعداد workflow يدوي:

### الخطوات:

1. **اذهب إلى Vercel Dashboard**
   - https://vercel.com/dashboard

2. **اختر مشروعك** `fashion-web-tablet-mobile`
   - أو أنشئ مشروع جديد إذا لم يكن موجوداً

3. **اذهب إلى Settings → Git**
   - أو اضغط على **"Connect Git Repository"** إذا لم يكن متصل

4. **اتصل بمستودع GitHub**
   - اختر **GitHub** كـ Git Provider
   - اختر المستودع: `fashion_international_group`
   - اختر الفرع: `main`

5. **إعداد Build Settings**
   - **Framework Preset**: Other
   - **Build Command**: `flutter build web --release`
   - **Output Directory**: `build/web`
   - **Install Command**: `flutter pub get`

6. **حفظ الإعدادات**
   - Vercel سيقوم تلقائياً بنشر التطبيق عند أي push إلى `main`

### المميزات:
- ✅ لا حاجة لإعداد workflow يدوي
- ✅ لا حاجة لـ Secrets في GitHub
- ✅ Vercel يدير كل شيء تلقائياً
- ✅ يمكنك رؤية الـ deployments مباشرة في Vercel

---

## الطريقة 2: استخدام GitHub Actions Workflow (الطريقة الحالية)

إذا كنت تريد استخدام GitHub Actions، يجب:

1. **إضافة Secrets في GitHub**:
   - Settings → Secrets and variables → Actions
   - أضف: `VERCEL_TOKEN`, `VERCEL_ORG_ID`, `VERCEL_PROJECT_ID`

2. **الـ workflow موجود في**: `.github/workflows/deploy.yml`

---

## أيهما أفضل؟

**استخدم الطريقة 1 (Vercel Integration)** إذا:
- تريد إعداد سريع وبسيط
- لا تريد التعامل مع Secrets
- تريد استخدام واجهة Vercel لإدارة الـ deployments

**استخدم الطريقة 2 (GitHub Actions)** إذا:
- تريد تحكم كامل في عملية البناء
- تريد إضافة خطوات إضافية قبل النشر
- تريد استخدام نفس الـ workflow لعدة بيئات

---

## ملاحظة مهمة

إذا استخدمت **الطريقة 1** (Vercel Integration)، يمكنك:
- حذف ملف `.github/workflows/deploy.yml` (اختياري)
- أو تركه كـ backup للطريقة البديلة

