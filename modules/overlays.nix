{ inputs, ... }: {
  nixpkgs.overlays = [
    inputs.melody.overlays.default
    inputs.colorctl.overlays.default
    inputs.creativocode.overlays.default
  ];
}
