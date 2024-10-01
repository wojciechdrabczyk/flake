# Flake

Nix flake I configure my hosts with.

## Initial Setup
```
sudo nixos-rebuild switch --flake github:wojciechdrabczyk/flake#wsl
```

## Generate SSH key
```console
./ssh.sh
```

## Generate Users for MySQL
```console
sudo mysql_secure_installation

VALIDATE PASSWORD COMPONENT - N
Remove anonymous users? - Y
Disallow root login remotely? - N
Remove test database and access to it? - Y
Reload privilege tables now? - Y
```