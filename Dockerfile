# 使用 Node.js 22 基础镜像，预装 git
FROM node:22-bullseye

# 安装 git 依赖
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制依赖文件
COPY package*.json ./

# 安装依赖（解决 peer 依赖冲突）
RUN npm install --legacy-peer-deps

# 复制所有代码
COPY . .

# 构建项目
RUN npm run build

# 暴露端口
EXPOSE 3000

# 启动服务
CMD ["npm", "start"]
