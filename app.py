import os
import yt_dlp
from flask import Flask, request, jsonify, render_template

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/download', methods=['POST'])
def download_video():
    data = request.json
    url = data.get("url")
    
    if not url:
        return jsonify({"message": "يرجى إدخال رابط الفيديو!"}), 400

    download_path = os.path.expanduser("~/Download/Pimo")
    
    if not os.path.exists(download_path):
        os.makedirs(download_path)

    ydl_opts = {
        'format': 'bestvideo+bestaudio/best',
        'outtmpl': os.path.join(download_path, '%(title)s.%(ext)s'),
        'ignoreerrors': True,
        'noplaylist': True,
    }
    
    try:
        with yt_dlp.YoutubeDL(ydl_opts) as ydl:
            ydl.download([url])
        return jsonify({"message": "تم تحميل الفيديو بنجاح!"})
    except yt_dlp.utils.DownloadError:
        return jsonify({"message": "حدث خطأ أثناء التحميل."}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=False)