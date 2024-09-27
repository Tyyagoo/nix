{ self, ... }: {
  "tyyago@mu" = self.lib.mkHome {
    userName = "tyyago";
    displayName = "Tyyago";
    email = "tyyago.dev@gmail.com";
    host = "mu";
    system = "x86_64-linux";
  };
}
