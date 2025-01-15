{ pkgs, ... }: {
  # Use stable channel
  channel = "stable-24.05";

  # Only include essential packages
  packages = [
    # Rust essentials
    pkgs.rustc
    pkgs.cargo
    pkgs.rustfmt
    pkgs.pkg-config
    
    # Build tools
    pkgs.gcc
    pkgs.openssl
    
    # Basic tools
    pkgs.curl
    pkgs.jq
  ];

  # Required environment variables
  env = {
    # Rust source path for rust-analyzer
    RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
    # Add project's bin to PATH
    PATH = ["/workspace/building-on-MANTRA-chain/bin"];
    # Mantra chain configuration
    CHAIN_ID = "mantra-dukong-1";
    TESTNET_NAME = "mantra-dukong";
    DENOM = "uom";
    NODE = "--node https://rpc.dukong.mantrachain.io:443";
    TXFLAG = "--node https://rpc.dukong.mantrachain.io:443 --chain-id mantra-dukong-1 --gas-prices 0.01uom --gas auto --gas-adjustment 1.5";
  };

  # IDE configuration
  idx = {
    # Essential extensions
    extensions = [
      "rust-lang.rust-analyzer"
      "tamasfe.even-better-toml"
    ];

    # Workspace configuration
    workspace = {
      onCreate = {
        # Set up permissions for mantrachaind
        setup = ''
          echo "🔧 Setting up environment..."
          chmod +x /workspace/building-on-MANTRA-chain/bin/mantrachaind
          echo "✅ Setup complete"
        '';
      };
    };
  };
}