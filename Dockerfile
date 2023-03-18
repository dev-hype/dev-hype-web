# Install dependencies only when needed
FROM node:16-alpine

RUN apk add --no-cache libc6-compat

WORKDIR /app

COPY . .

RUN npm i -g pnpm
RUN pnpm install --frozen-lockfile

ENV NEXT_TELEMETRY_DISABLED 1
ENV NODE_ENV production

RUN pnpm build

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

USER nextjs

CMD ["pnpm", "start"]
