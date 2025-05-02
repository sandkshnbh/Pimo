const downloadBtn = document.getElementById('downloadBtn');
const messageEl = document.getElementById('message');
const videoUrlInput = document.getElementById('videoUrl');

downloadBtn.addEventListener('click', () => {
    const videoUrl = videoUrlInput.value.trim();

    if (!videoUrl) {
        messageEl.textContent = 'الرجاء إدخال رابط الفيديو.';
        return;
    }

    // عرض رسالة توضيحية بدلاً من محاولة التحميل
    messageEl.textContent = 'لا يمكن تنفيذ التحميل مباشرة من هنا. هذا الموقع للعرض فقط بسبب قيود تشغيل yt-dlp في المتصفح.';

    // يمكنك هنا إضافة منطق لمحاولة فتح الرابط في نافذة جديدة كحل بديل بسيط،
    // لكن هذا لن يقوم بالتحميل الفعلي باستخدام yt-dlp.
    // مثال:
    // window.open(videoUrl, '_blank');
});