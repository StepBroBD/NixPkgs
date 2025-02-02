{
  lib,
  stdenv,
  darwin,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage rec {
  pname = "darklua";
  version = "0.16.0";

  src = fetchFromGitHub {
    owner = "seaofvoices";
    repo = "darklua";
    rev = "v${version}";
    hash = "sha256-D83cLJ6voLvgZ51qLoCUzBG83VFB3Y7HxuaZHpaiOn4=";
  };

  cargoHash = "sha256-0FQ6b6rT4NKKCWRsLw/olAiwLxSUj3VtxNiHZTGI78o=";

  buildInputs = lib.optionals stdenv.hostPlatform.isDarwin [
    darwin.apple_sdk.frameworks.CoreServices
  ];

  # error: linker `aarch64-linux-gnu-gcc` not found
  postPatch = ''
    rm .cargo/config.toml
  '';

  meta = with lib; {
    description = "Command line tool that transforms Lua code";
    mainProgram = "darklua";
    homepage = "https://darklua.com";
    changelog = "https://github.com/seaofvoices/darklua/blob/${src.rev}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ tomodachi94 ];
  };
}
