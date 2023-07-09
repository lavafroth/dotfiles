# Compiling the Sponsorblock library

```sh
cd mpv-sponsorblock
cargo build --release --locked
cp ./target/release/libmpv_sponsorblock.so ../mpv/scripts/sponsorblock.so
```
