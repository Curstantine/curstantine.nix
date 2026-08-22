# `alice` server host

`hardware-configuration.nix` is deliberately not committed here: it contains
machine-specific boot modules, filesystems, and disk UUIDs.

On the server, create it with:

```sh
sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
```

Copy that file to `alice/hardware-configuration.nix` in this repository, then
add your SSH public key to `users.users.curstantine.openssh.authorizedKeys.keys`
in `configuration.nix`. Only after a key has been deployed should you disable
SSH password authentication.

Build or switch this host with:

```sh
sudo nixos-rebuild switch --flake .#alice
```

The flake output name (`alice`) is the name following `#`; it does not have to
match `networking.hostName`, though keeping both as `alice` avoids confusion.
