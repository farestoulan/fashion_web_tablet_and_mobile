# إصلاح إعدادات Vercel Dashboard

## المشكلة
Vercel يحاول بناء المشروع مرة أخرى رغم أننا بنيناه في GitHub Actions. هذا يحدث لأن إعدادات المشروع في Vercel Dashboard تحتوي على `buildCommand` و `installCommand`.

## الحل: تعديل إعدادات المشروع في Vercel Dashboard

### الخطوات:

1. **اذهب إلى Vercel Dashboard**
   - https://vercel.com/dashboard

2. **اختر مشروعك**
   - `fashion-web-tablet-mobile`

3. **اذهب إلى Settings**
   - اضغط على **Settings** في أعلى الصفحة

4. **اذهب إلى General**
   - من القائمة الجانبية: **General**

5. **عدّل Build & Development Settings**
   - ابحث عن قسم **Build & Development Settings**
   - أو **Framework Preset**

6. **احذف أو اترك فارغاً:**
   - **Framework Preset**: `Other` أو اتركه فارغاً
   - **Build Command**: اتركه **فارغاً** (لا تكتب شيء)
   - **Output Directory**: `build/web`
   - **Install Command**: اتركه **فارغاً** (لا تكتب شيء)
   - **Root Directory**: اتركه فارغاً

7. **احفظ التغييرات**
   - اضغط **Save**

### بعد التعديل:

الآن عندما ترفع على `main`:
- ✅ GitHub Actions سيبني المشروع
- ✅ Vercel سينشر الملفات مباشرة بدون محاولة البناء

## ملاحظة مهمة

إذا لم تستطع تعديل الإعدادات، يمكنك:
1. حذف المشروع من Vercel
2. إنشاء مشروع جديد
3. ربطه بـ GitHub
4. **لا تضيف أي buildCommand أو installCommand**

أو استخدم الطريقة البديلة في الملف التالي.

