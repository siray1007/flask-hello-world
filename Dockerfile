FROM python:3.10-slim

# 设置工作目录
WORKDIR /app

# 复制依赖文件并安装
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple/

# 复制项目文件
COPY . .

# 设置环境变量
ENV FLASK_APP=app.py \
    FLASK_RUN_HOST=0.0.0.0 \
    FLASK_ENV=production \
    PYTHONUNBUFFERED=1 \
    PYTHONIOENCODING=utf-8

# 创建非 root 用户并切换
RUN useradd -m flaskuser
USER flaskuser

# 暴露端口
EXPOSE 5000

# 启动命令
CMD ["flask", "run"]