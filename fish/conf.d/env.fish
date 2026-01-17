set -gx EDITOR /usr/bin/nvim
set -gx XDG_CONFIG_HOME $HOME/.config/
set -gx DOCKER_HOST unix://$XDG_RUNTIME_DIR/podman/podman.sock
set -gx PODMAN_COMPOSE_WARNING_LOGS false
