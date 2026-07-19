FROM debian:bookworm-slim

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=1000

ENV DEBIAN_FRONTEND=noninteractive
ENV MISE_DATA_DIR=/home/${USERNAME}/.local/share/mise
ENV MISE_CONFIG_DIR=/home/${USERNAME}/.config/mise
ENV MISE_DISABLE_TOOLS=1
ENV PATH=/home/${USERNAME}/.local/share/mise/shims:/home/${USERNAME}/.local/bin:${PATH}

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    zsh \
  && rm -rf /var/lib/apt/lists/*

RUN groupadd --gid "${USER_GID}" "${USERNAME}" \
  && useradd --uid "${USER_UID}" --gid "${USER_GID}" -m -s /bin/zsh "${USERNAME}"

RUN curl -fsSL https://mise.run | sh \
  && mv /root/.local/bin/mise /usr/local/bin/mise \
  && chmod 0755 /usr/local/bin/mise

RUN mkdir -p /etc/profile.d \
  && printf '%s\n' \
    'export MISE_DATA_DIR="$HOME/.local/share/mise"' \
    'export MISE_CONFIG_DIR="$HOME/.config/mise"' \
    'export PATH="$HOME/.local/share/mise/shims:$HOME/.local/bin:$PATH"' \
    > /etc/profile.d/mise.sh \
  && chmod 0644 /etc/profile.d/mise.sh

USER ${USERNAME}

WORKDIR /workspaces/boilerplate