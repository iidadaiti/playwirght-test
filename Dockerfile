FROM node:lts-slim as base
ENV PNPM_HOME="/pnpm"
ENV PATH="${PNPM_HOME}:${PATH}"
RUN corepack enable \
    && corepack enable npm pnpm \
    && mkdir -p "${PNPM_HOME}" /home/node/.config/pnpm \
    && echo "store-dir=${PNPM_HOME}" >> /home/node/.config/pnpm/rc \
    && chown -R node:node "${PNPM_HOME}" /home/node/.config

FROM base as dev
COPY --from=base --chown=node:node /home/node/.config/pnpm/rc /home/node/.config/pnpm/rc
RUN apt-get update -qq \
    && pnpm --package=playwright@latest dlx playwright install --with-deps chromium \
    && DEBIAN_FRONTEND=noninteractive apt-get install -qq --no-install-recommends \
    git \
    openssh-server \
    tini \
    && rm -rf /var/lib/apt/lists/*
ENTRYPOINT [ "/usr/bin/tini", "--" ]
USER node
