# ctr-builder 🛠️

A simple, containerized project to download and install the **ctr** binary from **containerd** — with no need to build it manually or install Go or full containerd.

---

## 🚀 How to use

Clone this repository:

```
git clone https://github.com/spurin/ctr-builder.git
cd ctr-builder
```

Run the install script:

```
./install.sh
```

This will:
- 📥 Download and extract the **ctr** binary from the latest containerd release
- 🏗️ Build a minimal container containing just the `ctr` tool
- 🔧 Install `ctr` to `/usr/local/bin` for easy use

---

## ✅ Requirements

- Docker installed and running
- `sudo` privileges for binary installation

---

## 🔧 Configuration

- By default, it installs `ctr` from containerd **v1.7.27**
- To change the version, update `ENV CONTAINERD_VERSION=...` in the Dockerfile

---

## 🧼 Clean

The final image uses `scratch` for a minimal footprint: no extra files, no runtime, just the binary.

---

## 📜 License

MIT
