# 使用 Node.js 22 基础镜像（满足项目版本要求）
FROM node:22-bullseye

# 安装 git 和 pnpm（新增 pnpm 安装步骤）
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/* \
    && npm install -g pnpm@latest

# 设置工作目录
WORKDIR /app

# 复制依赖文件
COPY package*.json ./

# 安装项目依赖（用 pnpm 替代 npm，适配项目构建逻辑）
RUN pnpm install

# 复制所有代码
COPY . .

# 构建项目
RUN npm run build

# 暴露端口
EXPOSE 3000

# 启动服务
CMD ["npm", "start"]
